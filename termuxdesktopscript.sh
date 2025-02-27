# Desktop script for termux x11

read response

echo "Before we start the install process, we need some prequisities, using pkg, we are instaslling, x11-repo termux-x11-nightly tur-repo pluseaudio proot-distro wget git."

echo "Do do you want to install these packages? (y/n)"

if ["$response" = 'y']; then

    pkg update
    pkg install x11-repo termux-x11-nightly tur-repo pluseaudio proot-distro wget git
else
    echo "Not installing packages, quitting..."
    return 1
if
quit

echo "Installing Debian with proot-distro..."
proot-distro install debian
echo "Logging into debian as root inside the container."

proot-distro login debian
# inside the proot-distro
echo "adding user droidmaster, this will be key for installing the xfce4 desktop script."
adduser droidmaster
echo "Make a user password for droidmaster"
passwd droidmaster
## add users to the sudoers file /etc/sudoers/

## nano /etc/sudoers
## droidmaster ALL=(ALL:ALL) ALL
# check to see if sudo is working properly.
sudo whoami
exit

# Installing the desktop
proot-distro login debian --user droidmaster
echo "Would you like to install xfce4 as your main desktop environment?"
echo "Do do you want to install these packages? (y/n)"
if ["$response" = 'y']; then

sudo apt -y install xfce4

wget https://raw.githubusercontent.com/LinuxDroidMaster/Termux-Desktops/main/scripts/proot_debian/startxfce4_debian.sh

#Make the script executable

chmod u+x startxfce4_debian.sh

else
    echo "Not installing XFCE4, quitting..."
    return 1
if


#Echo to the screen, it is done, enjoy and run the script.

echo="You are now done! You can run the script now for debian xfce4 edition! ./startxfce4_debian.sh! would you like to run it? (y/n)"


if ["$response" = 'y']; then
    ./startxfce4_debian.sh
    else
    echo "Thanks for running the script! quitting"
    return 1
fi
quit
return 0;
