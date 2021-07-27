param( [string]$profile = "Windows PowerShell" )
powershell -Command {
param( [string]$profile, [string]$path )
cd $path

$help = @"
用法：
    set [-profile [Windows Terminal的配置名称，默认"Windows PowerShell"]]
    set help

选项：
    [-profile [Windows Terminal的配置名称，默认"Windows PowerShell"]]
        指定配置

    help
        显示用法
"@


function Show-Help {
    Write-Host $help
}

function Get-WTMode {
    if ( Test-Path .\.wtmode ) {
        return Get-Content .\.wtmode
    } else {
        return $false
    }
}

if ( ( Test-Path .\.wtmode ) -and ( Read-Host "将关闭Windows Terminal模式，确认？[Y/n]" ) -eq "y" ) {
    Remove-Item .\.wtmode
} elseif ( -not ( Test-Path .\.wtmode ) -and ( Read-Host "将开启Windows Terminal模式，PowerShell配置：$profile，确认？[Y/n]" ) -eq "y" ) {
    $profile | Out-File -FilePath .\.wtmode
}
} -args $profile, $PSScriptRoot