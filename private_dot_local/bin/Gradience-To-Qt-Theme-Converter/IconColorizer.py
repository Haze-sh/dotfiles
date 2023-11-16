import ConfigFile
import os


class IconColorizer:
    def __init__(self, path, color, config_key, packs, use_os_listdir=True, sizes=list, inversed_path = False):
        self.icons = path
        self.color = color
        self.packs = packs
        self.sizes = sizes
        self.use_os_listdir = use_os_listdir
        self.blacklist = []
        self.config = ConfigFile.ConfigFile()
        self.config_key = config_key
        self.inversed_path = inversed_path

    def colorize(self):
        for i in self.packs:
            if self.use_os_listdir:
                self.sizes = os.listdir(self.icons + f'/{i}')
            for j in self.sizes:
                path = self.icons + f'/{i}' + f'/{j}' + '/places'
                if self.inversed_path:
                    path = self.icons + f'/{i}' + '/places' + f'/{j}'
                try:
                    files = os.listdir(path)
                except:
                    #print('Incorrect iconpack')
                    continue
                for file_name in files:
                    if file_name in self.blacklist:
                        continue
                    file = path + '/' + file_name
                    with open(file) as f:
                        lines = f.readlines()
                    for line_index in range(len(lines)):
                        if lines[line_index].find(self.config[self.config_key]) == -1:
                            continue
                        lines[line_index] = lines[line_index].replace(self.config[self.config_key],
                                                                      self.color.get_hex_view())

                    try:
                        os.remove(file)
                    except:
                        pass
                    with open(file, 'w') as f:
                        f.writelines(lines)

        self.config[self.config_key] = self.color.get_hex_view()
