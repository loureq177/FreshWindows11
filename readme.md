# FreshWindows11 🚀

A PowerShell script to set up a fresh Windows 11 environment with preferred settings and applications.

## Features ✨

- Set Dark Mode for Windows 11 🌑
- Set region to Poland 🇵🇱
- Install essential applications via Winget 📦
- Uninstall unwanted pre-installed applications 🗑️
- Unpin everything from the Taskbar 📌
- Disable all startup applications 🚫
- Open File Explorer to 'This PC' instead od 'Home' 📂
- Remove OneDrive from environment variables ❌
- Update all MS Store apps ✔️
- Update Windows 🪟

## Usage 🛠️

1. **Run PowerShell as Administrator**:
   - Right-click on the Start menu and select "Windows PowerShell (Admin)".
   
2. **Execute the Script**:
   - Navigate to the directory containing `FreshStart.ps1`.
   - Run the script using the command:
     ```powershell
     .\FreshStart.ps1
     ```

## Customization 🖌️

- **Add or Remove Applications**:
  - Modify the `$appList` array to add applications you want to install.
  - Modify the `$appsToUninstall` array to add applications you want to uninstall.

- **Change Region**:
  - Update the `Set-WinHomeLocation -GeoId` command with the desired GeoId.

## Notes 📝

- Ensure Winget is installed and configured on your system.
- Some applications may require additional permissions or manual steps to complete installation.

Enjoy your fresh start with Windows 11! 🎉
