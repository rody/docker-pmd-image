FROM openjdk:8-jre-alpine3.9

ARG PMD_VERSION=${PMD_VERSION:-6.40.0}

RUN mkdir -p /opt

RUN cd /opt \
      && apk add --no-cache --virtual .build-deps wget unzip \
      && wget -nc -O pmd.zip https://github.com/pmd/pmd/releases/download/pmd_releases/${PMD_VERSION}/pmd-bin-${PMD_VERSION}.zip \
      && unzip pmd.zip \
      && rm -f pmd.zip \
      && mv pmd-bin-${PMD_VERSION} pmd \
      && apk del .build-deps

RUN apk add --update --no-cache dumb-init

ENTRYPOINT [ "/usr/bin/dumb-init", "/usr/bin/java", "-classpath", "/opt/pmd/lib/*", "net.sourceforge.pmd.PMD" ]
CMD ""
