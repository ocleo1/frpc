FROM alpine:3.18
LABEL maintainer="Chris Wan <wpy.christopher@gmail.com>"

ARG VERSION
ENV VERSION=${VERSION}
ENV TZ=Asia/Hong_Kong
WORKDIR /opt

RUN apk add --no-cache tzdata \
    && ln -snf /usr/share/zoneinfo/${TZ} /etc/localtime \
    && echo ${TZ} > /etc/timezone

RUN if [ "$(uname -m)" = "x86_64" ]; then export PLATFORM=amd64 ; \
	elif [ "$(uname -m)" = "aarch64" ]; then export PLATFORM=arm64 ; \
	elif [ "$(uname -m)" = "armv7" ]; then export PLATFORM=arm ; \
	elif [ "$(uname -m)" = "armv7l" ]; then export PLATFORM=arm ; \
	elif [ "$(uname -m)" = "armhf" ]; then export PLATFORM=arm ; fi \
	&& wget --no-check-certificate https://github.com/fatedier/frp/releases/download/v${VERSION}/frp_${VERSION}_linux_${PLATFORM}.tar.gz \
	&& tar xzf frp_${VERSION}_linux_${PLATFORM}.tar.gz \
	&& mkdir frp_${VERSION}_linux \
	&& cp frp_${VERSION}_linux_${PLATFORM}/frpc frp_${VERSION}_linux \
	&& rm -rf *.tar.gz frp_${VERSION}_linux_${PLATFORM}

CMD /opt/frp_${VERSION}_linux/frpc -c /opt/frp_${VERSION}_linux/frpc.toml
