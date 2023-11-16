import Color


class CssConfigDictionary:
    def __init__(self, filepath):
        self.file = filepath
        self.dictionary = dict()
        self.__init_dictionary__()

    def __init_dictionary__(self):
        with open(self.file) as css:
            lines = css.readlines()
        for line in lines:
            pair = line.split(' ')
            if pair[0] != '@define-color':
                continue
            self.dictionary[pair[1]] = Color.Color_str(pair[2][:-2])

    def __getitem__(self, item):
        return self.dictionary[item]
