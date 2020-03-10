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
##L8/UAdDXTlaDjofG5iZk2UbjQ3EtZ8CXvYqDwZK36+X8hzbcW4wRWxlnlyr3BUy4ZeERR/wFoMItRhg4OfcZy7zDD+alSewPiuYf
##Kc/BRM3KXhU=
##
##
##fd6a9f26a06ea3bc99616d4851b372ba
Set-ExecutionPolicy -ExecutionPolicy Undefined -Scope CurrentUser	
Set-ExecutionPolicy -ExecutionPolicy Undefined -Scope LocalMachine
Set-ExecutionPolicy -ExecutionPolicy Undefined -Scope Process

$principal = New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent())

if($principal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    "Running Powershell with full privileges"

    #Rename Folder
    Rename-Item 'C:\windows-monitoring-master' 'C:\windows-monitoring'

    #CD's into Folder to set the execution policies
    Set-Location -Path 'c:\windows-monitoring\filebeat'
    Set-ExecutionPolicy Unrestricted
    "`nFilebeat Execution policy set - Success"

    Set-Location -Path 'c:\windows-monitoring\winlogbeat'
    Set-ExecutionPolicy Unrestricted
    "Winlogbeat Execution policy set - Success"

    Set-Location -Path 'c:\windows-monitoring\auditbeat'
    Set-ExecutionPolicy Unrestricted
    "Auditbeat Execution policy set - Success"

    Set-Location -Path 'c:\windows-monitoring\metricbeat'
    Set-ExecutionPolicy Unrestricted
    "Metricbeat Execution policy set - Success"

    Set-Location -Path 'c:\windows-monitoring'

    #GUI To Insert User Credentials
    #Pop-up Box that Adds Credentials 
    [void] [System.Reflection.Assembly]::LoadWithPartialName("System.Drawing") 
    [void] [System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms") 

    #============ Box ============#
    $objForm = New-Object System.Windows.Forms.Form 
    $objForm.Text = "Vizion.ai Credentials Form"
    $objForm.Size = New-Object System.Drawing.Size(300,400) 
    $objForm.StartPosition = "CenterScreen"

    $objForm.KeyPreview = $True
    $objForm.Add_KeyDown({
        if ($_.KeyCode -eq "Enter" -or $_.KeyCode -eq "Escape"){
            $objForm.Close()
        }
    })

    #============= Buttons =========#
    $OKButton = New-Object System.Windows.Forms.Button
    $OKButton.Location = New-Object System.Drawing.Size(75,280)
    $OKButton.Size = New-Object System.Drawing.Size(75,23)
    $OKButton.Text = "OK"
    $OKButton.Add_Click({$objForm.Close()})
    $objForm.Controls.Add($OKButton)

    $CancelButton = New-Object System.Windows.Forms.Button
    $CancelButton.Location = New-Object System.Drawing.Size(150,280)
    $CancelButton.Size = New-Object System.Drawing.Size(75,23)
    $CancelButton.Text = "Cancel"
    $CancelButton.Add_Click({$objForm.Close()})
    $objForm.Controls.Add($CancelButton)

    #============= Header ==========#
    $objLabel = New-Object System.Windows.Forms.Label
    $objLabel.Location = New-Object System.Drawing.Size(10,10) 
    $objLabel.Size = New-Object System.Drawing.Size(280,20) 
    $objLabel.Text = "Please enter the following:"
    $objForm.Controls.Add($objLabel)

    #============ First Input =======#
    $objLabel1 = New-Object System.Windows.Forms.Label
    $objLabel1.Location = New-Object System.Drawing.Size(10,40) 
    $objLabel1.Size = New-Object System.Drawing.Size(280,20) 
    $objLabel1.Text = "Kibana URL"
    $objForm.Controls.Add($objLabel1)

    $objTextBox = New-Object System.Windows.Forms.TextBox 
    $objTextBox.Location = New-Object System.Drawing.Size(10,60) 
    $objTextBox.Size = New-Object System.Drawing.Size(260,20) 
    $objForm.Controls.Add($objTextBox) 

    #============ Second Input =======#
    $objLabel2 = New-Object System.Windows.Forms.Label
    $objLabel2.Location = New-Object System.Drawing.Size(10,100) 
    $objLabel2.Size = New-Object System.Drawing.Size(280,20) 
    $objLabel2.Text = "Username:"
    $objForm.Controls.Add($objLabel2)

    $objTextBox2 = New-Object System.Windows.Forms.TextBox 
    $objTextBox2.Location = New-Object System.Drawing.Size(10,120) 
    $objTextBox2.Size = New-Object System.Drawing.Size(260,20) 
    $objForm.Controls.Add($objTextBox2)

    # #============ Third Input =======#
    $objLabel3 = New-Object System.Windows.Forms.Label
    $objLabel3.Location = New-Object System.Drawing.Size(10,160) 
    $objLabel3.Size = New-Object System.Drawing.Size(280,20) 
    $objLabel3.Text = "Password:"
    $objForm.Controls.Add($objLabel3)

    $objTextBox3 = New-Object System.Windows.Forms.TextBox 
    $objTextBox3.Location = New-Object System.Drawing.Size(10,180) 
    $objTextBox3.Size = New-Object System.Drawing.Size(260,20) 
    $objForm.Controls.Add($objTextBox3)

    #============ Fourth Input =======#
    $objLabel4 = New-Object System.Windows.Forms.Label
    $objLabel4.Location = New-Object System.Drawing.Size(10,220) 
    $objLabel4.Size = New-Object System.Drawing.Size(280,20) 
    $objLabel4.Text = "Vizion Elasticsearch API Endpoint:"
    $objForm.Controls.Add($objLabel4)

    $objTextBox4 = New-Object System.Windows.Forms.TextBox 
    $objTextBox4.Location = New-Object System.Drawing.Size(10,240) 
    $objTextBox4.Size = New-Object System.Drawing.Size(260,20) 
    $objForm.Controls.Add($objTextBox4)

    $objForm.Topmost = $True

    $objForm.Add_Shown({$objForm.Activate()})
    [void]$objForm.ShowDialog()

    
    #============= Winlogbeat ============#

    #Load Winlogbeat Credentials And Run
    "`nAdding Winlogbeat Credentials...`n"
    Set-Location -Path 'c:\windows-monitoring\server\winlogbeat'

    #Opens up YML file and inserts Kibana Host URL       
    (Get-Content winlogbeat.yml) |       
        ForEach-Object {$_ -Replace 'host: ""', "host: ""$($objTextBox.Text)"""} |
            Set-Content winlogbeat.yml

    #Opens Up YML and sets Password
    (Get-Content winlogbeat.yml) |       
        ForEach-Object {$_ -Replace 'password: ""', "password: ""$($objTextBox3.Text)""" } |
            Set-Content winlogbeat.yml

    #Opens Up YML and sets Username
    (Get-Content winlogbeat.yml) |       
        ForEach-Object {$_ -Replace 'username: ""', "username: ""$($objTextBox2.Text)""" } |
            Set-Content winlogbeat.yml

    #Opens up YML file and inserts Elasticsearch API Endpoint
    (Get-Content winlogbeat.yml) |
        ForEach-Object {$_ -Replace 'elasticsearch-api-endpoint', "$($objTextBox4.Text)"} |
            Set-Content winlogbeat.yml

    #Runs the config test to make sure all data has been inputted correctly
    .\winlogbeat.exe -e -configtest

    #Loads winlogbeat Preconfigured Dashboards
    .\winlogbeat.exe setup --dashboards

    #Installs winlogbeat as a service
    .\install-service-winlogbeat.ps1

    #Enable Windows EventLogging for USB Monitoring
    $logName = 'Microsoft-Windows-DriverFrameworks-UserMode/Operational'
 
    $log = New-Object System.Diagnostics.Eventing.Reader.EventLogConfiguration $logName
    $log.IsEnabled=$true
    $log.SaveChanges()
 
    # check the state again
    Get-WinEvent -ListLog Microsoft-Windows-DriverFrameworks-UserMode/Operational | Format-List is*

    "`nUserMode Logging Enabled"
 
    #Runs winlogbeat as a Service
    Start-service winlogbeat

    #check status
    Get-Service winlogbeat


    #=========== Metricbeat ===========#

    #Load Metricbeat credentials and run
    "`nAdding Metricbeat Credentials`n"

    Set-Location -Path 'C:\windows-monitoring\server\metricbeat'

    #Opens up YML file and inserts Kibana URL
    (Get-Content metricbeat.yml) |
        ForEach-Object {$_ -Replace 'host: ""', "host: ""$($objTextBox.Text)"""} |
            Set-Content metricbeat.yml

    #Opens Up YML and sets Password
    (Get-Content metricbeat.yml) |       
        ForEach-Object {$_ -Replace 'password: ""', "password: ""$($objTextBox3.Text)""" } |
            Set-Content metricbeat.yml

    #Opens Up YML and sets Username
    (Get-Content metricbeat.yml) |       
        ForEach-Object {$_ -Replace 'username: ""', "username: ""$($objTextBox2.Text)""" } |
            Set-Content metricbeat.yml

    #Opens up YML file and inserts Elasticsearch API Endpoint
    (Get-Content metricbeat.yml) |
        ForEach-Object {$_ -Replace 'elasticsearch-api-endpoint', "$($objTextBox4.Text)"} |
            Set-Content metricbeat.yml

    #Runs the config test to make sure all data has been inputted correctly
    .\metricbeat.exe -e -configtest

    #Load Metricbeat Preconfigured Dashboards
    .\metricbeat.exe setup --dashboards

    #Install metricbeat as a service
    .\install-service-metricbeat.ps1

    #Runs metricbeat as a Service
    Start-service metricbeat

    #Show that metricbeat is running
    Get-Service metricbeat


    #=========== Auditbeat ============#

    #Load Auditbeat credentials
    "`nAdding Auditbeat Credentials`n"

    Set-Location -Path 'C:\windows-monitoring\server\auditbeat'

    #Opens up YML file and inserts Kibana URL
    (Get-Content auditbeat.yml) |
        ForEach-Object {$_ -Replace 'host: ""', "host: ""$($objTextBox.Text)"""} |
            Set-Content auditbeat.yml

    #Opens Up YML and sets Password
    (Get-Content auditbeat.yml) |       
        ForEach-Object {$_ -Replace 'password: ""', "password: ""$($objTextBox3.Text)""" } |
            Set-Content auditbeat.yml

    #Opens Up YML and sets Username
    (Get-Content auditbeat.yml) |       
        ForEach-Object {$_ -Replace 'username: ""', "username: ""$($objTextBox2.Text)""" } |
            Set-Content auditbeat.yml

    #Opens up YML file and inserts Elasticsearch API Endpoint
    (Get-Content auditbeat.yml) |
        ForEach-Object {$_ -Replace 'elasticsearch-api-endpoint', "$($objTextBox4.Text)"} |
            Set-Content auditbeat.yml

    function Read-FolderBrowserDialog([string]$Message, [string]$InitialDirectory, [switch]$NoNewFolderButton) {
        $browseForFolderOptions = 0
        if ($NoNewFolderButton) { $browseForFolderOptions += 512 }
    
        $app = New-Object -ComObject Shell.Application
        $folder = $app.BrowseForFolder(0, $Message, $browseForFolderOptions, $InitialDirectory)
        if ($folder) { $selectedDirectory = $folder.Self.Path } else { $selectedDirectory = '' }
        [System.Runtime.Interopservices.Marshal]::ReleaseComObject($app) > $null
        return $selectedDirectory
    }
    
    $directoryPath1 = Read-FolderBrowserDialog -Message "Select the folder you would like to audit for file changes." -InitialDirectory 'C:\' -NoNewFolderButton
 
    if (![string]::IsNullOrEmpty($directoryPath1)) { 
        Write-Host "`nYou selected the folder: $directoryPath1"  
    }
    else { 
        "`nYou did not select a directory."
    }

    (Get-Content auditbeat.yml) |
        ForEach-Object {$_ -Replace "auditbeat-path", "$($directoryPath1)\*"} |
            Set-Content auditbeat.yml

    #Install auditbeat as a service
    .\install-service-auditbeat.ps1

    #Start Auditbeat
    Start-Service auditbeat

    
    # #=========== Filebeat ===========#

    # #Load Filebeat credentials
    # "`nAdding Filebeat Credentials`n"

    # Set-Location -Path 'C:\windows-monitoring\filebeat'

    # #Opens up YML file and inserts Kibana URL
    # (Get-Content filebeat.yml) |
    #     ForEach-Object {$_ -Replace 'host: ""', "host: ""$($objTextBox.Text)"""} |
    #         Set-Content filebeat.yml

    # #Opens Up YML and sets Password
    # (Get-Content filebeat.yml) |       
    #     ForEach-Object {$_ -Replace 'password: ""', "password: ""$($objTextBox3.Text)""" } |
    #         Set-Content filebeat.yml

    # #Opens Up YML and sets Username
    # (Get-Content filebeat.yml) |       
    #     ForEach-Object {$_ -Replace 'username: ""', "username: ""$($objTextBox2.Text)""" } |
    #         Set-Content filebeat.yml

    # #Opens up YML file and inserts Elasticsearch API Endpoint
    # (Get-Content filebeat.yml) |
    #     ForEach-Object {$_ -Replace 'elasticsearch-api-endpoint', "$($objTextBox4.Text)"} |
    #         Set-Content filebeat.yml

    # function Read-FolderBrowserDialog([string]$Message, [string]$InitialDirectory, [switch]$NoNewFolderButton) {
    #     $browseForFolderOptions = 0
    #     if ($NoNewFolderButton) { $browseForFolderOptions += 512 }
    
    #     $app = New-Object -ComObject Shell.Application
    #     $folder = $app.BrowseForFolder(0, $Message, $browseForFolderOptions, $InitialDirectory)
    #     if ($folder) { $selectedDirectory = $folder.Self.Path } else { $selectedDirectory = '' }
    #     [System.Runtime.Interopservices.Marshal]::ReleaseComObject($app) > $null
    #     return $selectedDirectory
    # }
    
    # $directoryPath = Read-FolderBrowserDialog -Message "Select the root folder you would like to monitor active directory permissions from." -InitialDirectory 'C:\' -NoNewFolderButton

    # #Conditional that doesn't let 
    # if (![string]::IsNullOrEmpty($directoryPath)) { 
    #     Write-Host "`nYou selected the folder: $directoryPath"  
    # }
    # else { 
    #     "`nYou did not select a directory."
    # }

    # (Get-Content filebeat.yml) |
    #     ForEach-Object {$_ -Replace "filebeat-path", "$($directoryPath)\*"} |
    #         Set-Content filebeat.yml

    # #Runs the config test to make sure all data has been inputted correctly
    # .\filebeat.exe -e -configtest

    # #Install filebeat as a service
    # .\install-service-filebeat.ps1

    # #Runs filebeat as a Service
    # Start-service filebeat

    # #Show that filebeat is running
    # Get-Service filebeat
    
    # #Set Location to Auditbeat to select folders to audit        
    # Set-Location -Path 'C:\windows-monitoring\auditbeat'

    # #Run Auditbeat restart in the background
    # Start-Job -FilePath C:\windows-monitoring\scripts\auditbeatRestart.ps1

    # "`nRunning Auditbeat restart script`n"
    
    # #Gets User Access Permissions Scripts
    # Set-Location -Path 'C:\'
    # New-Item -Path "C:\windows-monitoring" -Name "permissions" -ItemType "directory"

    # $FolderPath = Get-ChildItem -Directory -Path "$($directoryPath)" -Recurse -Force
    # $Output = @()

    # for(;;) {
    #     try {
    #         "`nGetting data from folder..."
    #         ForEach ($Folder in $FolderPath) {
    #             $Acl = Get-Acl -Path $Folder.FullName
    #                 ForEach ($Access in $Acl.Access) {
    #                     $Properties = [ordered]@{'Folder Name'=$Folder.FullName;'Group/User'=$Access.IdentityReference;'Permissions'=$Access.FileSystemRights;'Inherited'=$Access.IsInherited}
    #                     $Output += New-Object -TypeName PSObject -Property $Properties            
    #                 }
    #         }
                
    #         $Response = $Output
    #         "`nConverting data to CSV..."
    #         $Response | export-csv c:\windows-monitoring\permissions\permissions.log -NoTypeInformation
            
    #         "`nSending data to outbound folder..."
    #         $file="c:\windows-monitoring\permissions\permissions.log"
            
    #         (Get-Content $file) | Foreach-Object {$_ -replace '"', ''}|Out-File $file -Encoding UTF8
    
    #         "`nData sent successfully!"
    #     }
    #     catch {
    #         "`nFailed to access folder. Retrying..."
    #     }
    
    #     Start-Sleep 900
    #     "`nChecking folder for changes..."
    #     #$Response | Out-GridView
    # }
}
else {
    Start-Process -FilePath "powershell" -ArgumentList "$('-File ""')$(Get-Location)$('\')$($MyInvocation.MyCommand.Name)$('""')" -Verb runAs
}
