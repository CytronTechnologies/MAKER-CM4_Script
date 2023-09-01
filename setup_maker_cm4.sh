#!/bin/bash

# Make sure the script is run as root.
if [ $(id -u) -ne 0 ]; then
    echo
    echo
    echo "Please run as root."
    exit 1
fi


# Configure the config.txt file.
config_file="/boot/config.txt"

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

# Enable shutdown on GPIO4 falling edge
grep "dtoverlay=gpio-shutdown,gpio_pin=4" $config_file >/dev/null
if [ $? -ne 0 ]; then
    echo "dtoverlay=gpio-shutdown,gpio_pin=4" >> $config_file
fi


echo
echo
echo "######################################"
echo "Cytron CM4 Maker Board Setup Completed"
echo "######################################"
echo
echo "Please reboot for the changes to take effect."
