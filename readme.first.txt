First, read:
    https://neverworldgrid.com/self-host-regions-on-neverworld-grid/
    https://github.com/opensim/opensim
    http://opensimulator.org/wiki/Dependencies
    http://opensimulator.org/wiki/Main_Page

Download last release from https://github.com/opensim/opensim/releases/download/r8467ee3/LastDotNetBuild.zip

Dependencies:
    You need dotnet 8.0 runtime for your operating system: https://dotnet.microsoft.com/en-us/download/dotnet/8.0
    If you use Linux/Mac, you must get libgdiplus. For example, in a Linux Debian-like system, you can use: apt-get update && apt-get install -y apt-utils libgdiplus libc6-dev
    Unpack the downloaded file: LastDotNetBuild.

Copy files from this folder:
    bin/OpenSim.ini ---------------------> (yourfolder)/bin/OpenSim.ini
    bin/config-include/FlotsamCache.ini -> (yourfolder)/bin/config-include/FlotsamCache.ini
    bin/config-include/GridCommon.ini ---> (yourfolder)/bin/config-include/GridCommon.ini

Before running:
    You need several values:
        - Account in NeverWorld Grid
        - Name for your region
        - Coordinates for your region (you can ask NeverWorld Admins or check https://neverworldgrid.com/neverworld-quick-map/)
        - Your public IP (if it's not static, you can use a service like http://no-ip.com to get a fixed FQDN)
        - A public port (you need to configure it in your firewall/router and check that it's accessible from the internet using a service like https://www.yougetsignal.com/tools/open-ports/)

Manual configuration of region:
    You can create a file (yourfolder)/bin/Regions/Region.ini with the configuration of your region like this one (read http://opensimulator.org/wiki/Configuring_Regions):

    [TEST]                                                      <---- the name for your region
    RegionUUID = ad9260c6-0ce8-43cf-a4c9-ceb0931a0d6f           <---- unique UUID for your region. You can generate it at https://www.uuidgenerator.net/version4
    Location = 1000,1000                                        <---- the coordinates of your region. You can ask NeverWorld Admins or check https://neverworldgrid.com/neverworld-quick-map/
    SizeX = 256                                                 <---- size of your region
    SizeY = 256
    SizeZ = 256
    InternalAddress = 0.0.0.0
    InternalPort = XXXXX                                        <---- your public port (you need to configure it in your firewall/router)
    ResolveAddress = False
    ExternalHostName = XXXXXXXXXXXXXXXXX                        <---- your public IP or FQDN
    MaptileStaticUUID = 00000000-0000-0000-0000-000000000000

Manual configuration of (yourfolder)/bin/OpenSim.ini
    You must configure the OpenSim.ini file with your public port (the same as you use in the region's configuration).

    http_listener_port = XXXXX (line 579)

Launch OpenSim:
    Windows: Run the OpenSim.exe file
    Linux/Mac: Run ./opensim.sh (sometimes it's necessary to change the mode of the script: chmod +x opensim.sh)

First launch configuration:
    If you don't configure a bin/Regions/Region.ini file, you must answer the following questions at the console:

        New region name []: TEST                                    <---- the name for your region
        RegionUUID [ad9260c6-0ce8-43cf-a4c9-ceb0931a0d6f]:          <---- You can choose the default value
        Region Location [1000,1000]:                                <---- You must indicate the coordinates of your region. You can ask NeverWorld Admins or check their documentation
        Internal IP address [0.0.0.0]:
        Internal port [9000]: XXXXX                                 <---- your public port (you need to configure it in your firewall/router)
        Resolve hostname to IP on start (for running inside Docker) [False]:
        External host name [SYSTEMIP]: XXXXXXXXXXXXXXXXX            <---- your public IP or FQDN

    You must answer the following question to complete the initial configuration:

        New estate name [My Estate]:                                <---- You can indicate the name of your Estate or choose the default value

        Estate My Estate has no owner set.
        Estate owner first name [Test]: your name                   <---- your name from your NeverWorld account
        Estate owner last name [User]: your surname                 <---- your surname from your NeverWorld account

Check for possible errors in the console and at bin/OpenSim.log

A common error is that you cannot access the region from another region. Check the correct configuration of the ports in the OpenSim.ini and Region.ini files, the configuration of your firewall/router, and that the ports are accessible from the internet using a service like https://www.yougetsignal.com/tools/open-ports/.
Some routers do not support loopback, so you cannot access your region using your public IP from the same network. You must set up NAT loopback (http://opensimulator.org/wiki/NAT_Loopback)