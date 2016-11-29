[![](https://images.microbadger.com/badges/image/kevineye/daapd.svg)](https://microbadger.com/images/kevineye/daapd "Get your own image badge on microbadger.com")

[forked-daapd](https://ejurgensen.github.io/forked-daapd/) is a DAAP (iTunes), MPD (Music Player Daemon) and RSP (Roku) media server with support for AirPlay devices/speakers, Apple Remote (and compatibles), MPD clients, Chromecast, network streaming, internet radio, Spotify and LastFM.

Play iTunes, Spotify, and local music to multiple AirPlay, Chromecast, pulseaudio, and local speakers controlled by the Apple Remote app or MPD clients.

## Build

```
docker build -t kevineye/daapd .
```

The built image is huge (600+ MB including the base buildpack-deps image). There is room for a lot of optimization, however libspotify is (probably) not compatible with glibc-less alpine linux.


## Run

```
docker run -d \
    --name daapd \
    --net host \
    -v /path/to/daapd/config:/config
    -v /pat/to/your/music:/music
    -v /etc/localtime:/etc/localtime:ro
    kevineye/daapd
```

A default config file will be written to the config volume which can be edited.

See [forked-daapd documentation](https://ejurgensen.github.io/forked-daapd/) for info on connecting to Spotify, Apple Remote pairing, etc.
