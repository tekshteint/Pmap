# PMAP
![image](https://img.shields.io/badge/powershell-5391FE?style=for-the-badge&logo=powershell&logoColor=white)

Pmap is a PowerShell-based, multithreaded alternative to Nmap, designed for network port scanning without requiring elevated privileges. This tool is ideal for environments where Nmap is unavailable or restricted, but PowerShell is accessible.

## Features

- **Multithreaded Scanning**: Utilizes multithreading to perform scans efficiently.
- **Flexible Targeting**: Scan one or multiple IP addresses (comma-separated).
- **Quick and Full Scans**: Options for scanning the top 1000 most common ports, a full range (1-65535), or custom ranges.
- **Customizable Scanning**: Define specific ports or ranges to scan using various command-line flags.
- **Verbose Output**: Option to display each port's open or closed status.
- **Platform Compatibility**: Works on any Windows machine with PowerShell, making it a versatile tool for restricted environments.

## Requirements

- **PowerShell 7.0 or later**: The script requires at least PowerShell version 7.0, which is included in most recent Windows installations.
- **No external dependencies**: The script operates independently, without the need for additional tools or modules.

## Installation

Clone the repository or download the script directly:

```bash
git clone https://github.com/tekshteint/Port-Scanner.git
```
## Examples

### Full port scan of multiple targets
`.\portScan.ps1 -targets 10.34.56.66,10.34.56.67`

### Quick scan of the top 1000 most common ports on a single target
`.\portScan.ps1 -targets 10.34.56.66 -quickScan`

### Scan a custom port range (1024 to 2000) on a single target
`.\portScan.ps1 -targets 10.34.56.66 -pMin 1024 -pMax 2000`

### Scan specific ports on a single target
`.\portScan.ps1 -targets 10.34.56.66 -ports 21,22,23,25,80,443,8080,8443`

### Verbose output of each port’s status; redirect output to a text file
`.\portScan.ps1 -targets 10.34.56.66 -verbose *> output.txt`
