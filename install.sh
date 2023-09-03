#!/usr/bin/env bash

######################################################################
#                                                                    #
#                  caveman linux! | cozy computing!                  #
#                                                                    #
######################################################################
#                                                                    #
#    A simple and fast Linux distribution designed for beginners     #
#                      to computers and Linux.                       #
#                                                                    #
######################################################################
#                                                                    #
#        Made with <3 by Caveman Software, and the community!        #
#                         Check us out here:                         #
#                   https://github.com/cavemandevs                   #
#                                                                    #
#           and read the CREDITS file for the full credits           #
#                   (thanks to our contributors!)                    #
#                                                                    #
######################################################################
#                                                                    #
# This project is licensed under the GNU General Public License v2.0 #
#         Please read the LICENSE file to read the license.          #
#                                                                    #
######################################################################

# NOTES (moved here because of potential bug):
# we need to do a lot of testing for the script
# the solution to the networkmanager problem has been fixed
# the parallel downloads problem: 5 is enough

# TO BE ADDED:
# integrate rock to system
# make exclusive wallpapers
# [DONE] add colored text (if we have time)
# [DONE] change /etc/os-release information
# [DONE] add graphics driver support options
# [DONE] add ssd detection and add trim

# IDEAS:
# we'll install yay for now, and we'll add rok later

# v2 of the caveman installer

checkdeps () {
    installerdeps=$(pacman -Q | grep -o libnewt)
    if [ "$installerdeps" != "libnewt" ]
    then
	   echo -e "\e[1;31mFATAL: Missing Dependencies\e[0m"
	   echo
	   echo "The installer was not able to continue for the following reason:"
	   echo "package [libnewt] was not found"
	   echo
	   echo "This means that you have a corrupted ISO. Please redownload the ISO and try again."
	   echo
	   echo -e "If you have redownloaded this ISO and the error persists, please report it to the Caveman Linux Developers."
	   echo -e "visit github.com/cavemandevs/caveman-linux"
	   exit 1
    fi
}

welcome () {
  BACKTITLE="Caveman Linux Installer / Main Menu"

  whiptail --msgbox "Welcome to Caveman Linux!\n\nCaveman Linux is a Linux Distribution aimed for beginners. It's designed from the ground up to be easy and intuitive to use.\n\nThis installer may look daunting, but don't fret! You can use your arrow keys to select input fields and buttons, and press enter to continue. We're sure you'll get hang of it as you go on! :)\n\nWe hope you enjoy using Caveman Linux!" 20 60

  OPTION=$(whiptail --title "Caveman Linux Installer" --backtitle "$BACKTITLE" --menu "Please select an option.\n\nIf you would like to continue the installation, press the 'Begin Installation' button.\n\nIf you would like to enter a shell, you may select option 2. We would like to mention that shell access is recommended for Administrators only, and enter only if you know what you're doing!\n\nAnd finally, to power off the computer, you may select option 3." 20 90 4 \
  "1" "Begin Installation" \
  "2" "Enter Shell" \
  "3" "Shutdown Computer" 3>&1 1>&2 2>&3 \
  || echo "Cancelled")

  if [ "$OPTION" != "Cancelled" ]; then
      case $OPTION in
          1)
              echo "continuing"
              ;;
          2)
              echo "here be dragons!"
              echo
              echo "You've just entered the shell interface."
              echo "You may proceed to do a custom installation, or do other things here."
              echo "Please do be warned that doing custom installations, and deviating from the standard Caveman Linux Installer may result in instability, and is NOT supported by Caveman Developers."
              echo
              echo "If you've entered this menu by mistake, you may re-enter the installer by typing in 'cavemaninstaller', and pressing enter."
              ;;
          3)
              echo "simulated shutdown"
              exit 0
              ;;
         *)
             whiptail --msgbox "$BACKTITLE\n\nInvalid option" 10 40
             ;;
      esac
  else
       whiptail --msgbox "Cancelled\n\nYou have selected to exit the installer. You will be redirected to the shell, and you can re-enter by typing in 'cavemaninstaller', and pressing enter." 20 35
fi
}

confirm () {
  BACKTITLE="Caveman Linux Installer / Confirmation"
  confirmationcode=$(whiptail --backtitle "$BACKTITLE" --title "Final Confirmation" \ --inputbox "Please enter the phrase 'InstallCavemanLinux' to begin installation." 10 50 2>&1)
  if [ "$confirmationcode" != "InstallCavemanLinux" ]; then
    echo "continuing install"
  else
    echo "eeee"
  fi
}

# checkdeps
welcome
confirm
echo "complete!"
exit 0
