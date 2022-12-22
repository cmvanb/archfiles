#-------------------------------------------------------------------------------
# Generate color gradient palette
#-------------------------------------------------------------------------------

# TODO: Extract to a module.
def float_range(minimum, maximum):
    # Return function handle of an argument type function for  ArgumentParser 
    # checking a float is in range: minimum <= arg <= maximum

    # Define the function with default arguments
    def float_range_checker(arg):
        # New Type function for argparse - a float within predefined range.
        try:
            f = float(arg)
        except ValueError:    
            raise argparse.ArgumentTypeError('Must be a floating point number.')
        if f < minimum or f > maximum:
            raise argparse.ArgumentTypeError(f'Must be in range ({str(minimum)} .. {str(maximum)}).')
        return f

    # Return function handle to checking function
    return float_range_checker

class Color():
    def __init__(self, r, g, b):
        self.r = int(r)
        self.b = int(b)
        self.g = int(g)

    def __str__(self):
        return f'{self.r}, {self.g}, {self.b}'

    def escape_bg(self):
        return f'\x1b[48:2:{self.r}:{self.g}:{self.b}m'

    def escape_reset(self):
        return '\x1b[0m'

    def terminal_output(self):
        return f'{self.escape_bg()}#{self.r:02x}{self.g:02x}{self.b:02x}{self.escape_reset()}'

    @staticmethod
    def parse(arg):
        return Color(int(arg[1:3], 16), int(arg[3:5], 16), int(arg[5:7], 16))

def validate_color(argumentName, argument):
    if not argument:
        raise ValueError(f'{argumentName} cannot be an empty string.')
    if len(argument) != 7 or argument[:1] != '#':
        raise ValueError(f'{argumentName} must be in the format #RRGGBB.')
    return True

def interp(start, end, percentage):
    return start + ((end - start) * percentage)

def main():
    import argparse
    import sys

    try:
        parser = argparse.ArgumentParser(description='Generate color gradient palette')
        parser.add_argument('--samples',  required=True,  type=int, choices=range(2, 21), help='Number of colors to samples along the gradient.')
        parser.add_argument('--start',    required=True,  help='The start of the gradient. Hexadecimal color in the format #RRGGBB.')
        parser.add_argument('--end',      required=True,  help='The end of the gradient. Hexadecimal color in the format #RRGGBB.')
        parser.add_argument('--middle',   required=False, help='The middle of the gradient, this is optional. Hexadecimal color in the format #RRGGBB.')
        parser.add_argument('--midpoint', required=False, type=float_range(0.0, 1.0), help='Decimal in the range 0.0 to 1.0 representing the position of the middle color.')

        args = parser.parse_args()

        validate_color('start', args.start)
        validate_color('end', args.end)
        if args.middle is not None:
            validate_color('middle', args.middle)

    except Exception as ex:
        print(f'Error: {ex}')
        sys.exit(1)

    # TODO: Implement midpoint.
    if args.middle is not None:
        paletteA = generate(args.samples // 2, Color.parse(args.start), Color.parse(args.middle))

        for i, color in enumerate(paletteA):
            print(f'{color.terminal_output()}')

        paletteB = generate(args.samples // 2, Color.parse(args.middle), Color.parse(args.end))

        for i, color in enumerate(paletteB):
            print(f'{color.terminal_output()}')
    else:
        palette = generate(args.samples, Color.parse(args.start), Color.parse(args.end))

        for i, color in enumerate(palette):
            print(f'{color.terminal_output()}')

def generate(samples, start, end):
    div = samples - 1
    return [Color(interp(start.r, end.r, (i / div)), interp(start.g, end.g, (i / div)), interp(start.b, end.b, (i / div))) for i in range(0, samples)]

if __name__ == '__main__':
    main()
