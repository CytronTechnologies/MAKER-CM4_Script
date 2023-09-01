# Setting Up CM4 Maker Board #
We recommend to setup the CM4 Maker Board with:
1. Running the setup script from the Raspberry Pi OS terminal.
2. Modify the configuration of CM4 bootloater.

## CM4 Maker Board Setup Script ##
This script is only for Raspberry Pi OS. Make sure the Pi has internet connection and run this command from the terminal.
```
curl -L tinyurl.com/setup-maker-cm4 | sudo bash
```

**What it does?**
- Added the following settings in /boot/config.txt
  - Disable USB OTG and enable the USB Host.
  - Enable I2C and RTC.
  - Enable shutdown on GPIO4 falling edge. This will shutdown the Pi safely when the power-buttons are pressed.

## Modify the Configuration of CM4 Bootloader ##
Pre-configured bootloader images are available in the `bootloader_config` folder. It can be flashed directly to the CM4.<br>
You need to flash this to CM4 in order for the power button on CM4 Maker Board to work correctly.<br>
Without this, the power button is unable to wake up the CM4 after shutdown.

### Flashing CM4 Bootloader from Windows ###
1. Download and install the [rpiboot tool](https://github.com/raspberrypi/usbboot/raw/master/win32/rpiboot_setup.exe).
2. Download and extract one of the bootloader config file. Usually the latest version is preffered. You should get a `recovery` folder.
3. On the CM4 Maker Board, slide the Run/Boot switch to **BOOT**, then connect the USB-C port to the PC.
4. Open the command prompt (Press the Windows key and type "cmd") and go to the `recovery` folder you just extracted.
5. Run this command to start flashing the bootloader to the EEPROM of CM4. <br>
```
"C:\Program Files (x86)\Raspberry Pi\rpiboot.exe" -d ./
```
6. The bootloader is flashed successfully if you see the following message. The ACT LED should be blinking continuously too.
```
RPIBOOT: build-date Jul 18 2022 version 20220718~085937 5a25e04b
Loading: recovery/bootcode4.bin
Waiting for BCM2835/6/7/2711...
Loading: recovery/bootcode4.bin
Sending bootcode.bin
Successful read 4 bytes
Waiting for BCM2835/6/7/2711...
Loading: recovery/bootcode4.bin
Second stage boot server
Loading: recovery/config.txt
File read: config.txt
Loading: recovery/pieeprom.bin
Loading: recovery/pieeprom.bin
Loading: recovery/pieeprom.sig
File read: pieeprom.sig
Loading: recovery/pieeprom.bin
File read: pieeprom.bin
Second stage boot server done
```
7. Set the Run/Boot switch to **RUN** and power cycle the board. The CM4 will be running with new bootloader settings.
