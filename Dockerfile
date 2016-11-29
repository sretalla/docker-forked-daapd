FROM buildpack-deps:xenial
MAINTAINER Kevin Eye <kevineye@gmail.com>

RUN apt-get update \
 && apt-get install -qy build-essential git autotools-dev autoconf libtool gettext gawk gperf \
                        antlr3 libantlr3c-dev libconfuse-dev libunistring-dev libsqlite3-dev \
                        libavcodec-dev libavformat-dev libavfilter-dev libswscale-dev libavutil-dev \
                        libasound2-dev libmxml-dev libgcrypt11-dev libavahi-client-dev zlib1g-dev \
                        libevent-dev libjson-c-dev libgnutls-dev libprotobuf-c-dev \
                        libcurl4-openssl-dev libplist-dev libpulse-dev avahi-daemon

RUN mkdir -p /tmp/spotify \
 && curl -o /tmp/spotify_tar.gz -L https://developer.spotify.com/download/libspotify/libspotify-12.1.51-Linux-x86_64-release.tar.gz \
 && tar xvf /tmp/spotify_tar.gz -C /tmp/spotify --strip-components=1 \
 && cd /tmp/spotify \
 && make install prefix=/usr
 
RUN git clone https://github.com/ejurgensen/forked-daapd.git /tmp/forked-daapd \
 && cd /tmp/forked-daapd \
 && autoreconf -i

RUN cd /tmp/forked-daapd \
 && ./configure \
      --enable-itunes \
      --enable-mpd \
      --enable-lastfm \
      --enable-spotify \
      --enable-chromecast \
      --with-pulseaudio \
      --prefix=/app \
      --sysconfdir=/etc \
      --localstatedir=/var \
 && make \
 && make install

RUN cp /etc/forked-daapd.conf /etc/forked-daapd.conf.orig \
 && sed -i -e 's/\(uid.*=\).*//g' /etc/forked-daapd.conf \
 && sed -i s#"ipv6 = yes"#"ipv6 = no"#g /etc/forked-daapd.conf \
 && sed -i s#/srv/music#/music#g /etc/forked-daapd.conf \
 && sed -i s#/var/cache/forked-daapd/songs3.db#/config/db/songs3.db#g /etc/forked-daapd.conf \
 && sed -i s#/var/cache/forked-daapd/cache.db#/config/db/cache.db#g /etc/forked-daapd.conf \
 && sed -i s#/var/log/forked-daapd.log#/dev/stdout#g /etc/forked-daapd.conf \
 && sed -i "/db_path\ =/ s/# *//" /etc/forked-daapd.conf \
 && sed -i "/cache_path\ =/ s/# *//" /etc/forked-daapd.conf \
 && mv /etc/forked-daapd.conf /etc/forked-daapd.conf.default

ADD daapd.sh /daapd

VOLUME /config /music

CMD /daapd