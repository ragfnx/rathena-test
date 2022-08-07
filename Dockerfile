FROM alpine:latest AS BUILDER
RUN apk update && \
    apk add --no-cache git cmake make gcc g++ gdb zlib-dev mariadb-dev ca-certificates linux-headers bash
WORKDIR /build/rathena/
COPY . .
RUN chmod a+x configure
RUN ./configure --enable-packetver=20151104
RUN make clean server

FROM alpine:latest
MAINTAINER Nathan Santos <nathan.dgsantos@gmail.com>
RUN apk update && \
    apk add zlib-dev mariadb-dev ca-certificates bash
RUN addgroup -S rathena && \
    adduser -S -h /rathena/ rathena -G rathena
USER rathena
WORKDIR /rathena/
COPY --from=BUILDER /build/rathena/conf         ./conf
COPY --from=BUILDER /build/rathena/db           ./db
COPY --from=BUILDER /build/rathena/npc          ./npc
COPY --from=BUILDER /build/rathena/login-server .
COPY --from=BUILDER /build/rathena/char-server  .
COPY --from=BUILDER /build/rathena/map-server   .
COPY entrypoint.sh  .
USER root
RUN ln -s /rathena/login-server     /usr/local/bin/login-server && \
    ln -s /rathena/char-server      /usr/local/bin/char-server  && \    
    ln -s /rathena/map-server       /usr/local/bin/map-server   && \
    ln -s /rathena/entrypoint.sh    /usr/local/bin/entrypoint.sh
RUN chmod a+x login-server char-server map-server entrypoint.sh
RUN chown rathena:rathena -R /rathena/
USER rathena

ENTRYPOINT [ "entrypoint.sh" ]