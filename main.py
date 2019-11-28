import logging
import points as p
from points import NoBinaryException
from time import sleep

# set up logging library
logging.basicConfig(format='%(asctime)s .:%(levelname)s %(message)s', level=logging.DEBUG)

def setup():
    if p.buildAssembly() == False:
        raise

def main():
    phrase = input("Phrase: ")
    logging.info("Enter a phrase! -1 will exit the program")
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
        setup()
    except NoBinaryException as e:
        logging.critical("ERROR: {}".format(e))

    main()
else:
    pass
