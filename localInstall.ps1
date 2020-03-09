# Set-ExecutionPolicy -ExecutionPolicy Undefined -Scope CurrentUser	
# Set-ExecutionPolicy -ExecutionPolicy Undefined -Scope LocalMachine
# Set-ExecutionPolicy -ExecutionPolicy Undefined -Scope Process

$principal = New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent())

if($principal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    "`nRunning Powershell with full privileges`n"

    #CD's into Folder to set the execution policies
    Set-Location -Path 'c:\windows-monitoring-master\local\winlogbeat'
    Set-ExecutionPolicy Unrestricted
    "Winlogbeat Execution policy set - Success"

    Set-Location -Path 'c:\windows-monitoring-master\local\auditbeat'
    Set-ExecutionPolicy Unrestricted
    "Auditbeat Execution policy set - Success"

    Set-Location -Path 'c:\windows-monitoring-master\local\metricbeat'
    Set-ExecutionPolicy Unrestricted
    "Metricbeat Execution policy set - Success`n"

    Set-Location -Path 'c:\windows-monitoring-master'

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
    Set-Location -Path 'c:\windows-monitoring-master\local\winlogbeat'

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
    #.\winlogbeat.exe setup --dashboards

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

    Set-Location -Path 'C:\windows-monitoring-master\local\metricbeat'

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
    #.\metricbeat.exe setup --dashboards

    #Install metricbeat as a service
    .\install-service-metricbeat.ps1

    #Runs metricbeat as a Service
    Start-service metricbeat

    #Show that metricbeat is running
    Get-Service metricbeat


    #=========== Auditbeat ============#

    #Load Auditbeat credentials
    "`nAdding Auditbeat Credentials`n"

    Set-Location -Path 'C:\windows-monitoring-master\local\auditbeat'

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
        ForEach-Object {$_ -Replace "auditbeat-path", "$($directoryPath1)"} |
            Set-Content auditbeat.yml

    #Install auditbeat as a service
    .\install-service-auditbeat.ps1

    #Start Auditbeat
    Start-Service auditbeat

    #Run Auditbeat restart in the background
    ##Start-Job -FilePath "C:\windows-monitoring-master\scripts\auditbeatRestart.ps1"

    ##powershell.exe -windowstyle hidden -file C:\windows-monitoring-master\scripts\auditbeatRestart.ps1

    Set-Location -Path 'C:\windows-monitoring-master\scripts'

    "`nRunning Auditbeat Refresh For External Devices"

    .\auditbeatRestart.ps1

    #Close Powershell window
    #Stop-Process -Id $PID

    Start-Sleep 20
}
else {
    Start-Process -FilePath "powershell" -ArgumentList "$('-File ""')$(Get-Location)$('\')$($MyInvocation.MyCommand.Name)$('""')" -Verb runAs
}