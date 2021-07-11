FROM --platform=linux/amd64 amazonlinux

HEALTHCHECK --interval=30s --timeout=10s --start-period=10s --retries=1 CMD curl --connect-timeout 1 --max-time 10 --fail --fail-early -I localhost/calc?input=testing

ADD ./bins/server /bins/server

RUN chmod +x /bins/server

EXPOSE 80

CMD [ "/server" ]
