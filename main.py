import logging
import points as p
from points import NoBinaryException

# set up logging library
logging.basicConfig(format='%(asctime)s .:%(levelname)s %(message)s', level=logging.DEBUG)

def setup():
    if p.buildAssembly() == False:
        raise

def main():
    pass

if __name__ == "__main__":
    try:
        setup()
    except NoBinaryException as e:
        logging.critical("ERROR: {}".format(e))

    main()
else:
    pass
