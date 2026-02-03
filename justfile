copy-system:
    rm -rf ./etc/udev/rules.d/
    cp -r /etc/udev/rules.d/ ./etc/udev/
    cp /etc/pacman.conf ./etc/pacman.conf

    cp /usr/lib/systemd/user/{pipewire,niri}.service -t ./usr/lib/systemd/user/

    cp /etc/sddm.conf ./etc
