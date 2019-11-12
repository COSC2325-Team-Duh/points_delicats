import logging
from letters import letters

def sixToBraille(word):
    """
    Takes a word (6 characters max) and converts it to the output array
    for sendDisplay()

    :param word: 6 character string
    :return rowData: a multidimensional list of bytes
    """
    rowData = [[],[],[],[0,0,0,0,0,0,0,0],[0,0,0,0,0,0,0,0],[],[],[]] # indecies 3 and 4 are always empty, thus initialized to zeros
    charList= [] # holds the actual braille-ized characters


    if len(word) < 6: # This bit pads the word in case it's smaller than six characters
        while len(word) <6:
            word = word + ' '


    for x in range(6):
        charList.append( letters[word[x]] ) # charList now holds a binary list for each character


    for x in range(3): #write first three characters
        for y in range(3):
            for bit in charList[y][x]:
                rowData[x].append(bit)
            if y < 2:
                rowData[x].append(0) #line breaks between characters

    # middle blank lines already written #

    for x in range(3): #write last three characters
        for y in range(3):
            for bit in charList[y+3][x]:
                rowData[x+5].append(bit)
            if y < 2:
                rowData[x+5].append(0) #line breaks between characters

    return rowData

# END OF sixToBraille #


def sendDisplay(rows):
    """
    Sends the rows to the binary file to be displayed on the 8x8 matrix.

    :param rows: multimensional list of bytes
    :return none:
    """
