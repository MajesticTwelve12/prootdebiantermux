#!/usr/bin/env bash
# Desktop script for termux x11

read response
print_welcome_text() {
    echo 'Welcome to the second part of the Termux desktop installation guide by @MajesticTwelve12!'
}
# Need to install sudo so this script will continue to run.
debian_system_requirements() {
    echo 'Installing the reletive packages so that the script can run properly.'
    apt update -y && apt upgrade -y
    apt install sudo man vim git wget curl gcc

}

# Make a script that checks if the user is in the proot system
# Edit this script so the user can change their username on the system for example MajesticTwelve.
setup_proot_users() {

    echo 'adding droidmasteras user, this will be key for installing the xfce4 desktop script.'
    adduser droidmaster
    echo 'Make a user password for droidmaster'
    # Add users to the sudoers file /etc/sudoers/
    # Using sed this will work out just fine.
    echo 'adding user to sudoers file'
    sed -i '48i droidmaster ALL=ALL(ALL:ALL) ALL' /etc/sudoers
    # check to see if sudo is working properly.
    sudo whoami
}
#Installing the desktop script from LinuxDroidMaster
xfce4_desktop_installation() {
    shellscript = 'startxfce4_debian.sh'
    sudo apt -y install xfce4
    wget https://raw.githubusercontent.com/LinuxDroidMaster/Termux-Desktops/main/scripts/proot_debian/startxfce4_debian.sh
    #Make the script executable
    echo 'Making $shellscript executable (chmod u+x $shellscript)'
    chmod u+x startxfce4_debian.sh
}
# Extra quality of life improvements for the XFCE4 Desktop.
xfce4_desktop_goodies() {
    sudo apt install -y xfce4-whiskermenu-plugin
    sudo apt install -y mugshot
    sudo apt install -y conky-all

}
# Extra desktop themes for the people who wish to install them
xfce4_desktop_themes() {
    sudo apt install -y papirus-icon-theme moka-icon-theme
    sudo apt install -y numix-gtk-theme greybird-gtk-theme
}
desktop_developer_tools() {
   # For users who want to install development tools like GCC, Clang or Rust 
    apt -y install gcc make gcc-c++ rustc 
}
flatpak_installation() {
    sudo apt -y install flatpak
    flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
}
Installation_Menu() {
    # Fix for the second part of the script when user is in the proot system
    echo 'Choose what to do: '
    echo '1 - Install required packages for XFCE4'
    echo '2 - Install required packages for XFCE4 and proot Debian System'
    echo '3 - Logging into Debian Proot as root and setting up users, user is droidmaster'
    echo '4 - Download DroidMasters script to run XFCE4 and making script executable.'
    echo '5 - Install Developer Tools'
    echo '6 - Install XFCE4 Whiskermenu, mugshot and conky-all'
    echo '7 - Install extra desktop themes like papirus moka icon theme, and Numix, Greybird-gtk themes'
    echo '8 - Install Flatpak and Flathub repository'
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
            debian_system_requirements
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

        4)
            xfce4_desktop_installation
            msg 'Done!'
            ;;

        5)
            desktop_developer_tools
            msg 'Done!'
            ;;

        6)
            xfce4_desktop_goodies
            msg 'Done!'
            ;;

        7)
            xfce4_desktop_themes
            msg 'Done!'
            ;;

        8)
            flatpak_installation
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
