#region 关键代码：强迫以管理员权限运行
$currentWi = [Security.Principal.WindowsIdentity]::GetCurrent()
$currentWp = [Security.Principal.WindowsPrincipal]$currentWi
 
if( -not $currentWp.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator))
{
  $boundPara = ($MyInvocation.BoundParameters.Keys | foreach{
     '-{0} {1}' -f  $_ ,$MyInvocation.BoundParameters[$_]} ) -join ' '
  $currentFile = (Resolve-Path  $MyInvocation.InvocationName).Path
 
 $fullPara = $boundPara + ' ' + $args -join ' '
 Start-Process "$psHome\powershell.exe"   -ArgumentList "$currentFile $fullPara"   -verb runas
 return
}
#endregion

$src = 'https://raw.githubusercontent.com/googlehosts/hosts/master/hosts-files/hosts'
$des = "$env:temp\hosts"
Invoke-WebRequest -uri $src -OutFile $des
Unblock-File $des
Copy-Item "$env:temp\hosts"  "$env:windir\System32\drivers\etc\hosts"
Exit