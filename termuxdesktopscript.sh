#!/usr/bin/env bash
# Desktop script for termux x11

read response
print_welcome_text() {

    echo 'Welcome to the termux desktop installation guide by @MajesticTwelve12!'

    echo 'Before we start the install process, we need some prequisities, using pkg, we are instaslling, x11-repo termux-x11-nightly tur-repo pluseaudio proot-distro wget git.'
}


install_termux_packages() {
    pkg update
    pkg install x11-repo
    pkg install termux-x11-nightly
    pkg install pulseaudio
    pkg install tur-repo proot-distro wget git

}

setup_proot_system() {
    echo 'Installing Debian with proot-distro...'
    proot-distro install debian

}

setup_proot_users() {

    echo 'Logging into debian as root inside the container.'
    proot-distro login debian
    # inside the proot-distro
    echo 'adding droidmasteras user, this will be key for installing the xfce4 desktop script.'
    adduser droidmaster
    echo 'Make a user password for droidmaster'
    passwd droidmaster
    ## add users to the sudoers file /etc/sudoers/

    ## nano /etc/sudoers
    ## droidmaster ALL=(ALL:ALL) ALL
    # check to see if sudo is working properly.
    sudo whoami
}
logging_in_as_xfce4_user() {

    proot-distro login debian --user droidmaster
}

xfce4_desktop_installation() {
    shellscript = 'startxfce4_debian.sh'
    sudo apt -y install xfce4
    wget https://raw.githubusercontent.com/LinuxDroidMaster/Termux-Desktops/main/scripts/proot_debian/startxfce4_debian.sh

    #Make the script executable
    echo 'Making $shellscript executable (chmod u+x $shellscript)'
    chmod u+x startxfce4_debian.sh

}

executing_proot_debian_script() {
if ["$response" = 'y']; then
    ./startxfce4_debian.sh
    else
    echo 'Thanks for running the script! quitting'

fi
}

Installation_Menu() {

    echo 'Choose what to do: '
    echo '1 - Install required packages for XFCE4'
    echo '2 - Install required packages for XFCE4 and proot Debian System'
    echo '3 - Logging into Debian Proot as root and setting up users, user is droidmaster'

}
msg() {
    tput setaf 2
    echo "[*] $1"
    tput sgr0
}


error_msg() {
    tput setaf 1
    echo "[!] $1"
    tput sgr0
}

main() {

    while true; do
        print_welcome_text
        Installation_Menu
        read -p 'Would you like to continue running this script?: ' choice
        case $choice in
        1)
        install_termux_packages
        msg 'Done!'
        ;;
        2)
        setup_proot_system
        msg 'Done!'
        ;;
        3)
        setup_proot_users
        msg 'Done!'
        ;;
        q)
        exit 0
        ;;
        *)
        error_msg 'Please use a valid input'
        ;;
        esac
    done
}

(return 2> /dev/null) || main
