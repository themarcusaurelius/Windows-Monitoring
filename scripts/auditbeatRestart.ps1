#Restarts Auditbeat every 15 seconds to enable the USB Capture
Set-Location -Path 'C:\windows-monitoring-master\local\auditbeat'

"`nRunning Audtbeat Refresher For External Devices..."

Add-Type -Name win -MemberDefinition '[DllImport("user32.dll")] public static extern bool ShowWindow(int handle, int state);' -Namespace native
[native.win]::ShowWindow(([System.Diagnostics.Process]::GetCurrentProcess() | Get-Process).MainWindowHandle,0)

for(;;) {
    try {
        "`nRefreshing Auditbeat...`n"
        Restart-Service auditbeat
        Get-Service auditbeat
        "`nAuditbeat Refreshed!"
        "`n---------------------------------------------"
    }
    catch {
    "`nFailed to re-start Auditbeat. Retrying..."
    }
    # wait for defined amount of time
    Start-Sleep 15
}