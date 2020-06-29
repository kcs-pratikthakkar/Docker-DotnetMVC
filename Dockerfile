FROM microsoft/iis

RUN powershell -NoProfile -Command \
    Install-WindowsFeature NET-Framework-45-ASPNET; \
    Install-WindowsFeature Web-Asp-Net45; \
    Import-Module IISAdministration;

EXPOSE 80
WORKDIR /inetpub/wwwroot

#RUN Remove-Item * -recurse
ADD bin/ /inetpub/wwwroot
