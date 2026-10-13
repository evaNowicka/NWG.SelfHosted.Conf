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

1. Get OpenSimulator with the Neverworld configuration. Two ways:

   a) Full package (recommended): OpenSimulator with the Neverworld
      configuration already in place. Extract it to a folder of your
      choice; nothing else to copy.

   b) Configuration only: download the latest OpenSimulator release from
      the official GitHub repository, extract it, and copy the files from
      the bin/ folder of this package into the bin/ folder of your
      installation, replacing any existing files:
        - OpenSim.ini
        - opensim.bat (Windows launcher)
        - config-include/FlotsamCache.ini
        - config-include/GridCommon.ini
        - config-include/osslEnable.ini

2. Configure your region.
   Create Regions/Region.ini (or let OpenSim generate it on first launch).
   You will need:
     - A unique region name
     - A new UUID for your region (generate one at uuidgenerator.net)
     - Grid coordinates — ask the Neverworld administrators
     - Your public IP or FQDN
     - The port you opened (must match OpenSim.ini, around line 579)

3. Launch:
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
5. Compare your 'OpenSim.ini' with the new 'OpenSim.ini.example' (and the
   'config-include/*.example' files) in case the new release added or renamed
   settings.
6. Start the simulator. Database updates are applied automatically on the first
   launch and cannot be undone — keep 'opensim.old' until everything works.

MOVING A REGION FROM ANOTHER GRID
---------------------------------

IMPORTANT: do this while your region is still connected to the old grid.
OpenSim.db only stores references to textures, meshes, scripts and object
contents; the content itself lives on the old grid's asset server. Copying
only OpenSim.db gives grey objects and empty scripts once the old grid
shuts down or its asset server becomes unreachable.

1. Save each region with its assets (still on the old grid):
     change region <region name>
     save oar <region name>.oar
   Do not use --no-assets. Check the file size; if you can, test-load it
   into a local standalone OpenSimulator.

2. Save your inventory (optional, if the old grid allows it):
     save iar <first> <last> / <password> <first>-<last>.iar -c
   
   (-c keeps the information about the original creators) 

3. Set up the region for Neverworld as in SETUP. You may copy your own
   config-include/FlotsamCache.ini and config-include/osslEnable.ini from
   the old installation (local preferences: asset cache, OSSL
   permissions). Ask the Neverworld administrators for grid
   coordinates. On first launch, give your Neverworld account as the
   estate owner.

4. Load your region:
     change region <region name>
     load oar <region name>.oar
   Objects whose owners do not exist on Neverworld go to the estate owner.

5. Load your inventory into your Neverworld account:
     load iar <first> <last> / <password> <first>-<last>.iar

Coming from an old Mono-based OpenSimulator (0.9.2 or earlier, started
with OpenSim.exe)? Start from the OpenSim.ini in this package and carry
your own settings over by hand.

Respect the permissions and licences of the content you move: items made
by other creators may not be allowed on another grid.

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
