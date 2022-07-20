# umask-observe [![quay.io](https://quay.io/repository/saschagrunert/umask/status)](https://quay.io/repository/saschagrunert/umask)

Observing umask changes for processes as well as containers.

Run via:

```console
> sudo podman run \
    -v /sys/kernel/debug:/sys/kernel/debug \
    --pull always \
    --privileged \
    --pid host \
    --rm \
    -it \
    quay.io/saschagrunert/umask:latest
```

### Demo

In an OpenShift 4 cluster, run the container on the node where the umask
observation should run:

```console
> sudo podman run \
    -v /sys/kernel/debug:/sys/kernel/debug \
    --pull always \
    --privileged \
    --pid host \
    --rm \
    -it \
    quay.io/saschagrunert/umask:latest
Running in /tmp/tmp.xY5LZLayZY
Attaching 1 probe...
```

We now can run a test container in a second terminal on the target node and modify the
umask like this:

```
> oc debug node/node-00.openshift.com
sh-4.4# umask 123
sh-4.4# umask 321
```

The terminal where the initial container runs should now output umask changes,
for example:

```
…
13:48:44 - runc:[2:INIT] (PID: 1370068, ID: e44c068c0446b): 0000
13:48:44 - runc:[2:INIT] (PID: 1370068, ID: e44c068c0446b): 0000
13:48:44 - runc:[2:INIT] (PID: 1370068, ID: e44c068c0446b): 0022
…
13:50:15 - sh (PID: 1370068, ID: e44c068c0446b): 0123
13:50:18 - sh (PID: 1370068, ID: e44c068c0446b): 0321
```

We can see that `umask-observe` prints the time, the process name, the process
ID (PID) as well as the container ID (if available). The container ID maps
directly to the same identifiers used by tools like
[`crictl`](https://github.com/kubernetes-sigs/cri-tools).
