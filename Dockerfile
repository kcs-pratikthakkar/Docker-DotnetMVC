#FROM mcr.microsoft.com/windows/servercore/iis

#SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop';"]

#WORKDIR /inetpub/wwwroot

#COPY index.html .

#EXPOSE 80

#ENTRYPOINT ["C:\\ServiceMonitor.exe", "w3svc"]


FROM mcr.microsoft.com/windows/servercore/iis

SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop';"]

RUN Install-WindowsFeature -name Web-Server -IncludeManagementTools ;\
    Install-WindowsFeature -name Web-Basic-Auth ;\
    Install-WindowsFeature -name Web-Windows-Auth ;\
    Install-WindowsFeature -name Web-Net-Ext45 ;\
    Install-WindowsFeature -name Web-ISAPI-Ext ;\
    Install-WindowsFeature -name Web-ISAPI-Filter ;\
    Install-WindowsFeature -name Web-WHC ;\
    Install-WindowsFeature NET-Framework-45-ASPNET ; \
    Install-WindowsFeature Web-Asp-Net45 ;\
    Install-WindowsFeature -Name Web-Mgmt-Service ;\
    Install-WindowsFeature -name Web-Mgmt-Tools ;\
    Install-WindowsFeature -name Web-Mgmt-Compat ;\
    Install-WindowsFeature -name Web-Scripting-Tools ;\
    Dism /online /enable-feature /featurename:IIS-ManagementService /all ;\
    ##Still inside the same run command, enable remote management for IIS on docker
    New-ItemProperty -Path HKLM:\SOFTWARE\Microsoft\WebManagement\Server -Name EnableRemoteManagement -Value 1 -Force ;\
    Get-Service -Name WMSVC | Start-Service ;\
    Set-Service –Name WMSVC –StartupType 'Automatic' ;\
    ##In the same run Command add the user and password for IIS remote management
        net user myuser superP@ss123 /ADD ;\
        net localgroup administrators myuser /add
        
    COPY . myapp
    RUN New-WebAppPool myapp
RUN Import-Module WebAdministration; Get-Module ;\
    New-Item 'IIS:Sites\Default Web Site\myapp' -physicalPath 'c:\myapp' -ApplicationPool 'myapp' -type 'Application'
EXPOSE 80
