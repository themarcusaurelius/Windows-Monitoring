# Set-ExecutionPolicy -ExecutionPolicy Undefined -Scope CurrentUser	
# Set-ExecutionPolicy -ExecutionPolicy Undefined -Scope LocalMachine
# Set-ExecutionPolicy -ExecutionPolicy Undefined -Scope Process

$principal = New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent())

if($principal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    'You are running Powershell with full privileges'

    #Github URL For Package
    $url = 'https://github.com/themarcusaurelius/windows-package/archive/master.zip'

    #Path Where Package Will Be Downloaded
    $zip = 'C:\windows-security-package.zip'

    (New-Object Net.WebClient).DownloadFile($url,$zip)

    [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
    Invoke-WebRequest -Uri $url
}
else {
    Start-Process -FilePath "powershell" -ArgumentList "$('-File ""')$(Get-Location)$('\')$($MyInvocation.MyCommand.Name)$('""')" -Verb runAs
}
