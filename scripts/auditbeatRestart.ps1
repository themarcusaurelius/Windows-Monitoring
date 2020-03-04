#Restarts Auditbeat every 15 seconds to enable the USB Capture
    for(;;) {
        try {
            "`nRefreshing Auditbeat...`n"
            Restart-Service auditbeat
            Get-Service auditbeat
            "`nAuditbeat Refreshed!"
            "`n---------------------------------------------"
        }
        catch {
        "`n Failed to re-start Auditbeat. Retrying..."
        
        }
        # wait for defined amount of time
        Start-Sleep 15
    }