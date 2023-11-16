import os.path


class ConfigFile:
    def __init__(self):
        self.filepath = os.path.expanduser('~') + '/.config/gradienceToQtConverter'
        self.__check_file__()

    def __check_file__(self):
        if os.path.exists(self.filepath):
            return
        with open('ConfigExample') as example:
            with open(self.filepath, 'w') as file:
                file.writelines(example.readlines())

    def __getitem__(self, item):
        with open(self.filepath) as config:
            lines = config.readlines()
            for i in lines:
                pair = i.split()
                if pair[0] != '@define_key':
                    continue
                if pair[1] == item:
                    return pair[2]
            raise

    def __setitem__(self, key, value):
        with open(self.filepath) as config:
            lines = config.readlines()
        placed = False
        for i in range(len(lines)):
            pair = lines[i].split()
            if pair[0] != '@define_key':
                continue
            if pair[1] == key:
                lines[i] = lines[i].replace(pair[2], value)
                placed = True
                break
        if not placed:
            lines.append(f'@define_key {key} {value}')
        try:
            os.remove(self.filepath)
        except:
            pass
        with open(self.filepath, 'w') as conf:
            conf.writelines(lines)


