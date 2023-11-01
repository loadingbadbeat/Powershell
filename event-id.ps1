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

# Define the date range for event retrieval
$startDate = Get-Date "2023-01-01"
$endDate = Get-Date "2023-12-31"

# Array to store events
$allEvents = @()

# Loop through each Event ID and fetch the events within the specified date range
foreach ($id in $eventIDs) {
    Write-Host "Event ID: $id within the date range: $startDate to $endDate"
    
    # Retrieve events for the specified ID
    $events = Get-WinEvent -FilterHashtable @{
        LogName = 'Security'
        ID = $id
        StartTime = $startDate
        EndTime = $endDate
    } -ErrorAction SilentlyContinue

    if ($events) {
        $allEvents += $events  # Store retrieved events in the array
        Write-Host "---------------------------------------`n"  # Add a separator
        Write-Host "Found Events for Event ID $id :" -ForegroundColor Red -NoNewline
        Write-Host " ---------------------------------------`n" -ForegroundColor Red -NoNewline
        Write-Host "Event ID $id could signify different security-related issues." -ForegroundColor Red
        Write-Host "---------------------------------------`n"  # Add a separator

        # Display fetched events with details
        $events | Select-Object TimeCreated, Id, Message | Format-Table -AutoSize
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
