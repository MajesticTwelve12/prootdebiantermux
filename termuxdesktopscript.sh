#!/usr/bin/env bash
# Desktop script for termux x11

read response
print_welcome_text() {

    echo 'Welcome to the termux desktop installation guide by @MajesticTwelve12!'
    echo 'Please read the script before continuing with the installation guide.'
}
# Update packages on Termux and installing packages for the desktop environment
install_termux_packages() {
    pkg update -y
    pkg install -y x11-repo
    pkg install -y termux-x11-nightly
    pkg install -y pulseaudio
    pkg install -y tur-repo proot-distro wget git coreutils man

}
# Installing Proot-Distro
setup_proot_system() {
    echo 'Installing Debian with proot-distro...'
    proot-distro install debian
}

# make a link to where user can install the Termux X11 APK on github, but I should put it in the read me instead
Termux_X11_APK() {
    echo 'To Install the Termux X11 APK file, you need to go to the github nightly page and install the right package for your device'
    echo 'https://github.com/termux/termux-x11/releases'
}
# The installation menu.
Installation_Menu() {

    echo 'Choose what to do: '
    echo '1 - Install core packages required for setup. (Read the script before installing or edit for changes)'
    echo '2 - Install Debian Proot.'
    echo '3 - Termux-X11 Application infomation.'
    echo 'q - To quit the installation guide.'
}
# Warning codes
msg() {
    tput setaf 2
    echo "[*] $1"
    tput sgr0
}

# Warning codes
error_msg() {
    tput setaf 1
    echo "[!] $1"
    tput sgr0
}
# The main function of a program.
main() {

    while true; do
        print_welcome_text
        Installation_Menu
        read -p 'Welcome to the install script, please follow the instructions in order.' choice
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
            Termux_X11_APK
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
