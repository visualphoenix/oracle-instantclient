FROM ruby:2.2.2-slim

RUN FPM_VERSION=1.4.0 \
 && buildDeps=' \
		gcc \
	' \
 && apt-get update -yy \
 && apt-get upgrade -yy \
 && apt-get install -yy --no-install-recommends $buildDeps \
 && apt-get install -yy --no-install-recommends patchelf unzip cpio rpm2cpio make binutils libaio1 \
 && gem install --bindir /usr/bin -v ${FPM_VERSION} --no-rdoc --no-ri fpm \
 && apt-get purge -y --auto-remove $buildDeps \
 && apt-get clean -yy \
 && apt-get autoclean -yy \
 && apt-get autoremove -yy \
 && rm -rf /var/cache/debconf/*-old \
 && rm -rf /var/lib/apt/lists/* \

RUN mkdir /app
WORKDIR /app
