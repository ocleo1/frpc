# frpc

## Build

```shell
export FRPC_VERSION=0.54.0 \
&& docker build --build-arg VERSION=${FRPC_VERSION} . -t frpc:${FRPC_VERSION}
```

## Run

https://docs.docker.com/network/network-tutorial-host/

```shell
export FRPC_VERSION=0.54.0 \
&& docker run -d \
    --name=frpc \
    --restart=unless-stopped \
    --network host \
    -v ./frpc.toml:/opt/frp_${FRPC_VERSION}_linux/frpc.toml \
    frpc:${FRPC_VERSION}
```
