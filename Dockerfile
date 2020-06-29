FROM microsoft/iis
 
RUN mkdir c:\myapp
RUN powershell -NoProfile -Command \
    Install-WindowsFeature NET-Framework-45-ASPNET; \
    Install-WindowsFeature Web-Asp-Net45; \
    Import-Module IISAdministration; \
    New-IISSite -Name "MyApp" -PhysicalPath C:\myapp -BindingInformation "*:80:"
 
EXPOSE 80
 
ADD bin/ /myapp
