FROM mcr.microsoft.com/dotnet/core/runtime:2.2
EXPOSE 10443
EXPOSE 10080
EXPOSE 57012
RUN groupadd -g 31337 polarproxy && useradd -m -u 31337 -g polarproxy polarproxy && mkdir -p /var/log/PolarProxy /opt/polarproxy && chown polarproxy:polarproxy /var/log/PolarProxy && curl -s https://www.netresec.com/?download=PolarProxy | tar -xzf - -C /opt/polarproxy
VOLUME ["/var/log/PolarProxy/", "/home/polarproxy/"]
USER polarproxy
WORKDIR /opt/polarproxy/
ENTRYPOINT ["dotnet", "PolarProxy.dll"]
CMD ["-v", "-p", "10443,80,443", "-o", "/var/log/PolarProxy/", "--certhttp", "10080", "--pcapoverip", "0.0.0.0:57012", "-x", "/var/log/PolarProxy/polarproxy.pem"]
