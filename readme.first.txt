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
     - FlotsamCache.ini
     - GridCommon.ini

3. Configure your region.
   Create Regions/Region.ini (or let OpenSim generate it on first launch).
   You will need:
     - A unique region name
     - A new UUID for your region (generate one at uuidgenerator.net)
     - Grid coordinates — ask the Neverworld administrators
     - Your public IP or FQDN
     - The port you opened (must match OpenSim.ini, around line 579)

4. Launch:
     Windows:       OpenSim.exe
     Linux / macOS: ./opensim.sh

   On first launch OpenSim will prompt for region details if Region.ini
   does not exist yet.


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
FlotsamCache.ini, and any other file originating from OpenSimulator):
  BSD 3-Clause License — https://opensource.org/licenses/BSD-3-Clause

Copyright (c) 2026 eva Nowicka / ENS project
