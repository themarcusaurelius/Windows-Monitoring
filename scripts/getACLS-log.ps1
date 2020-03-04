$FolderPath = Get-ChildItem -Directory -Path "C:\Panzura_Shares\CorpOffice2" -Recurse -Force
$Output = @()


for(;;) {
	try {
		"`n Getting data from folder..."
		ForEach ($Folder in $FolderPath) {
    $Acl = Get-Acl -Path $Folder.FullName
    ForEach ($Access in $Acl.Access) {
	$Properties = [ordered]@{'Folder Name'=$Folder.FullName;'Group/User'=$Access.IdentityReference;'Permissions'=$Access.FileSystemRights;'Inherited'=$Access.IsInherited}
	$Output += New-Object -TypeName PSObject -Property $Properties            
    }
}
    		
		$Response = $Output
		"`n Converting data to CSV..."
		$Response | export-csv c:\Users\Administrator\Desktop\permissions\permissions.log -NoTypeInformation
		
		"`n Sending data to outbound folder..."
		$file="c:\Users\Administrator\Desktop\permissions\permissions.log"
		
		(Get-Content $file) | Foreach-Object {$_ -replace '"', ''}|Out-File $file -Encoding UTF8
        #(Get-Content $file) | Out-GridView

		"`n Data sent successfully!"
	}
	catch {
         "`n Failed to access folder. Retrying..."
    }

 
	Start-Sleep 900
	"`n Checking folder for changes..."
    
    #C:\.\getACLS-log.ps1

    #Start-Sleep 3
}







