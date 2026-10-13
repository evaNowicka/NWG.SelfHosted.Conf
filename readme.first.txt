NWG.SelfHosted.Conf — Quick Setup Guide
========================================

Configuration files to connect a self-hosted OpenSimulator region
to the Neverworld grid.

For full documentation and license details, see README.md or visit:
https://github.com/evaNowicka/NWG.SelfHosted.Conf


REQUIREMENTS
------------
- .NET 8.0 runtime for your operating system
- On Linux / macOS: libgdiplus and related libraries
- An account on the Neverworld grid
- A public IP address or FQDN (static or via dynamic DNS)
- A port open in your firewall / router (default: 9000 UDP+TCP)


SETUP
-----

1. Download the latest OpenSimulator release from the official GitHub repository
   and extract it to a folder of your choice.

2. Copy the files from the bin/ folder of this package into the bin/ folder
   of your OpenSimulator installation, replacing any existing files:
     - OpenSim.ini
     - config-include/FlotsamCache.ini
     - config-include/GridCommon.ini
     - config-include/osslEnable.ini

3. Configure your region.
   Create Regions/Region.ini (or let OpenSim generate it on first launch).
   You will need:
     - A unique region name
     - A new UUID for your region (generate one at uuidgenerator.net)
     - Grid coordinates — ask the Neverworld administrators
     - Your public IP or FQDN
     - The port you opened (must match OpenSim.ini, around line 579)

4. Launch:
     Windows:       .\opensim.bat
     Linux / macOS: ./opensim.sh

   On first launch OpenSim will prompt for region details if Region.ini
   does not exist yet.

UPDATE AN EXISTING INSTALLATION
--------------------------------

1. Back up first. In the OpenSim console run 'save oar <file>.oar' for each
   region, then stop the simulator with 'shutdown' (do not just close the window).
2. Rename the current folder, e.g. 'opensim' → 'opensim.old', and extract the
   new release into a fresh 'opensim' folder.
3. Copy these from 'opensim.old/bin/' into 'opensim/bin/':

    - 'OpenSim.ini' (Your simulator settings)
    - 'config-include/FlotsamCache.ini', 'GridCommon.ini', 'osslEnable.ini' (Grid connection, cache and OSSL settings)
    - 'Regions/*.ini' (Your region definitions)
    - 'OpenSim.db' (Region contents: objects, terrain, estate (SQLite))
    - 'ScriptEngines/' (Script states (optional; without it scripts restart fresh))
    - 'assetcache/' (Asset cache (optional; avoids downloading everything again))
    - 'OpenSimConsoleHistory.txt' (Console command history (optional))
    - 'OpenSim.log', 'OpenSimStats.log' (Keeps a continuous log history, handy to compare before and after the update (optional; can grow large, archive it if so))

   Do not copy the 'addin-db-*' folders: the new version rebuilds them.
4. On Linux / macOS restore the execute permission: 'chmod +x opensim.sh'
   (copy your old 'opensim.sh' only if you had customised it).
   On Windows, if you had 'opensim.bat', copy it too.
5. Compare your 'OpenSim.ini' with the new 'OpenSim.ini.example' (and the
   'config-include/*.example' files) in case the new release added or renamed
   settings.
6. Start the simulator. Database updates are applied automatically on the first
   launch and cannot be undone — keep 'opensim.old' until everything works.

TROUBLESHOOTING
---------------

Region not visible on the grid:
  Check that the port is reachable from the internet. Use an online
  port-checker tool to test from outside your network.

Cannot connect from the same network as the server:
  Some routers do not support hairpin NAT (loopback). Use the internal IP
  to connect from the same LAN, or enable NAT loopback in your router.


LICENSE
-------
Original files in this package (documentation, custom configuration):
  GNU General Public License v2 or later — see LICENSE

Files derived from the OpenSimulator project (OpenSim.ini, GridCommon.ini,
FlotsamCache.ini, osslEnable.ini, opensim.bat, and any other file
originating from OpenSimulator):
  BSD 3-Clause License — see LICENSE-OpenSimulator.txt

Copyright (c) 2026 eva Nowicka / ENS project
