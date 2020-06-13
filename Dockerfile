# escape=`
FROM mcr.microsoft.com/windows/servercore/iis:windowsservercore-1803

SHELL ["powershell", "-command"]

RUN Install-WindowsFeature Web-ASP; `

EXPOSE 80

RUN Remove-Website -Name 'Default Web Site'; `
    md c:\mywebsite; `
    New-IISSite -Name "mywebsite" `
                -PhysicalPath 'c:\mywebsite' `
                -BindingInformation "*:80:";

ADD . c:\mywebsite
