# Bootstrap a Cloudbase windows-imaging-tools environment
bootstrap.ps1 will bootstrap the windows-imaging-tools environment and generate the image.

There are some requirements that need to be met prior to bootstrapping.

Requirements:
ExecutionPolicy - `Set-ExecutionPolicy -Scope LocalMachine -ExecutionPolicy RemoteSigned -Force`
git for Windows - https://github.com/git-for-windows/git/releases/download/v2.39.2.windows.1/Git-2.39.2-64-bit.exe
Windows image .iso file mounted as `D:\`


Additionally, you can edit the `bootstrap.ps1` script to define what config.ini options should be set.
This is found under the `Automate the config options in config.ini` comment in the script.

