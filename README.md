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
- `config-include/FlotsamCache.ini`
- `config-include/GridCommon.ini`
- `config-include/osslEnable.ini`

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

- **Windows:** run `.\opensim.bat`
- **Linux / macOS:** run `./opensim.sh`

On first launch OpenSim will ask a few questions if `Region.ini` does not exist yet.

## Updating an existing installation

1. **Back up first.** In the OpenSim console run `save oar <file>.oar` for each
   region, then stop the simulator with `shutdown` (do not just close the window).
2. Rename the current folder, e.g. `opensim` → `opensim.old`, and extract the
   new release into a fresh `opensim` folder.
3. Copy these from `opensim.old/bin/` into `opensim/bin/`:

   | File / folder | Why |
   |---|---|
   | `OpenSim.ini` | Your simulator settings |
   | `config-include/FlotsamCache.ini`, `GridCommon.ini`, `osslEnable.ini` | Grid connection, cache and OSSL settings |
   | `Regions/*.ini` | Your region definitions |
   | `OpenSim.db` | Region contents: objects, terrain, estate (SQLite) |
   | `ScriptEngines/` | Script states (optional; without it scripts restart fresh) |
   | `assetcache/` | Asset cache (optional; avoids downloading everything again) |
   | `OpenSimConsoleHistory.txt` | Console command history (optional) |
   | `OpenSim.log`, `OpenSimStats.log` | Keeps a continuous log history, handy to compare before and after the update (optional; can grow large, archive it if so) |

   Do **not** copy the `addin-db-*` folders: the new version rebuilds them.
4. On Linux / macOS restore the execute permission: `chmod +x opensim.sh`
   (copy your old `opensim.sh` only if you had customised it).
   On Windows, if you had `opensim.bat`, copy it too.
5. Compare your `OpenSim.ini` with the new `OpenSim.ini.example` (and the
   `config-include/*.example` files) in case the new release added or renamed
   settings.
6. Start the simulator. Database updates are applied automatically on the first
   launch and cannot be undone — keep `opensim.old` until everything works.

## Troubleshooting

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
| Files derived from the OpenSimulator distribution (`OpenSim.ini`, `GridCommon.ini`, `FlotsamCache.ini`, `osslEnable.ini`, `opensim.bat`, and any other file that originates from the OpenSimulator project) | [BSD 3-Clause License](LICENSE-OpenSimulator.txt) |

**Why two licenses?**
The OpenSimulator project is distributed under the BSD 3-Clause License. That license
allows modification but requires that derivative works keep the original license notice.
We cannot relicense those files. Original contributions (documentation, custom configs
written from scratch) are released under GPL v2+ to ensure improvements remain open.

Copyright (c) 2026 eva Nowicka / ENS project
