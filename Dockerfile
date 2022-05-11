FROM linuxserver/deluge:latest

VOLUME /config
VOLUME /downloads

# Install openvpn and utilities
ARG DEBIAN_FRONTEND=noninteractive
RUN apk update \
#  && apk --no-cache  add bash curl iputils-ping jq openvpn \
  && apk --no-cache  add bash curl iputils jq openvpn \
#  && apk clean \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

COPY root/ /

ENV \
  PIA_SERVER=auto \
  MAX_LATENCY=0.05 \
  PIA_USER= \
  PIA_PASS= \
  PIA_MODE=openvpn_udp_standard

HEALTHCHECK --interval=30s --timeout=10s --start-period=5s --retries=3 \
  CMD curl -L -f https://api.ipify.org || exit 1

# Expose port and run
EXPOSE 8112 58846 58946 58946/udp
