param( [string]$p, [string]$f, [string]$n )
powershell -Command {
param( [string]$p, [string]$f, [string]$n, [string]$path )
cd $path

$help = @"
用法：
    add-action <-p <路径>> <-f <文件路径>> <-n <名字>>
    add-action help

选项：
    <-p <路径>>
        指定要执行的路径
    <-f <文件路径>>
        指定要执行的操作（可通过引号添加参数）
    <-n <名字>>
        指定要添加的操作的名字

    help
        显示用法
"@


function Show-Help {
    Write-Host $help
}

function Add-Action {
    param( [string]$p, [string]$f, [string]$n )
    "cd $p" | Out-File .\actions\$n.ps1
    "cd `"$p`"" | Out-File .\actions\$n.ps1 -Append
    "Invoke-Expression `"$f`"" | Out-File .\actions\$n.ps1 -Append
    Write-Host "已添加：$n" -ForegroundColor Green
}

if ( ( $p -ne "" ) -and ( $f -ne "" ) -and ( $n -ne "" ) -and ( $p -ne $null ) -and ( $f -ne $null ) -and ( $n -ne $null ) ) {
    if ( -not ( Test-Path .\actions\$n.ps1 ) ) {
        Add-Action $p $f $n
    } else {
        if ( ( Read-Host "文件已存在，是否继续？[Y/n]" ) -eq "y" ) {
            Add-Action $p $f $n
        }
    }
} else {
    Show-Help
}

} -args $p, $f, $n, $PSScriptRoot