#RUN powershell -NoProfile -Command Remove-Item -Recurse C:\inetpub\wwwroot\*
FROM microsoft/iis

RUN powershell -NoProfile -Command Remove-Item -Recurse C:\inetpub\wwwroot\*

WORKDIR /inetpub/wwwroot

COPY . /inetpub/wwwroot
