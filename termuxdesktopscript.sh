#!/usr/bin/env bash
# Desktop script for termux x11

read response
print_welcome_text() {

    echo 'Welcome to the termux desktop installation guide by @MajesticTwelve12!'

    echo 'Before we start the install process, we need some prequisities, using pkg, we are instaslling, x11-repo termux-x11-nightly tur-repo pluseaudio proot-distro wget git.'
}


install_termux_packages() {
    pkg update -y
    pkg install -y x11-repo
    pkg install -y termux-x11-nightly
    pkg install -y pulseaudio
    pkg install -y tur-repo proot-distro wget git coreutils

}

setup_proot_system() {
    echo 'Installing Debian with proot-distro...'
    proot-distro install debian

}

# make a link to where user can install the Termux X11 APK on github, but I should put it in the read me instead

Installation_Menu() {

    echo 'Choose what to do: '
    echo '1 - Install required for xfce4'
    echo '2 - Install required packages proot debian system'

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
