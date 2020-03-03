# Delete and stop the service if it already exists.
if (Get-Service metricbeat -ErrorAction SilentlyContinue) {
  $service = Get-WmiObject -Class Win32_Service -Filter "name='metricbeat'"
  $service.StopService()
  Start-Sleep -s 1
  $service.delete()
}
