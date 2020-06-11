# The `FROM` instruction specifies the base image. You are
# extending the `microsoft/aspnet` image.
FROM mcr.microsoft.com/windows/servercore/iis

WORKDIR /inetpub/wwwroot

# The final instruction copies the site you published earlier into the container.
COPY . /inetpub/wwwroot
