Write-Output " WSL Auto Configure Tool"
Write-Output "Please follow the instructions as the setup goes on!"

$distro_opt = Read-Host "Have you downloaded any WSL Linux distribution from Microsoft Store? (Y/N)"

if ($distro_opt -eq "y" -OR $distro_opt -eq "Y")
{
    $distro_name = Read-Host "What is the distro which you have installed? (Mention the exact Name and Version)"
}
else 
{
    Write-Output "Enabling Windows Subsystem for Linux from Windows Features..."
    dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart

    Write-Output "Enabling Virtual Machine from Windows Features..."
    dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart

    Write-Output "Kindly install a WSL distribution from Microsoft Store"
    Write-Output "https://www.microsoft.com/en-in/search?q=wsl"
}