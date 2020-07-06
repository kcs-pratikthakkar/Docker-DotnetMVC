FROM microsoft/iis

WORKDIR /inetpub/wwwroot

ADD Content/D_C/a/1/s/SmartTownAPI/obj/Release/Package/PackageTmp /inetpub/wwwroot

RUN powershell -NoProfile -Command \
    Install-WindowsFeature NET-Framework-45-ASPNET; \
    Install-WindowsFeature Web-Asp-Net45; \
    Import-Module IISAdministration;

EXPOSE 80
