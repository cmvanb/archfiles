#-------------------------------------------------------------------------------
# Lookup
#-------------------------------------------------------------------------------

_named = {}

def named(name):
    return _named[name]

def hash(name):
    return '#{0}'.format(_named[name])

def zerox(name):
    return '0x{0}'.format(_named[name])

#-------------------------------------------------------------------------------
# Entry point
#-------------------------------------------------------------------------------

def main():
    import argparse
    import sys

    try:
        parser = argparse.ArgumentParser(description='Python parser for system color scheme. If no argument is passed, it will default to --list.')
        parser.add_argument('--list', action='store_true', default=True, help='List the parsed color variables.')

        args = parser.parse_args()

        if args.list:
            print_list()
            sys.exit(0)

    except Exception as ex:
        print('Error: {0}'.format(ex))
        sys.exit(1)

#-------------------------------------------------------------------------------
# Functions
#-------------------------------------------------------------------------------

def print_list():
    global _named

    parse_colors()

    # TODO: Use terminal escape codes to colorize output
    for k, v in _named.items():
        print('{} -> {}'.format(k, v))

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
                continue

            # Hash after assignment, char is ignored, but continue parsing value.
            # Hash before assignment, line is skipped.
            elif c == '#':
                if assignment_op == True:
                    continue
                else:
                    key = None
                    value = None
                    break

            # Quote, only allowed after assignment
            elif c == '\'':
                if assignment_op == True:
                    continue
                else:
                    raise Exception('Unable to continue parsing, expected character [{}] only after assignment.'.format(c))

            # Dollar, only allowed after assignment
            elif c == '$':
                if assignment_op == True:
                    lookup = True
                    continue
                else:
                    raise Exception('Unable to continue parsing, expected character [{}] only after assignment.'.format(c))

            # Alphanumeric or underscore, append to either key or value
            elif re.search('[0-9a-zA-Z_]', c) is not None:
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
                    continue

            # New line char, assign value
            elif c == '\n':
                if key != None and value != None:
                    if lookup == True:
                        _named[key] = _named[value]
                    else:
                        _named[key] = value
                break

            else:
                raise Exception('Unable to continue parsing, unexpected character [{}].'.format(c))

    f.close()

if __name__ == '__main__':
    main()
