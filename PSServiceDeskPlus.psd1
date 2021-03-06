﻿@{

# Script module or binary module file associated with this manifest.
RootModule = 'PSServiceDeskPlus'

# Version number of this module.
ModuleVersion = '0.9.2'

# ID used to uniquely identify this module
GUID = 'f89afdb7-34eb-45bf-9f70-540057c95456'

# Author of this module
Author = 'Scott Evtuch'

# Company or vendor of this module
CompanyName = 'Scott Evtuch'

# Copyright statement for this module
Copyright = '(c) 2016 Scott Evtuch.'

# Description of the functionality provided by this module
Description = 'A PowerShell module for invoking the ManageEngine ServiceDesk Plus API'

# Minimum version of the Windows PowerShell engine required by this module
# PowerShellVersion = ''

# Name of the Windows PowerShell host required by this module
# PowerShellHostName = ''

# Minimum version of the Windows PowerShell host required by this module
# PowerShellHostVersion = ''

# Minimum version of Microsoft .NET Framework required by this module
# DotNetFrameworkVersion = ''

# Minimum version of the common language runtime (CLR) required by this module
# CLRVersion = ''

# Processor architecture (None, X86, Amd64) required by this module
ProcessorArchitecture = 'None'

# Modules that must be imported into the global environment prior to importing this module
# RequiredModules = @()

# Assemblies that must be loaded prior to importing this module
RequiredAssemblies = @()

# Script files (.ps1) that are run in the caller's environment prior to importing this module.
ScriptsToProcess = @()

# Type files (.ps1xml) to be loaded when importing this module
TypesToProcess = @()

# Format files (.ps1xml) to be loaded when importing this module
FormatsToProcess = @()

# Modules to import as nested modules of the module specified in RootModule/ModuleToProcess
# NestedModules = @()

# Functions to export from this module
FunctionsToExport = 'Get-SDPChanges', 'Get-SDPNotes', 'Get-SDPRequest', 'Get-SDPRequests', 
               'New-SDPNote', 'Remove-SDPNote', 'Set-SDPAPIKey', 'Set-SDPURL'

# Cmdlets to export from this module
CmdletsToExport = @()

# Variables to export from this module
VariablesToExport = 'SDPURL'

# Aliases to export from this module
AliasesToExport = @()

# DSC resources to export from this module
# DscResourcesToExport = @()

# List of all modules packaged with this module
# ModuleList = @()

# List of all files packaged with this module
FileList = @()

# Private data to pass to the module specified in RootModule/ModuleToProcess. This may also contain a PSData hashtable with additional module metadata used by PowerShell.
PrivateData = @{

    PSData = @{

        # Tags applied to this module. These help with module discovery in online galleries.
        # Tags = @()

        # A URL to the license for this module.
        LicenseUri = 'https://raw.githubusercontent.com/ScottEvtuch/PSServiceDeskPlus/master/LICENSE'

        # A URL to the main website for this project.
        ProjectUri = 'https://github.com/ScottEvtuch/PSServiceDeskPlus'

        # A URL to an icon representing this module.
        # IconUri = ''

        # ReleaseNotes of this module
        # ReleaseNotes = ''

        # External dependent modules of this module
        # ExternalModuleDependencies = ''

    } # End of PSData hashtable
    
 } # End of PrivateData hashtable

# HelpInfo URI of this module
# HelpInfoURI = ''

# Default prefix for commands exported from this module. Override the default prefix using Import-Module -Prefix.
# DefaultCommandPrefix = ''

}

