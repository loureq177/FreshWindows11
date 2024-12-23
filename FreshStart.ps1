# Set Dark Mode for Windows 11
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" -Name "AppsUseLightTheme" -Value 0
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" -Name "SystemUsesLightTheme" -Value 0

# Set region to Poland
Set-WinHomeLocation -GeoId 191

$appList = @(
    "Google.Chrome",
    "Discord.Discord",
    "Spotify.Spotify",
    "VScode",
    "WhatsApp",
    "Notion.Notion",
    "Python",
    "Git.Git",
    "Valve.Steam",
    "Lenovo Vantage"
)

foreach ($app in $appList) {
    winget install $app
}

$appsToUninstall = @(
    'Microsoft OneDrive',
    'Phone Link',
    'Xbox',
    'News',
    'Microsoft 365',
    'Solitaire & Casual Games',
    'Family',
    'Feedback Hub',
    'Microsoft Teams',
    'MSN Weather',
    'Sticky Notes'
)

foreach ($app in $appsToUninstall) {
    winget uninstall $app
}

# Unpin everything from Taskbar
Remove-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Taskband" -Name "Favorites" -ErrorAction SilentlyContinue
Stop-Process -Name explorer -Force

# Disable all startup applications
$startupFolders = @(
    [Environment]::GetFolderPath("Startup"), # User Autostart
    "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Startup" # All Users Autostart
)

$startupFolders | ForEach-Object {
    Get-ChildItem -Path $_ -Recurse -File | ForEach-Object {
        try {
            Remove-Item -Path $_.FullName -Force
            Write-Host "Usunięto plik autostartu: $($_.Name)" -ForegroundColor Green
        } catch {
            Write-Host "Nie udało się usunąć pliku: $($_.Name)" -ForegroundColor Yellow
        }
    }
}

# Open File Explorer to 'This PC'
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "LaunchTo" -Value 1

# Remove OneDrive from environment variables
[System.Environment]::SetEnvironmentVariable('OneDrive', '', 'User')
[System.Environment]::SetEnvironmentVariable('OneDriveCommercial', '', 'User')
[System.Environment]::SetEnvironmentVariable('OneDriveConsumer', '', 'User')

# - Update all MS Store apps
winget upgrade --all 

# - Update Windows
Install-Module -Name PSWindowsUpdate -Force
$env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")
Import-Module PSWindowsUpdate
Set-ExecutionPolicy Unrestricted -Scope CurrentUser -Force
Install-WindowsUpdate -AcceptAll -AutoReboot

# TODO in version 2:
# - Install polish keyboard
# - Add Polish keyboard layout
# - Pin apps to Taskbar
# - Remove english UK keyboard
# - Oh my Posh! - Finish setting up


winget install JanDeDobbeleer.OhMyPosh
Write-Host "Continuing script..."

# Refresh environment variables so restart is not required
$env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")
oh-my-posh font install FiraCode
Add-Content -Path $PROFILE -Value 'oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH\atomic.omp.json" | Invoke-Expression'
