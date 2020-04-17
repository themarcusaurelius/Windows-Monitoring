# Complete Windows Monitoring Package

This program provides security and application monitoring to Windows computers and servers complete with visuals and alerting.

Currently provides the following features that will be monitored:

<b>Local Terminals:</b>
```
- External device plugins and data transfer monitoring
- All installed services by user or system monitoring
- File changes monitoring
- Successful/Unsuccessful logons monitoring 
```

<b>Servers:</b>
```
- All installed services by user or system monitoring
- File changes monitoring
- Successful/unsuccessful logons monitoring
- Active directory user permissions monitoring
```

## Installation

#### Local Install:

1) Download the zip file package to your local machine using the link below:

   [Zip File](https://github.com/themarcusaurelius/windows-monitoring/archive/master.zip)

2) Unzip the package and extract the contents to the `C:/` drive.

3) Open the extracted folder and double click on the `localInstall.exe`.

4) When prompted, enter your credentials below and click OK.

```css
Kibana URL: _PLACEHOLDER_KIBANA_URL_
Username: _PLACEHOLDER_USERNAME_
Password: _PLACEHOLDER_PASSWORD_
Elasticsearch API Endpoint: _PLACEHOLDER_API_ENDPOINT_
```

<p align="center">
    <img src="https://giant.gfycat.com/RewardingLikableGermanpinscher.gif">
</p>

> This will automatically configure and install `Metricbeat`, `Winlogbeat`, and `Auditbeat` as well as load any pre-packaged dashboards . 

5) When prompted again, choose the folder you would like to monitor for file changes with `Auditbeat`. If you do not wish to monitor any folders at this time, click `Cancel` to exit.

<p align="center">
    <img src="https://giant.gfycat.com/DelayedSandyHammerheadbird.gif">
</p>

<b>Congratulations! Your local machine is now connected!</b>

<hr>

#### Server Install

1) Get the [Zip](https://github.com/themarcusaurelius/windows-monitoring/archive/master.zip) package on the server.

   - Option A: Copy and paste the downloaded Zip folder from the local machine to the server.
   
   - Option B: In Powershell, as administrator, run the following request:
   
   ```css
   Start-BitsTransfer -Source 'https://github.com/themarcusaurelius/windows-monitoring/archive/master.zip' -Destination 'C:\Users\Administrator\Downloads\windows-monitoring-master.zip'
   ```

2) Unzip the package and extract the contents to the `C:/` drive.

3) Open the extracted folder and double click on the `serverInstall.exe`.

4) When prompted, enter your credentials below and click OK.

```css
Kibana URL: _PLACEHOLDER_KIBANA_URL_
Username: _PLACEHOLDER_USERNAME_
Password: _PLACEHOLDER_PASSWORD_
Elasticsearch API Endpoint: _PLACEHOLDER_API_ENDPOINT_
```

> This will automatically configure and install `Metricbeat`, `Winlogbeat`, and `Auditbeat` as well as load any pre-packaged dashboards . 

5) When prompted again, choose the folder you would like to monitor for file changes with `Auditbeat`. If you do not wish to monitor any folders at this time, click `Cancel` to exit.

Your data is now shipping!

> If this is your first time loading data into your elasticsearch instance, you will need to set one of the indices as a default in order to begin seeing logs shipping in real-time. To do this, go to the `Index Patterns` section in the `Management` tab and star the index you would like as a default. In the `Discover` tab you should begin to see your incoming logs.

## Example Dashboard

The dashboards are provided as examples. We recommend that you customize them to meet your needs.

![Imgur](https://imgur.com/mBYF75K.jpg)



