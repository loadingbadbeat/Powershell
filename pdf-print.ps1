# Define the folder path to monitor
$folderPath = "C:\print"

# Define the printer name
$printerName = "ZDesigner GX420d"

# Create a FileSystemWatcher to monitor the folder for new PDF files
$watcher = New-Object System.IO.FileSystemWatcher
$watcher.Path = $folderPath
$watcher.Filter = "*.pdf"
$watcher.IncludeSubdirectories = $false
$watcher.EnableRaisingEvents = $true

# Define the function to handle file creation events
function Start-AdobeReaderPrint($file) {
    # Specify the path to Adobe Reader executable
    $adobeReaderPath = "C:\Program Files\Adobe\Acrobat DC\Acrobat\Acrobat.exe"

    # Use Adobe Reader to print the PDF file to the selected printer
    $printProcess = Start-Process -FilePath $adobeReaderPath -ArgumentList "/t `"$file`" `"$printerName`"" -PassThru

    # Wait for the Adobe Reader process to finish before attempting to delete the file
    $printProcess.WaitForExit()

    # Pause for a moment to allow Adobe Reader to complete its print job
    Start-Sleep -Seconds 5

    # Delete the file after a short delay (adjust the sleep duration as needed)
    Remove-Item -Path $file -Force
}

# Register the event handler for file creation
Register-ObjectEvent -InputObject $watcher -EventName Created -SourceIdentifier FileCreated -Action {
    $file = $Event.SourceEventArgs.FullPath
    Write-Host "New PDF file detected: $file"
    Start-AdobeReaderPrint -file $file
}

# Display a message to indicate that the script is running
Write-Host "Monitoring folder $folderPath for PDF files. Press Ctrl+C to stop."

# Keep the script running
try {
    while ($true) {
        Wait-Event -Timeout 1
    }
} finally {
    # Unsubscribe from events when the script is interrupted
    Unregister-Event -SourceIdentifier FileCreated
    $watcher.Dispose()
}
