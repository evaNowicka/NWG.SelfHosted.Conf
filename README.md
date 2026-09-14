# NWG.SelfHosted.Conf

Configuration files to connect a self-hosted OpenSimulator region to the **Neverworld grid**.

## What is this

If you want to run your own OpenSimulator region and have it appear on the Neverworld grid,
you need a few configuration files that differ from a standalone setup. This repository
provides those files along with a step-by-step setup guide.

## Requirements

- .NET 8.0 runtime for your operating system
- On Linux / macOS: `libgdiplus` and related libraries
- An account on the Neverworld grid
- A public IP address or FQDN (static, or via a dynamic DNS service)
- A port open in your firewall / router (default: 9000 UDP+TCP)

## Setup

### 1. Download OpenSimulator

Get the latest release from the official OpenSimulator GitHub repository.
Extract it to a folder of your choice.

### 2. Copy the configuration files

Copy the files from the `bin/` folder of this repository into the `bin/` folder
of your OpenSimulator installation, replacing any existing files with the same name:

- `OpenSim.ini`
- `FlotsamCache.ini`
- `GridCommon.ini`

### 3. Configure your region

Create a `Regions/Region.ini` file (or let OpenSim generate it on first launch
by answering the console prompts). You will need:

| Setting | Value |
|---|---|
| Region name | Your chosen name (unique on the grid) |
| Region UUID | A new UUID — generate one at [uuidgenerator.net](https://www.uuidgenerator.net) |
| Grid coordinates | Provided by the Neverworld administrators |
| InternalAddress | `0.0.0.0` |
| InternalPort | The port you opened (e.g. `9000`) |
| ExternalHostName | Your public IP or FQDN |

Make sure `OpenSim.ini` references the same port (line ~579).

### 4. Launch

- **Windows:** run `OpenSim.exe`
- **Linux / macOS:** run `./opensim.sh`

On first launch OpenSim will ask a few questions if `Region.ini` does not exist yet.

### Troubleshooting

**Region not visible on the grid:**
Verify that the port is reachable from the internet. Use an online port-checker tool
to test from outside your network.

**Cannot connect from the same network as the server:**
Some routers do not support hairpin NAT (loopback). You cannot use your public IP
to access the region from the same LAN. Use the internal IP instead, or enable
NAT loopback in your router if it supports it.

---

## Licensing

This repository uses a dual-license structure because it contains two types of files
with different origins.

| Files | License |
|---|---|
| `README.md`, `readme.first.txt`, and any original documentation or configuration written for this repository | [GNU General Public License v2 or later](LICENSE) |
| Files derived from the OpenSimulator distribution (`OpenSim.ini`, `GridCommon.ini`, `FlotsamCache.ini`, and any other file that originates from the OpenSimulator project) | [BSD 3-Clause License](https://opensource.org/licenses/BSD-3-Clause) |

**Why two licenses?**
The OpenSimulator project is distributed under the BSD 3-Clause License. That license
allows modification but requires that derivative works keep the original license notice.
We cannot relicense those files. Original contributions (documentation, custom configs
written from scratch) are released under GPL v2+ to ensure improvements remain open.

Copyright (c) 2026 eva Nowicka / ENS project
