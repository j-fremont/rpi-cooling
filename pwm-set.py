
import RPi.GPIO as GPIO
import time
import sys

freq=int(sys.argv[1]);
dc=int(sys.argv[2]);

#GPIO.setmode(GPIO.BOARD)
GPIO.setmode(GPIO.BCM);
GPIO.setup(21, GPIO.OUT);

led = GPIO.PWM(21, freq);
led.start(0);
led.ChangeDutyCycle(dc);

while(1):
	time.sleep(10);
