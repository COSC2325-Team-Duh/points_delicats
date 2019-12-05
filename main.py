# set up logging library
import logging
import points as p
from time import sleep

TIME = 1000
logging.basicConfig(format='%(asctime)s .:%(levelname)s %(message)s', level=logging.DEBUG)


def setup():
    p.setup_pins()
    p.set_pin_mode(p.latch_pin, 1)
    p.set_pin_mode(p.clock_pin, 1)
    p.set_pin_mode(p.data_pin, 1)


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

        for i in range(TIME):
            p.sendDisplay(matrix)
            sleep(0.001)
        p.clearDisplay()

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
