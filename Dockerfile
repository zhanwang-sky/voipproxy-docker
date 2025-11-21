FROM voipproxy-base AS build

RUN . /root/pyvenv/bin/activate && \
    git clone --depth=1 https://github.com/OpenSIPS/opensips-cli.git && \
    cd opensips-cli && \
    python3 setup.py install clean

FROM voipproxy-base

COPY --from=build /root/pyvenv /root/pyvenv

ENTRYPOINT ["sh", "-c", "tail -f /dev/null"]
