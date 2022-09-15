#!/bin/bash

# Make sure the script is run as root.
if [ $(id -u) -ne 0 ]; then
    echo
    echo
    echo "Please run as root."
    exit 1
fi



# Download script.
cd /usr/local/bin
sudo mkdir maker_cm4
cd maker_cm4
curl -LO https://raw.githubusercontent.com/CytronTechnologies/MAKER-CM4_Script/main/power_button.py

# Add the command to run the script to rc.local if it's not there yet.
rc_file = "/etc/rc.local"
grep "maker_cm4" $rc_file >/dev/null
if [ $? -ne 0 ]; then
    # Insert into rc.local before final 'exit 0'
    sed -i "s/^exit 0/sudo python \/usr\/local\/bin\/maker_cm4\/power_button.py \&\nexit 0/g" $rc_file
fi



# Configure the config.txt file.
config_file = "/boot/config.txt"

# Disable USB OTG.
grep "#otg_mode=1" $config_file >/dev/null
if [ $? -ne 0 ]; then
    sed -i "s/^otg_mode=1/#otg_mode=1/g" $config_file
fi

# Enable USB host.
grep "dtoverlay=dwc2,dr_mode=host" $config_file >/dev/null
if [ $? -ne 0 ]; then
    echo "dtoverlay=dwc2,dr_mode=host" >> $config_file
fi

# Enable I2C for RTC.
grep "dtparam=i2c_vc=on" $config_file >/dev/null
if [ $? -ne 0 ]; then
    echo "dtparam=i2c_vc=on" >> $config_file
    echo "dtoverlay=i2c-rtc,pcf85063a,i2c_csi_dsi" >> $config_file
fi

# Remap audio.
grep "dtoverlay=audremap,pins_18_19" $config_file >/dev/null
if [ $? -ne 0 ]; then
    echo "dtoverlay=audremap,pins_18_19" >> $config_file
fi


echo
echo
echo "######################################"
echo "Cytron CM4 Maker Board Setup Completed"
echo "######################################"
echo
echo "Please reboot for the changes to take effect."
