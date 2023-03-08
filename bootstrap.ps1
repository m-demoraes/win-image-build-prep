# Bootstraps the windows-imaging-tools build environment.

$dir = 'win-build'
$ConfigFilePath = ".\config.ini"

# This statement creates the win-build directory on the root of the first drive output from Get-PSDrive, this will typically be the primary drive
# but may not be the 'C:\' drive in some environments. If this does not fit with your environment, comment the statement out.
If ($dir = Get-Item -Path $dir -ErrorAction SilentlyContinue) {
}
elseif ((Get-PSDrive).Name -match '^[a-z]$' | New-Item -Path '\win-build' -ItemType Directory -ErrorAction SilentlyContinue) {
    Write-Host 'The win-build directory has been created'
}
else {
    Write-Host 'The win-build directory exists.'
}

# (TODO) Add support for overwritting the above statement in the event the first drive is not the primary.
#New-Item -Path 'E:\win-build' -ItemType Directory

# Move to the win-build directory
Push-Location \win-build

# Clone the Cloudbase windows-imaging-tools repository and ensure submodules are loaded.
git clone https://github.com/cloudbase/windows-openstack-imaging-tools.git
git submodule update --init

# Change to the repository and add the required modules.
Push-Location windows-openstack-imaging-tools
Import-Module .\WinImageBuilder.psm1
Import-Module .\Config.psm1
Import-Module .\UnattendResources\ini.psm1

# Generate the config.ini file.
New-WindowsImageConfig -ConfigFilePath $ConfigFilePath

# Automate the config options in config.ini
Set-IniFileValue -Path (Resolve-Path $ConfigFilePath) -Section "DEFAULT" `
                                      -Key "wim_file_path" `
                                      -Value "D:\Sources\install.wim"

# Start the imaging process using the config options set above.
New-WindowsOnlineImage -ConfigFilePath $ConfigFilePath

Pop-Location
