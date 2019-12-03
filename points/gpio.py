import wiringpi as wp
from time import sleep

wp.wiringPiSetup()
PIN = 22
wp.pinMode(PIN, 1)
HIGH = 1
LOW = 0
while True:
    wp.digitalWrite(PIN, HIGH)
    sleep(5)
    wp.digitalWrite(PIN, LOW)
    sleep(2)

