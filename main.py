# set up logging library
import logging
logging.basicConfig(format='%(asctime)s .:%(levelname)s %(message)s', level=logging.DEBUG)
import RPi.GPIO as GPIO

import points as p
from time import sleep
latch_pin = 27

dPin = 11
lPin = 13
cPin = 15

def setup():
    p.set_pin_mode(latch_pin, 1)
    p.set_pin_mode(p.clock_pin, 1)
    p.set_pin_mode(p.data_pin, 1)

    GPIO.setmode(GPIO.BOARD)    # Number GPIOs by its physical location
def sendDisplay(row):
    for i in range(8):
        GPIO.output(cPin, GPIO.LOW)
        GPIO.output(dPin, (0x01&(row>>i)==0x01) and GPIO.HIGH or GPIO.LOW)
        GPIO.output(cPin, GPIO.HIGH)

def main():
    logging.info("Enter a phrase! -1 will exit the program")
    phrase = input("Phrase: ")
    while phrase != "-1":
        phrase = p.formatInput(phrase[0:6])
        logging.debug("The phrase is: {}".format(phrase))
        matrix = p.sixToBraille(phrase)
        for row in matrix:
            print('\t', row)
        matrix.reverse()
        for i in range(500):
            column = 0x80
            for j in range(8):
                row = matrix[j]
                brow = 0b0
                for bit in row:
                    brow = brow << 1
                    brow = brow | int(bit)

                p.pin_write(latch_pin, 0)
                p.sendDisplay(brow)
                p.sendDisplay(~column)
                p.pin_write(latch_pin, 1)
                column>>=1
                sleep(0.001)


#        row = ''
#        for item in matrix[j]:
#            row = row + str(item)
#        bin_row = 0b0
#        for bit in row:
#            bin_row = bin_row << 1
#            bin_row = bin_row | int(bit)

#        for i in range(500):
#            column = 0x80
#            for j in range(8):
#               #.output(lPin, GPIO.LOW)
#               p.pin_write(latch_pin, 0)
#               p.sendDisplay(bin_row)
#               p.sendDisplay(~column)
#               p.pin_write(latch_pin, 1)
#               sleep(0.001)
#               column>>=1
        phrase = input("Phrase: ")
    logging.info("Goodbye!")
    return 0

if __name__ == "__main__":
    try:
        setup()
        main()
    except KeyboardInterrupt:
        logging.info("Goodbye!")
else:
    pass
