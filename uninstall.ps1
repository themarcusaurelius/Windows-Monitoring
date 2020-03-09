$principal = New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent())

if($principal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    # code here...
    try {
        Set-Location -Path 'C:\windows-monitoring-master\local\winlogbeat'

        Stop-Service -Force winlogbeat

        Get-Service winlogbeat
        
        #Change Directory to Filebeat5
        Set-Location -Path 'C:\windows-monitoring-master\local\metricbeat'

        #Stops apachebeat from running
        Stop-Service -Force metricbeat

        #Get The apachebeat Status
        Get-Service metricbeat

        Set-Location -Path 'C:\windows-monitoring-master\local\auditbeat'

        Stop-Service -Force auditbeat

        Get-Service auditbeat

        #Change Directory to apachebeat5
        Set-Location -Path 'c:\'

        "`nUninstalling Windows-Monitoring Now..."

        $Target = "C:\windows-monitoring-master"

        Get-ChildItem -Path $Target -Recurse -force |
            Where-Object { -not ($_.pscontainer)} |
                Remove-Item -Force -Recurse

        Remove-Item -Recurse -Force $Target

        Pause
    } catch {
        Write-Error $_.Exception.ToString()
        Read-Host -Prompt "The above error occurred. Press Enter to exit." 
    }  
}
else {
    Start-Process -FilePath "powershell" -ArgumentList "$('-File ""')$(Get-Location)$('\')$($MyInvocation.MyCommand.Name)$('""')" -Verb runAs
}