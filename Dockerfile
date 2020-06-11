
FROM mcr.microsoft.com/windows/servercore/iis:windowsservercore-ltsc2019
WORKDIR /inetpub/wwwroot
COPY . /inetpub/wwwroot
