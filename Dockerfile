# 
FROM drzedx/baseimage-docker

# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]

# ...put your own build instructions here...
COPY service/ /etc/service/
COPY init/ /etc/my_init.d/

# Clean up APT when done.
RUN useradd -u 911 -U -s /bin/false abc && usermod -G users abc && mkdir -p /download /config && apt-get update && apt-get upgrade -qy -o Dpkg::Options::="--force-confold" && apt-get install -yq transmission-daemon && chmod -v +x /etc/service/*/run && chmod -v +x /etc/my_init.d/*.sh && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

VOLUME ["/config", "/download"]

EXPOSE 9091 51413
