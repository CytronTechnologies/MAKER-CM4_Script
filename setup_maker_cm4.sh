#!/bin/bash

# Make sure the script is run as root.
if [ $(id -u) -ne 0 ]; then
    echo "Please run as root."
    exit 1
fi

echo "Installing power button script..."

# Download script.
cd /usr/local/bin
sudo mkdir maker_cm4
cd maker_cm4
curl -LO https://raw.githubusercontent.com/CytronTechnologies/MAKER-CM4_Script/main/power_button.py

# Add the command to run the script to rc.local if it's not there yet.
grep maker_cm4 /etc/rc.local >/dev/null
if [ $? -ne 0 ]; then
    # Insert gpio-halt into rc.local before final 'exit 0'
    sed -i "s/^exit 0/sudo python \/usr\/local\/bin\/maker_cm4\/power_button.py \& \nexit 0/g" /etc/rc.local
fi

echo
echo "######################################"
echo "Cytron CM4 Maker Board Setup Completed"
echo "######################################"
echo
echo "Please reboot for the changes to take effect."
