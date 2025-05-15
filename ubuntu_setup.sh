#!\bin\bash

package_updates () {
    if [! test -d "/etc/initial-package-updates-done"]
    $domain_packages=(realmd sssd sssd-tools libnss-sss libpam-sss adcli samba-common-bin oddjob)
    sudo apt update
    sudo apt upgrade
    sudo apt install "${domain_packages[@]}"
    oddjob-mkhomedir packagekit
    sudo touch /etc/initial-package-updates-done
    # TODO: Add self to startup scripts folder
    sudo shutdown -r now
}


# Disables the new user welcome screen
disable_welcome () {
    if [test -d "/etc/skel/.config"]
    then
        sudo touch /etc/skel/.config/gnome-initial-setup-done
        echo "Removed GNOME welcome screen."
    elif [! test -d "/etc/skel/.config"]
    then
        sudo mkdir /etc/skel/.config
        sudo touch /etc/skel/.config/gnome-initial-setup-done
        echo "Removed GNOME welcome screen."
    fi
}


package_updates
disable_welcome