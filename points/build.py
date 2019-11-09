import os
import logging

BINARY = "points.bin"
PATH = os.popen('pwd').read().strip()
LIB = '/points/'

ABSPATH = PATH + LIB

class NoBinaryException(Exception):
    pass

def buildAssembly():
    """
    This function will run a make command and verify that a binary file
    was created as a result of the make command.

    :return bool: Return True if built, False if failure
    """
    os.chdir(ABSPATH)
    if checkAssembly(BINARY):
        logging.debug("Binary exists, buildAssembly() has nothing to do...")
        return True
    else:
        logging.debug("Binary does not exist, building...")
        make = os.popen("make").read()
        print(make)
        if checkAssembly(BINARY):
            logging.debug("Binary Built")
            return True
        else:
            raise NoBinaryException("Make routine failed")


def checkAssembly(file):
    """
    This function checks to see if the supplied file exists or not.

    :param file: filename of the binary
    :return bool: returns True if binary exists, False if doesn't
    """
    logging.debug("Checking if binary exists")
    return os.path.exists(file)

if __name__ == "__main__":
    buildAssembly()
else:
    pass

def cleanUp():
    logging.debug("Cleaning up the binaries and objects")
    if checkAssembly(BINARY):
        os.popen("make clean").read()
    else:
        logging.debug("No Binary found. nothing to do")
