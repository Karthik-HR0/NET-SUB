# Subdomain Enumeration Script

This Bash script is designed to automate the enumeration of subdomains for a given domain using multiple online sources. It combines data from several tools and APIs to provide a comprehensive list of subdomains. 

## Features

- *Automatic Tool Installation:* Installs necessary tools if not already available.
- *Multiple Sources for Enumeration:*
  - Subfinder
  - Assetfinder
  - crt.sh
  - RapidDNS
  - BufferOver
  - Riddler
  - Jldc
  - Omnisint
- *Comprehensive Output:* Merges results from all tools and eliminates duplicates.
  
## Prerequisites

- Linux environment (Tested on Ubuntu and kali)
- Installed tools:
  - subfinder
  - assetfinder
  - jq
  - curl

These can be automatically installed by the script if they are missing.

## Usage

1. Clone this repository:
   ```bash
   git clone https://github.com/Karthik-HR0/NET-SUB.git
   cd NET-SUB
   chmod +x * NET-SUB.sh
   ./NET-SUB.sh
   
   ```
## demo video 

https://github.com/user-attachments/assets/642fbf8d-5131-48bc-bfc2-42045ee7c056

## example
       
   ``` 
    _   ______________   _____ __  ______ 
   / | / / ____/_  __/  / ___// / / / __ )
  /  |/ / __/   / /_____\__ \/ / / / __  |
 / /|  / /___  / /_____/__/ / /_/ / /_/ / 
/_/ |_/_____/ /_/     /____/\____/_____/  
                                                  
                                      - BY Karthik-HR0 
                                           
                                  
[*] Installing Requirements..please wait !
[!] Enter domain to Enumerate subdomains: hackerone.com
[+] subfinder is already installed.
[+] assetfinder is already installed.
[+] jq is already installed.
[+] curl is already installed.
[*] Subdomain Enumeration started!

[+] Enumerating subdomains from Subfinder ...
[+] Enumerating subdomains from Assetfinder ...
[+] Enumerating subdomains from crt.sh ...
[+] Enumerating subdomains from RapidDNS ...
[+] Enumerating subdomains from BufferOver ...
[+] Enumerating subdomains from Riddler ...
[!] Error fetching from Riddler
[+] Enumerating subdomains from Jldc ...
[+] Enumerating subdomains from Omnisint ...
[!] Error fetching from Omnisint
*.hackerone.com
/subdomain/hackerone.com#result
3d.hackerone.com
a.ns.hackerone.com
api.hackerone.com
b.ns.hackerone.com
design.hackerone.com
docs.hackerone.com
events.hackerone.com
go.hackerone.com
gslink.hackerone.com
hackerone.com
https://hackerone.com/rapiddns
info.hackerone.com
links.hackerone.com
mta-sts.forwarding.hackerone.com
mta-sts.hackerone.com
mta-sts.managed.hackerone.com
resources.hackerone.com
support.hackerone.com
supportahackerone.com
wearehackerone.com
www.hackerone.com
 [*] Subdomain Enumeration Completed! 
[*] Found 23 subdomains for hackerone.com
 [!] View the hackerone.com-all_subdomains.txt file for results!

```

