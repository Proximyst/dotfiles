copy-system:
    rm -rf ./usr/local/bin/
    cp -r /usr/local/bin/ ./usr/local/

    rm -rf ./etc/udev/rules.d/
    cp -r /etc/udev/rules.d/ ./etc/udev/

    cp /etc/systemd/system/grafana.slice ./etc/systemd/system/
    cp /usr/lib/systemd/user/{pipewire,niri}.service -t ./usr/lib/systemd/user/
    cp /usr/lib/systemd/system/clam* -t ./usr/lib/systemd/system/

    rm -rf ./etc/clamav
    cp -r /etc/clamav/ ./etc

    cp /etc/sddm.conf ./etc
