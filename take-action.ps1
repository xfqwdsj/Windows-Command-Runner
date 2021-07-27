param( [string[]]$n )
powershell -Command {
param( [string[]]$n, [string]$path )
cd $path

$help = @"
用法：
    take-action <-n <名字>>
    take-action help

选项：
    <-n <名字>>
        指定要执行的操作的名字（英文逗号分割）

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

if ( $n -eq $null ) {
    Show-Help
} else {
    for ( $i = 0; $i -lt $n.Count; $i++ ) {
        $TFile = $n[$i]
        if ( ( Test-Path .\actions\$TFile.ps1 ) -and ( Read-Host "将执行：$TFile，确认？[Y/n]" ) -eq "y" ) {
            if ( Get-WTMode -ne $false ) {
                $TWTMode = Get-WTMode
                Invoke-Expression "wt -d $Path -p $TWTMode powershell .\actions\$TFile.ps1"
            } else {
                Invoke-Expression "start powershell .\$TFile.ps1"
            }
            Write-Host "已执行：$TFile" -ForegroundColor Green
        } elseif ( -not ( Test-Path .\actions\$TFile.ps1 ) ) {
            Write-Host "未执行$TFile：文件不存在" -ForegroundColor Red
        }
    }
}
} -args $n, $PSScriptRoot