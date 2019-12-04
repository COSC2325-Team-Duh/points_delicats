# set up logging library
import logging
logging.basicConfig(format='%(asctime)s .:%(levelname)s %(message)s', level=logging.DEBUG)

import points as p
from points import NoBinaryException
from time import sleep

def main():
    logging.info("Enter a phrase! -1 will exit the program")
    phrase = input("Phrase: ")
    while phrase != "-1":
        phrase = p.formatInput(phrase[0:6])
        logging.debug("The phrase is: {}".format(phrase))
        matrix = p.sixToBraille(phrase)
        for row in matrix:
            print('\t', row)
        phrase = input("Phrase: ")
    logging.info("Goodbye!")
    return 0

if __name__ == "__main__":
    try:
        main()
    except KeyboardInterrupt:
        logging.info("Goodbye!")
else:
    pass
