FROM openjdk:8-alpine

ENV PMD_VERSION 6.14.0

RUN apk add --update --no-cache wget unzip
RUN mkdir -p /opt

RUN cd /opt \
      && wget -nc -O pmd.zip https://github.com/pmd/pmd/releases/download/pmd_releases/${PMD_VERSION}/pmd-bin-${PMD_VERSION}.zip \
      && unzip pmd.zip \
      && rm -f pmd.zip \
      && mv pmd-bin-${PMD_VERSION} pmd

COPY pmd /usr/bin/pmd
COPY cpd /usr/bin/cpd
RUN chmod +x /usr/bin/pmd /usr/bin/cpd

RUN mkdir /src
VOLUME /src
WORKDIR /src

CMD ["pmd"]

