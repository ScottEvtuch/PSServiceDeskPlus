# PSServiceDeskPlus

A PowerShell module for invoking the ManageEngine ServiceDesk Plus API

## Supported Operations

### Requests

* Get requests via view name
* Get request by ID

### Changes

* Get all changes

###  Notes

* Get all notes for a request ID
* Create a new note for a request ID
* Remove a note for a request ID

## Pipelining

Wherever possible, commands should support pipelining.

~~~~
Get-SDPRequests -View 'Overdue_System' | New-SDPNote -Text "This request is overdue"
~~~~

~~~~
Get-SDPRequests -View 'Waiting_Update' | Get-SDPRequest
~~~~

## Data conversion

Compatible timestamps from the API are converted from epoch integers to PowerShell datetime objects in the local timezone of the machine.

## Credential storage

The API key can optionally be stored on the disk in %LOCALAPPDATA% as a secure string. Only the user who saved the API key will be able to decrypt it, and only on the same computer where it was saved.