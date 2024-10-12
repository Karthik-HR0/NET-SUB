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

- Linux environment (Tested on Ubuntu)
- Installed tools:
  - subfinder
  - assetfinder
  - jq
  - curl

These can be automatically installed by the script if they are missing.

## Usage

1. Clone this repository:
   ```bash
   git clone https://github.com/YOUR_USERNAME/your-repo-name.git
   cd your-repo-name
