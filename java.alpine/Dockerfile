FROM alpine:3.12 as alpine-java-jdk8-deps

WORKDIR /opt

ENV JAVA_DOWNLOAD_URL https://download.oracle.com/otn-pub/java/jdk/8u311-b11/4d5417147a92418ea8b615e228bb6935/jdk-8u311-linux-x64.tar.gz

RUN apk --no-cache upgrade && \
    apk add --no-cache wget && \
    wget -c --no-cookies --no-check-certificate --header "Cookie: oraclelicense=accept-securebackup-cookie" -O java.tar.gz ${JAVA_DOWNLOAD_URL} && \
    JAVA_FOLDER=$(tar tf java.tar.gz | head -1 | cut -f1 -d "/") && \
    tar -zxf java.tar.gz && \
    ln -s /opt/${JAVA_FOLDER} /opt/jdk && \
    rm -rf /tmp/* /var/cache/apk/* && \
    rm java.tar.gz

RUN rm -rf /opt/jdk/*src.zip \
           /opt/jdk/lib/missioncontrol \
           /opt/jdk/lib/visualvm \
           /opt/jdk/lib/*javafx* \
           /opt/jdk/jre/plugin \
           /opt/jdk/jre/bin/javaws \
           /opt/jdk/jre/bin/jjs \
           /opt/jdk/jre/bin/orbd \
           /opt/jdk/jre/bin/pack200 \
           /opt/jdk/jre/bin/policytool \
           /opt/jdk/jre/bin/rmid \
           /opt/jdk/jre/bin/rmiregistry \
           /opt/jdk/jre/bin/servertool \
           /opt/jdk/jre/bin/tnameserv \
           /opt/jdk/jre/bin/unpack200 \
           /opt/jdk/jre/lib/javaws.jar \
           /opt/jdk/jre/lib/deploy* \
           /opt/jdk/jre/lib/desktop \
           /opt/jdk/jre/lib/*javafx* \
           /opt/jdk/jre/lib/*jfx* \
           /opt/jdk/jre/lib/amd64/libdecora_sse.so \
           /opt/jdk/jre/lib/amd64/libprism_*.so \
           /opt/jdk/jre/lib/amd64/libfxplugins.so \
           /opt/jdk/jre/lib/amd64/libglass.so \
           /opt/jdk/jre/lib/amd64/libgstreamer-lite.so \
           /opt/jdk/jre/lib/amd64/libjavafx*.so \
           /opt/jdk/jre/lib/amd64/libjfx*.so \
           /opt/jdk/jre/lib/ext/jfxrt.jar \
           /opt/jdk/jre/lib/ext/nashorn.jar \
           /opt/jdk/jre/lib/oblique-fonts \
           /opt/jdk/jre/lib/plugin.jar


FROM alpine:3.12

ENV JAVA_HOME=/opt/jdk \
    PATH=${PATH}:/opt/jdk/bin \
    LANG=C.UTF-8

COPY --from=alpine-java-jdk8-deps /opt/jdk /opt/jdk
COPY ./init.sh /init.sh

RUN chmod +x /init.sh && \
    GLIBC_VERSION="2.32-r0" && \
    GLIBC_PACKAGE_FILENAME="glibc-$GLIBC_VERSION.apk" && \
    apk add --no-cache --virtual=.build-dependencies ca-certificates wget && \
    wget -q -O "/etc/apk/keys/sgerrand.rsa.pub" "https://alpine-pkgs.sgerrand.com/sgerrand.rsa.pub" && \
    wget "https://github.com/sgerrand/alpine-pkg-glibc/releases/download/$GLIBC_VERSION/$GLIBC_PACKAGE_FILENAME" && \
    apk add --no-cache "$GLIBC_PACKAGE_FILENAME" && \
    apk del .build-dependencies && \
    rm "$GLIBC_PACKAGE_FILENAME" && \
    rm "/etc/apk/keys/sgerrand.rsa.pub" && \
    rm -rf /tmp/* /var/cache/apk/*

RUN which java && \
    java -version

ENTRYPOINT ["/init.sh"]