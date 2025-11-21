FROM voipproxy-base AS build

COPY git-repo /tmp/git-repo

RUN if [ -f /tmp/git-repo/opensips-cli.tar.gz ]; then \
        tar -xzf /tmp/git-repo/opensips-cli.tar.gz -C /root; \
    else \
        git clone --depth=1 https://github.com/OpenSIPS/opensips-cli.git; \
    fi

RUN if [ -f /tmp/git-repo/opensips.tar.gz ]; then \
        tar -xzf /tmp/git-repo/opensips.tar.gz -C /root; \
    else \
        git clone --depth=1 --branch=3.6.2 --recurse-submodules https://github.com/OpenSIPS/opensips.git; \
    fi

RUN . /root/pyvenv/bin/activate && \
    cd /root/opensips-cli && \
    python3 setup.py install clean

RUN cd /root/opensips && \
    make include_modules="compression db_mysql dialplan regex proto_tls tls_openssl uuid" all && \
    make prefix=/opt/opensips install

FROM voipproxy-base

COPY --from=build /root/pyvenv /root/pyvenv
COPY --from=build /opt /opt

ENTRYPOINT ["sh", "-c", "tail -f /dev/null"]
