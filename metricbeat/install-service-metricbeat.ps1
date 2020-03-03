# Delete and stop the service if it already exists.
if (Get-Service metricbeat -ErrorAction SilentlyContinue) {
  $service = Get-WmiObject -Class Win32_Service -Filter "name='metricbeat'"
  $service.StopService()
  Start-Sleep -s 1
  $service.delete()
}

$workdir = Split-Path $MyInvocation.MyCommand.Path

# Create the new service.
New-Service -name metricbeat `
  -displayName Metricbeat `
  -binaryPathName "`"$workdir\metricbeat.exe`" -c `"$workdir\metricbeat.yml`" -path.home `"$workdir`" -path.data `"C:\ProgramData\metricbeat`" -path.logs `"C:\ProgramData\metricbeat\logs`""
