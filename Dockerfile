FROM fedora:rawhide

RUN dnf install -y bpftrace
ADD umask-observe /usr/local/bin
ENTRYPOINT ["/usr/local/bin/umask-observe"]
