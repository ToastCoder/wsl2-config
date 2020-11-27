if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) 
{ 
    Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs;
    exit 
}

function setupWsl1
{
    wsl.exe bash init.sh
}
function convertWslToWSL2
{
    Write-Output "Printing list of WSL's and their version..."
    wsl --list --verbose
    $distro_name = Read-Host "What is the distro which you have installed? (Mention the exact Name and Version)"
    Write-Output "Downloading WSL2 Update Package"
    Invoke-WebRequest -Uri https://wslstorestorage.blob.core.windows.net/wslblob/wsl_update_x64.msi -OutFile wsl_update_x64.msi
    ./wsl_update_x64.msi
    Write-Output "Starting WSL Bash..."
    wsl.exe bash init.sh
    Write-Output "Converting WSL1 to WSL2..."
    wsl --set-version $distro_name 2
    Write-Output "Printing updated list of WSL's and their version..."
    wsl --list --verbose

}

Write-Output " WSL Auto Configure Tool"
Write-Output "Please follow the instructions as the setup goes on!"

$distro_opt = Read-Host "Have you downloaded any WSL Linux distribution from Microsoft Store? (Y/N)"

if ($distro_opt -eq "n" -OR $distro_opt -eq "N")
{
    Write-Output "Enabling Windows Subsystem for Linux from Windows Features..."
    dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart

    Write-Output "Enabling Virtual Machine from Windows Features..."
    dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart

    Write-Output "Kindly install a WSL distribution from Microsoft Store and restart the script..."
    Write-Output "Find it on https://www.microsoft.com/en-in/search?q=wsl"
    
}
elseif ($distro_opt -eq "y" -OR $distro_opt -eq "Y")
{
    setupWsl1
    convertWslToWSL2
}

Write-Host -NoNewLine 'Press any key to close this terminal:';
$null = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown');