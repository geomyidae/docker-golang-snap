FROM ubuntu
MAINTAINER Jacques Supcik <jacques@supcik.net>

RUN apt-get update && apt-get install -y --no-install-recommends \
		g++ \
		gcc \
		libc6-dev \
		make \
		patch \
		scons \
		pkg-config \
		ca-certificates \
		curl \
		python \
		git \
		gcc-arm-linux-gnueabihf \
		binutils-arm-linux-gnueabihf \
		gccgo-arm-linux-gnueabihf \
		snapcraft \
	&& rm -rf /var/lib/apt/lists/*

ENV GOLANG_VERSION 1.7.4
ENV GOLANG_DOWNLOAD_URL https://golang.org/dl/go$GOLANG_VERSION.linux-amd64.tar.gz
ENV GOLANG_DOWNLOAD_SHA256 47fda42e46b4c3ec93fa5d4d4cc6a748aa3f9411a2a2b7e08e3a6d80d753ec8b

RUN curl -fsSL "$GOLANG_DOWNLOAD_URL" -o golang.tar.gz \
	&& echo "$GOLANG_DOWNLOAD_SHA256  golang.tar.gz" | sha256sum -c - \
	&& tar -C /usr/local -xzf golang.tar.gz \
	&& rm golang.tar.gz

ENV GOPATH /go
ENV PATH $GOPATH/bin:/usr/local/go/bin:$PATH

RUN mkdir -p "$GOPATH/src" "$GOPATH/bin" && chmod -R 777 "$GOPATH"

COPY go-wrapper /usr/local/bin/
WORKDIR $GOPATH
