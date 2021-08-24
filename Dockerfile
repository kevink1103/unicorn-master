FROM --platform=linux/amd64 amazonlinux

HEALTHCHECK --interval=30s --timeout=10s --start-period=10s --retries=1 CMD curl --connect-timeout 1 --max-time 10 --fail --fail-early -I localhost/calc?input=testing

ADD ./bins/server2 /server2

RUN chmod +x /server2

EXPOSE 80

CMD [ "/server2" ]
