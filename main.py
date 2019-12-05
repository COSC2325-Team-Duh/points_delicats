# set up logging library
import logging
logging.basicConfig(format='%(asctime)s .:%(levelname)s %(message)s', level=logging.DEBUG)

import points as p
from time import sleep

TIME = 200

def setup():
    p.setup_pins()
    
    p.set_pin_mode(p.latch_pin, 1)
    p.set_pin_mode(p.clock_pin, 1)
    p.set_pin_mode(p.data_pin, 1)

def sendDisplay(row):
    for i in range(8):
        GPIO.output(cPin, GPIO.LOW)
        GPIO.output(dPin, (0x01&(row>>i)==0x01) and GPIO.HIGH or GPIO.LOW)
        GPIO.output(cPin, GPIO.HIGH)

def main():
    logging.info("Enter a phrase! -1 will exit the program")
    phrase = input("Phrase: ")
    while phrase != "-1":
        phrase = p.formatInput(phrase)
        logging.debug("The phrase is: {}".format(phrase))
        parts = p.sixer(phrase)
        print(parts)
        for part in parts:
            matrix = p.sixToBraille(part)
            print(f"\n{part}")
            for row in matrix:
                print('\t', row)
            matrix.reverse()

            for i in range(TIME):
                p.sendDisplay(matrix)
                sleep(0.001)
            p.clearDisplay()
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
