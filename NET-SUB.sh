#!/bin/bash

# Define an array of ANSI color codes
colors=(
    "\e[35m"  # Purple
    "\e[31m"  # Red
    "\e[32m"  # Green
    "\e[33m"  # Yellow
    "\e[34m"  # Blue
    "\e[36m"  # Light Blue
    "\e[37m"  # White
    "\e[0m"   # Reset
)

# Function to display the logo with different colors
display_logo() {
    echo -e "${colors[0]}    _   ______________   _____ __  ______ "
    echo -e "${colors[1]}   | / / ____/_  __/  / ___// / / / __ )"
    echo -e "${colors[2]}  /  |/ / __/   / /_____\__ \/ / // / __  |"
    echo -e "${colors[3]} / /|  / /___  / /_____/__/ / /_/ / /_/ / "
    echo -e "${colors[4]} /_/ |_/_____/ /_/     /____/\____/_____/  "
    echo -e "                                           "
    echo -e "${colors[5]}                                  - BY Karthik-HR0 ${colors[7]}"
    echo -e "\e[32m [*] Installing Requirements..please wait !\e[0m"
}

# Function to check and install required tools
install_requirements() {
    # List of required tools
    tools=("subfinder" "assetfinder" "jq" "curl")

    for tool in "${tools[@]}"; do
        if ! command -v "$tool" &> /dev/null; then
            echo -e "${colors[33]}[!] Installing $tool...${colors[0]}"
            case $tool in
                subfinder)
                    sudo apt install subfinder
                    ;;
                assetfinder)
                    sudo apt install assetfinder
                    ;;
                jq)
                    sudo apt-get install -y jq
                    ;;
                curl)
                    sudo apt-get install -y curl
                    ;;
            esac
        else
            echo -e "${colors[32]}[+] $tool is already installed.${colors[0]}"
        fi
    done
}

# Function to display help
display_help() {
    echo "Usage: $0 [options]"
    echo ""
    echo "Options:"
    echo "          NOTHING        "
    echo ""
    echo "Example: $0"
}

# Validate domain format
validate_domain() {
    if ! [[ $1 =~ ^[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$ ]]; then
        echo -e "\e[31mInvalid domain format: $1\e[0m" 1>&2
        exit 1
    fi
}

# Call the logo display function at the beginning
display_logo

# Prompt user for domain input
read -p "[!] Enter domain to Enumerate subdomains: " DOMAIN

# Check if domain is provided
if [ -z "$DOMAIN" ]; then
    echo "Error: Domain not specified." 1>&2
    display_help
    exit 1
fi

# Validate the domain
validate_domain "$DOMAIN"

# Install requirements before starting enumeration
install_requirements

OUTPUT_FILE="${DOMAIN}-all_subdomains.txt"

# Create or clear the output file
> "$OUTPUT_FILE"

# Function to collect domains
collect_domains() {
    echo -e "\e[34m[*] Subdomain Enumeration started!\n\e[0m"

    # Highlighted enumeration code
    for tool in subfinder assetfinder crt.sh rapiddns bufferover riddler jldc omnisint; do
        case $tool in
            subfinder)
                echo -e "\e[32m[+] Enumerating subdomains from Subfinder ...\e[0m"
                if ! subfinder -d "$DOMAIN" -all -recursive  -silent -o temp_subfinder.txt; then
                    echo -e "\e[31m[!] Error running Subfinder\e[0m"
                fi
                ;;
            assetfinder)
                echo -e "\e[32m[+] Enumerating subdomains from Assetfinder ...\e[0m"
                if ! assetfinder --subs-only "$DOMAIN" > temp_assetfinder.txt; then
                    echo -e "\e[31m[!] Error running Assetfinder\e[0m"
                fi
                ;;
            crt.sh)
                echo -e "\e[32m[+] Enumerating subdomains from crt.sh ...\e[0m"
                response=$(curl -s "https://crt.sh/?q=%25.$DOMAIN&output=json")
                if [ -n "$response" ]; then
                    echo "$response" | jq -r '.[].name_value' > temp_crt.txt || {
                        echo -e "\e[31m[!] Invalid JSON response from crt.sh\e[0m"
                    }
                else
                    echo -e "\e[31m[!] No response from crt.sh\e[0m"
                fi
                ;;
            rapiddns)
                echo -e "\e[32m[+] Enumerating subdomains from RapidDNS ...\e[0m"
                if ! curl -s "https://rapiddns.io/subdomain/$DOMAIN" | grep -oP '(?<=href=")[^"]*' | grep "$DOMAIN" > temp_rapiddns.txt; then
                    echo -e "\e[31m[!] Error fetching from RapidDNS\e[0m"
                fi
                ;;
            bufferover)
                echo -e "\e[32m[+] Enumerating subdomains from BufferOver ...\e[0m"
                if ! curl -s "https://dns.bufferover.run/dns?q=$DOMAIN" | jq -r '.FDNS_A[] | .name' > temp_bufferover.txt; then
                    echo -e "\e[31m[!] Error fetching from BufferOver\e[0m"
                fi
                ;;
            riddler)
                echo -e "\e[32m[+] Enumerating subdomains from Riddler ...\e[0m"
                if ! curl -s "https://riddler.io/search/{$DOMAIN}" | grep -oP '(?<=href=")[^"]*' | grep "$DOMAIN" > temp_riddler.txt; then
                    echo -e "\e[31m[!] Error fetching from Riddler\e[0m"
                fi
                ;;
            jldc)
                echo -e "\e[32m[+] Enumerating subdomains from Jldc ...\e[0m"
                if ! curl -s "https://jldc.me/anubis/$DOMAIN" | grep -oP '"domain":"\K[^"]+' > temp_anubis.txt; then
                    echo -e "\e[31m[!] Error fetching from Jldc\e[0m"
                fi
                ;;
            omnisint)
                echo -e "\e[32m[+] Enumerating subdomains from Omnisint ...\e[0m"
                if ! curl -s "https://sonar.omnisint.io/subdomains/$DOMAIN" | jq -r '.[]' > temp_sonar.txt; then
                    echo -e "\e[31m[!] Error fetching from Omnisint\e[0m"
                fi
                ;;
        esac
    done

    # Combine all results into one file
    cat temp_subfinder.txt temp_assetfinder.txt temp_crt.txt temp_rapiddns.txt temp_bufferover.txt temp_riddler.txt temp_anubis.txt temp_sonar.txt | sort | uniq | tee "$OUTPUT_FILE"

    # Clean up temporary files
    rm -f temp_*.txt

    echo -e "\e[32m [*] Subdomain Enumeration Completed! \e[0m"
    echo -e "[*] Found \e[32m$(wc -l < "$OUTPUT_FILE")\e[0m subdomains for $DOMAIN"
    echo -e "\e[32m [!] View the \e[34m$OUTPUT_FILE\e[0m file for results! \e[0m"
}

# Call the function
collect_domains

