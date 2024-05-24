# Define variables
$githubUrl = "https://raw.githubusercontent.com/jzuds/cs-autoexec/main/autoexec.cfg"
$destinationPath = "C:\Program Files (x86)\Steam\steamapps\common\Counter-Strike Global Offensive\game\csgo\cfg\autoexec.cfg"
$tempPath = "D:\temp\autoexec.cfg"
$logFilePath = "D:\temp\cs-autoexec.log"


# Start logging
Start-Transcript -Path $logFilePath -Append

try {
    # Download the file from GitHub
    Invoke-WebRequest -Uri $githubUrl -OutFile $tempPath

    # Compare the new file with the existing file
    if (-Not (Test-Path $destinationPath) -or (Get-FileHash $tempPath).Hash -ne (Get-FileHash $destinationPath).Hash) {
        # Copy the new file to the destination
        Copy-Item -Path $tempPath -Destination $destinationPath -Force
        Write-Output "File has been updated and copied to $destinationPath"
    } else {
        Write-Output "No changes detected."
    }
} catch {
    Write-Output "Error occurred: $_"
}

# Clean up the temporary file
Remove-Item $tempPath -Force

# Stop logging
Stop-Transcript

