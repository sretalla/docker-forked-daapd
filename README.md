I am using this docker container on my Hass.io homeassistant install to allow me to use google tts on my home pod. I'm using it in conjunction with this project as a custom component to present the forked-daapd instance as a media player in homeassistant:
https://github.com/johnpdowling/custom_components/tree/master/forked-daapd


[![](https://images.microbadger.com/badges/image/kevineye/daapd.svg)](https://microbadger.com/images/kevineye/daapd "Get your own image badge on microbadger.com")

[forked-daapd](https://ejurgensen.github.io/forked-daapd/) is a DAAP (iTunes), MPD (Music Player Daemon) and RSP (Roku) media server with support for AirPlay devices/speakers, Apple Remote (and compatibles), MPD clients, Chromecast, network streaming, internet radio and LastFM.

Play iTunes, and local music to multiple AirPlay, Chromecast, and local speakers controlled by the Apple Remote app or MPD clients.

## Examples

    docker run -d \
        --name daapd \
        --net host \
        -v /path/to/daapd/config:/config
        -v /path/to/your/music:/music
        -v /etc/localtime:/etc/localtime:ro
        sretalla/docker-forked-daapd

A default config file will be written to the config volume which can be edited.

This container (if used as recommended with host networking) will publish port 3689 to the host for the web UI.

See [forked-daapd documentation](https://ejurgensen.github.io/forked-daapd/) for info on Apple Remote pairing, etc.
