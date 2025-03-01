#!/usr/bin/env bash
# Desktop script for termux x11

read response
print_welcome_text() {
    echo 'Welcome to the second part of the Termux desktop installation guide by @MajesticTwelve12!'
}

# Make a script that checks if the user is in the proot system
setup_proot_users() {

    echo 'adding droidmasteras user, this will be key for installing the xfce4 desktop script.'
    adduser droidmaster
    echo 'Make a user password for droidmaster'
    passwd droidmaster
    ## add users to the sudoers file /etc/sudoers/
    ## Write to the line where the line root or sudoers is in the placement of the sudoers file. so that it is clean for users who wish to view the file at a later date
    ## nano /etc/sudoers
    ## droidmaster ALL=(ALL:ALL) ALL
    # check to see if sudo is working properly.
    sudo whoami
}
xfce4_desktop_installation() {
    shellscript = 'startxfce4_debian.sh'
    sudo apt -y install xfce4
    wget https://raw.githubusercontent.com/LinuxDroidMaster/Termux-Desktops/main/scripts/proot_debian/startxfce4_debian.sh

}
xfce4_desktop_goodies() {
    sudo apt install -y xfce4-whiskermenu-plugin
    sudo apt install -y mugshot
    sudo apt install -y conky-all
}
xfce4-desktop-themes() {
    sudo apt install -y papirus-icon-theme moka-icon-theme
    sudo apt install -y numix-gtk-theme greybird-gtk-theme
}
desktop_developer_applications() {
   # For users who want to install development tools like GCC, Clang or Rust 

}
xfce4_script_user_executable() {

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
    # Fix for the second part of the script when user is in the proot system
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
