FROM microsoft/iis

RUN powershell -NoProfile -Command Remove-Item -Recurse C:\inetpub\wwwroot\*

#ADD https://download.microsoft.com/download/C/9/E/C9E8180D-4E51-40A6-A9BF-776990D8BCA9/rewrite_amd64.msi /install/rewrite_amd64.msi

#RUN msiexec.exe /i c:\install\rewrite_amd64.msi /passive
RUN dism /online /enable-feature /all /featurename:iis-webserver /NoRestart

WORKDIR /inetpub/wwwroot

COPY . /inetpub/wwwroot
