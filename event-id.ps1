# Get the ID and security principle of the current user
$myWindowsID = [System.Security.Principal.WindowsIdentity]::GetCurrent()
$myWindowsPrincipal = New-Object System.Security.Principal.WindowsPrincipal($myWindowsID)

# Check if the current user has administrative privileges
$adminRole = [System.Security.Principal.WindowsBuiltInRole]::Administrator

if (-not ($myWindowsPrincipal.IsInRole($adminRole))) {
    # Relaunch as administrator
    Start-Process powershell.exe -Verb RunAs -ArgumentList ("-File", $MyInvocation.MyCommand.Definition)
    Exit
}

# Event IDs to retrieve
$eventIDs = @(4625, 4688, 4648, 1102)

# Brief information about each Event ID
$eventDescriptions = @{
    4624 = "Successful account log on"
4625 = "Failed account log on"
4634 = "An account logged off"
4648 = "A logon attempt was made with explicit credentials"
4688 = "A new process was created. When a pentester successfully gain access."
4719 = "System audit policy was changed."
4964 = "A special group has been assigned to a new log on"
1102 = "Audit log was cleared. This can relate to a potential attack"
4720 = "A user account was created"
4722 = "A user account was enabled"
4723 = "An attempt was made to change the password of an account"
4725 = "A user account was disabled"
4728 = "A user was added to a privileged global group"
4732 = "A user was added to a privileged local group"
4756 = "A user was added to a privileged universal group"
4738 = "A user account was changed"
4740 = "A user account was locked out"
4760 = "A SID-History was added to an account. Some advanced malware can use this to move laterally"
4767 = "A user account was unlocked"
4735 = "A privileged local group was modified"
4737 = "A privileged global group was modified"
4755 = "A privileged universal group was modified"
4772 = "A Kerberos authentication ticket request failed"
4776 = "The domain controller attempted to validate the credentials for an account."
4777 = "The domain controller failed to validate the credentials of an account."
4782 = "Password hash an account was accessed"
4789 = "The password hash of the account was accessed. This can occur when users or applications attempt to change password"
4616 = "System time was changed"
4657 = "A registry value was changed"
4697 = "An attempt was made to install a service"
4698 = "Events related to Windows scheduled tasks being created, modified, deleted, enabled or disabled"
4699 = "Events related to Windows scheduled tasks being created, modified, deleted, enabled or disabled"
4700 = "Events related to Windows scheduled tasks being created, modified, deleted, enabled or disabled"
4701 = "Events related to Windows scheduled tasks being created, modified, deleted, enabled or disabled"
4702 = "Events related to Windows scheduled tasks being created, modified, deleted, enabled or disabled"
4663 = "An attempt was made to access an object. Normal File or directory access"
4946 = "A rule was added to the Windows Firewall exception list"
4947 = "A rule was modified in the Windows Firewall exception list"
4950 = "A setting was changed in Windows Firewall"
4954 = "Group Policy settings for Windows Firewall has changed"
5025 = "The Windows Firewall service has been stopped"
5031 = "Windows Firewall blocked an application from accepting incoming traffic"
5152 = "A network packet was blocked by Windows Filtering Platform"
5153 = "A network packet was blocked by Windows Filtering Platform"
5155 = "Windows Filtering Platform blocked an application or service from listening on a port"
5157 = "Windows Filtering Platform blocked a connection"
5447 = "A Windows Filtering Platform filter was changed"
}

# Define the date range for event retrieval
$startDate = Get-Date "2023-01-01"
$endDate = Get-Date "2023-12-31"

# Array to store events
$allEvents = @()

# Loop through each Event ID and fetch the events within the specified date range
foreach ($id in $eventIDs) {
    Write-Host "Event ID: $id within the date range: $startDate to $endDate"
    
    # Retrieve events for the specified ID across all logs
    $events = Get-WinEvent -FilterHashtable @{
        LogName = 'Security'
        ID = $id
        StartTime = $startDate
        EndTime = $endDate
    } -ErrorAction SilentlyContinue

    if ($events) {
        $allEvents += $events  # Store retrieved events in the array
        Write-Host "---------------------------------------`n"  # Add a separator
        Write-Host "Found Events for Event ID $id :" -ForegroundColor Red
        Write-Host "---------------------------------------`n"  # Add a separator

        # Display fetched events with details
        $events | Select-Object TimeCreated, Id, Message | Format-Table -AutoSize
        Write-Host $eventDescriptions[$id] -ForegroundColor Red
        Write-Host "---------------------------------------`n"  # Add a separator
    } else {
        Write-Host "---------------------------------------`n"  # Add a separator
        Write-Host "No events found for Event ID $id within the date range`n" -ForegroundColor Green
        Write-Host "---------------------------------------`n"  # Add a separator
    }
}

# Prompt to save fetched events to a CSV file
$saveToCSV = Read-Host "save to a CSV file? (Y/N)"

if ($saveToCSV -eq "Y" -or $saveToCSV -eq "y") {
    $filePath = Read-Host "Enter the file path to save the CSV (e.g., C:\Path\filename.csv):"
    
    if ($allEvents) {
        $allEvents | Export-Csv -Path $filePath -NoTypeInformation
        Write-Host "Events saved to $filePath"
    } else {
        Write-Host "No events found to save."
    }
}

# Prompt to keep the window open
Read-Host "Press Enter to exit"
