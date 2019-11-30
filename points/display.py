import logging
from .letters import letters

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

def sixer(phrase):
    """
    Takes the phrase and chops it into a list of 6 character strings
    to be used by sixToBraille()

    :param phrase: arbitrarily long string
    :return list: list of 6 character strings
    """
    output = [] # Output list of strings
    
    parts = len(phrase)/6 # Number of parts in the output list. Used for loops
    if (parts % 6  != 0 ): # If the number of characters in phrase doesn't divide by 6, add an extra index for those bits on the end
        parts = int(parts) + 1   

    for space in range(len(phrase)%6): #Adds spaces to the phrase to fill empty cells
        phrase = phrase + ' '

    for index in range(parts): # Carves up the original string, adds each item to the output list
        toAdd = phrase[(6*index):((6*index)+6)]
        if (toAdd): # This if statement solves a bug where an empty string is tagged onto the end if the output list if the phrase is exactly divisible by 6
            output.append(toAdd)

    return output
    pass

# END OF sixer #

def sendDisplay(rows):
    """
    Sends the rows to the binary file to be displayed on the 8x8 matrix.

    :param rows: multimensional list of bytes
    :return none:
    """
