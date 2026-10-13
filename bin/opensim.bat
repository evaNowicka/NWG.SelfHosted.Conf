@echo off
REM opensim.bat - OpenSimulator launcher for Windows
REM Adapted from bin/opensim.sh of the OpenSimulator distribution
REM Copyright (c) Contributors, http://opensimulator.org/
REM Windows adaptation (c) 2026 eva Nowicka / ENS project
REM SPDX-License-Identifier: BSD-3-Clause
REM Full license text: LICENSE-OpenSimulator.txt

cd /d "%~dp0"
dotnet OpenSim.dll
