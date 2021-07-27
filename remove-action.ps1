param( [string[]]$n )
powershell -Command {
param( [string[]]$n, [string]$path )
cd $path

$help = @"
用法：
    remove-action <-n <名字>>
    remove-action help

选项：
    <-n <名字>>
        指定要移除的操作的名字（英文逗号分割）

    help
        显示用法
"@


function Show-Help {
    Write-Host $help
}

if ( $n -eq $null ) {
    Show-Help
} else {
    for ( $i = 0; $i -lt $n.Count; $i++ ) {
        $RFile = $n[$i]
        if ( ( Test-Path .\actions\$RFile.ps1 ) -and ( Read-Host "将删除：$RFile，确认？[Y/n]" ) -eq "y" ) {
            Remove-Item -Path .\actions\$RFile.ps1
            Write-Host "已删除：$RFile" -ForegroundColor Green
        } elseif ( -not ( Test-Path .\actions\$RFile.ps1 ) ) {
            Write-Host "未删除$RFile：文件不存在" -ForegroundColor Red
        }
    }
}
} -args $n, $PSScriptRoot