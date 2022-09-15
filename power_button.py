import os
import RPi.GPIO as GPIO

# Initialize pin.
POWER_BUTTON = 4

GPIO.setmode(GPIO.BCM)
GPIO.setwarnings(False)
GPIO.setup(POWER_BUTTON, GPIO.IN, pull_up_down=GPIO.PUD_UP)

# Wait for button press and shutdown the CM4 safely.
while True:
    GPIO.wait_for_edge(POWER_BUTTON, GPIO.FALLING)
    os.system("sudo shutdown -h now")
