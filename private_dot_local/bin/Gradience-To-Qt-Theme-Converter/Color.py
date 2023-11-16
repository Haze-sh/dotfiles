class Color:
    def __init__(self, r, g, b):
        self.red = r
        self.green = g
        self.blue = b

    def get_hex_view(self):
        hex = ''
        hex += self.__convert_to_hex_duet(self.red)
        hex += self.__convert_to_hex_duet(self.green)
        hex += self.__convert_to_hex_duet(self.blue)
        hex = '#' + hex
        return hex

    def __convert_to_hex_duet(self, int):
        duet = (hex(int).split('x')[1])
        if len(duet) < 2:
            duet = '0' + duet
        return duet

    def get_rgb_view(self):
        return f'{self.red},{self.green},{self.blue}'

    def increase(self, int):
        return Color(self.red + int, self.green + int, self.blue + int)


def Color_str(string_color):
    if string_color[0] == '#':
        return parse_hex(string_color)
    elif string_color[3] == 'a':
        return parse_rgba(string_color)
    elif string_color[:3] == 'rgb':
        return parse_rgb(string_color)


def parse_rgb(rgb):
    rgb = rgb[4:-1]
    rgb = rgb.split(',')
    return Color(int(rgb[0]), int(rgb[1]), int(rgb[2]))


def parse_hex(hex):
    red = hex[1:3]
    green = hex[3:5]
    blue = hex[5:7]
    return Color(int(red, 16), int(green, 16), int(blue, 16))


def parse_rgba(rgba):
    rgba = rgba[5:-1]
    rgba = rgba.split(',')
    if len(rgba) < 3:
        return Color(0, 0, 0)
    return Color(int(rgba[0]), int(rgba[1]), int(rgba[2]))
