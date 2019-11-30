def formatInput(inputString):
    """
    Takes a string input, removes all numbers and special characters and converts
    all letters to lower case.

    :param text: string of text
    :return text: string of text
    """
    newString = ""
    for index in inputString:
            if index == " ":
                newString += index
            elif index >= "a" and index <= "z":
                newString += index
            elif index >= "A" and index <= "Z":
                newString += index.lower()
            else:
                newString += '?'

    return newString
