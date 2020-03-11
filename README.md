# Complete Windows Monitoring Package

This program provides security and application monitoring to Windows computers and servers complete with visuals and alerting.

Currently provides the following features that will be monitored:

<b>Local Terminals:</b>
- External device plugins and data transfer monitoring
- All installed services by user or system monitoring
- File changes monitoring
- Successful/Unsuccessful logons monitoring 


<b>Servers</b>
- All installed services by user or system monitoring
- File changes monitoring
- Successful/unsuccessful logons monitoring
- Active directory user permissions monitoring

### Installation & Setup

1. Download the zip file package to your local machine using the link below:

   [Zip File](https://github.com/themarcusaurelius/windows-monitoring/archive/master.zip)
   
#### Local Install:

1. Unzip the package and extract the contents to the `C:/` drive.

2. Open the extracted folder and double click on the `localInstall.exe`.

3. When prompted, enter the credentials provided when you created your stack and click OK.

<p align="center">
    <img src="https://giant.gfycat.com/RewardingLikableGermanpinscher.gif">
</p>

> This will automatically configure and install `Metricbeat`, `Winlogbeat`, and `Auditbeat` as well as load any pre-packaged dashboards . 

4. When prompted again, choose the folder you would like to monitor for file changes with `Auditbeat`. 

<p align="center">
    <img src="https://giant.gfycat.com/DelayedSandyHammerheadbird.gif">
</p>

<b>Congratulations! Your local machine is now connected!</b>




