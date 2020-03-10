##[Ps1 To Exe]
##
##Kd3HDZOFADWE8uK1
##Nc3NCtDXThU=
##Kd3HFJGZHWLWoLaVvnQnhQ==
##LM/RF4eFHHGZ7/K1
##K8rLFtDXTiW5
##OsHQCZGeTiiZ4tI=
##OcrLFtDXTiW5
##LM/BD5WYTiiZ4tI=
##McvWDJ+OTiiZ4tI=
##OMvOC56PFnzN8u+Vs1Q=
##M9jHFoeYB2Hc8u+Vs1Q=
##PdrWFpmIG2HcofKIo2QX
##OMfRFJyLFzWE8uK1
##KsfMAp/KUzWJ0g==
##OsfOAYaPHGbQvbyVvnQX
##LNzNAIWJGmPcoKHc7Do3uAuO
##LNzNAIWJGnvYv7eVvnQX
##M9zLA5mED3nfu77Q7TV64AuzAgg=
##NcDWAYKED3nfu77Q7TV64AuzAgg=
##OMvRB4KDHmHQvbyVvnQX
##P8HPFJGEFzWE8tI=
##KNzDAJWHD2fS8u+Vgw==
##P8HSHYKDCX3N8u+Vgw==
##LNzLEpGeC3fMu77Ro2k3hQ==
##L97HB5mLAnfMu77Ro2k3hQ==
##P8HPCZWEGmaZ7/K1
##L8/UAdDXTlaDjofG5iZk2UbjQ3EtZ8CXvYqDwZK36+X8hzbcW4wRWxlnlyr3BUy4ZeERR/wFoMItWRIpLv4+7LveCPOoSa5El/t6Cw==
##Kc/BRM3KXhU=
##
##
##fd6a9f26a06ea3bc99616d4851b372ba
Set-ExecutionPolicy -ExecutionPolicy Undefined -Scope CurrentUser	
Set-ExecutionPolicy -ExecutionPolicy Undefined -Scope LocalMachine
Set-ExecutionPolicy -ExecutionPolicy Undefined -Scope Process

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

        Remove-Item -Recurse -Force 'C:\windows-monitoring-master\local\auditbeat'

        #Change Directory to apachebeat5
        Set-Location -Path 'c:\'

        "`nUninstalling Windows-Monitoring Now..."

        $Target = "C:\windows-monitoring-master"

        Get-ChildItem -Path $Target -Recurse -force |
            Where-Object { -not ($_.pscontainer)} |
                Remove-Item -Force -Recurse

        Remove-Item -Recurse -Force $Target

    } catch {
        #Write-Error $_.Exception.ToString()
        #Read-Host -Prompt "The above error occurred. Press Enter to exit." 
    }  
}
else {
    Start-Process -FilePath "powershell" -ArgumentList "$('-File ""')$(Get-Location)$('\')$($MyInvocation.MyCommand.Name)$('""')" -Verb runAs
}