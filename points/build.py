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

    :return bool: Return True if built,
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
    """
    Cleans up binaries and objects inside of the library.
    This is mostly used for quick development of the asm
    file, as well as the C++ file that will be used to
    generate the display. Should not be used in the final
    code.

    :params none:
    :return bool: True if successful
    """
    if checkAssembly(BINARY):
        logging.debug("Cleaning up the binaries and objects")
        os.popen("make clean").read()
        cleanUp()
    else:
        logging.debug("No Binary found. nothing to do")
    return True
