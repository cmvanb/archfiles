#-------------------------------------------------------------------------------
# Lookup
#-------------------------------------------------------------------------------

_named = {}

def named(name):
    return _named[name]

#-------------------------------------------------------------------------------
# Entry point
#-------------------------------------------------------------------------------

def main():
    global _named

    parse_colors()

    print('--- Named System Colors ---')

    # TODO: Use terminal escape codes to colorize output
    for k, v in _named.items():
        print('{} = {}'.format(k, v))

#-------------------------------------------------------------------------------
# Parser
#-------------------------------------------------------------------------------

def parse_colors():
    global _named

    import re
    import os

    colorsFile = os.path.expanduser('~/.config/colors/colors')

    f = open(colorsFile, 'r')

    lines = f.readlines()

    for j, l in enumerate(lines):
        key = None
        value = None
        assignment_op = False
        lookup = False
        for i, c in enumerate(l):
            # Space, keep reading
            if c == ' ':
                print('space')
                continue
            # Hash before assignment, line is now a comment, skip
            elif c == '#' and assignment_op == False:
                key = None
                value = None
                break
            # Quote, only allowed after assignment
            elif c == '\'':
                if assignment_op == False:
                    key = None
                    value = None
                    break
                else:
                    continue
            # Dollar, only allowed after assignment
            elif c == '$':
                if assignment_op == False:
                    key = None
                    value = None
                    break
                else:
                    lookup = True
                    continue
            # Alphanumeric or underscore, append to either key or value
            elif re.search('[0-9a-zA-Z_#]', c) is not None:
                if assignment_op == False:
                    if key == None:
                        key = ''
                    key = key + c
                else:
                    if value == None:
                        value = ''
                    value = value + c
            # Assignment operator reached, keep reading for value
            elif c == '=':
                if assignment_op == False:
                    assignment_op = True
            # New line char, assign value
            elif c == '\n':
                if key != None and value != None:
                    if lookup == True:
                        _named[key] = _named[value]
                    else:
                        _named[key] = value
                break
            else:
                raise Exception('Invalid character in config file: [{}]'.format(c))

    f.close()

if __name__ == '__main__':
    main()
