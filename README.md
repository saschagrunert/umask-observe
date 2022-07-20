# umask-observe [![quay.io](https://quay.io/repository/saschagrunert/umask/status)](https://quay.io/repository/saschagrunert/umask)

Observing umask changes for processes as well as containers.

Run via:

```console
> sudo podman run \
    -v /sys/kernel/debug:/sys/kernel/debug \
    --pull always \
    --privileged \
    --rm \
    -it \
    quay.io/saschagrunert/umask:latest
```
