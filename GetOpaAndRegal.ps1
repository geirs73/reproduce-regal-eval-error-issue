<#
.SYNOPSIS
Script for fetching opa.exe and regal.exe on Windows with PS

#>

[string] $PathToToolsDep = Join-Path $PSScriptRoot "tools-dependency.json"

[string] $PublishDir = $(Join-Path $PSScriptRoot 'bin')

function Main {

    try {
        if (!(Test-Path -PathType Container $PublishDir)) {
            New-Item -ItemType Directory -Path $PublishDir | Out-Null
        }

        Write-Host "Opa Exe Fetch script"
        Write-Host "Powershell version: $($PSVersionTable.PSVersion)"

        $dependency = Get-Content -Path $PathToToolsDep | ConvertFrom-Json -AsHashtable

        $OpaVersionNumber = $dependency["OpaVersion"]
        $RegalVersionNumber = $dependency["RegalVersion"]
                
        Write-Host "Downloading opa.exe version v$OpaVersionNumber to directory"
        Invoke-WebRequest -OutFile (Join-Path $PublishDir 'opa.exe') -Uri "https://github.com/open-policy-agent/opa/releases/download/v$OpaVersionNumber/opa_windows_amd64.exe"
        
        Write-Host "Downloading regal.exe version v$RegalVersionNumber to directory"
        Invoke-WebRequest -OutFile (Join-Path $PublishDir 'regal.exe') -Uri "https://github.com/StyraInc/regal/releases/download/v${RegalVersionNumber}/regal_Windows_x86_64.exe"

        Write-Host "Finished"
    }
    catch {
        throw
    }
}

Main