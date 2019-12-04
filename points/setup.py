from setuptools import setup, Extension
from setuptools.command.install import install
import os

class InstallPyCommand(install):

    def run(self):
        mkdir = os.popen('mkdir gpio_objects').read()
        make = os.popen('make').read()
        print(make)
        install.run(self)

def main():
    setup(name="points",
            version="1.0.0",
            cmdclass={
                    'install': InstallPyCommand,
                },
            ext_modules=[Extension("set_pin_mode", ["set_pin_mode.c"],
                            extra_objects=["./gpio_objects/gpio_map.o",
                                           "./gpio_objects/gpio_sel.o",
                                           "./gpio_objects/gpio_unmap.o"]),
                         Extension("pin_write", ["pin_write.c"],
                             extra_objects=["./gpio_objects/gpio_map.o",
                                            "./gpio_objects/gpio_set.o",
                                            "./gpio_objects/gpio_clr.o",
                                            "./gpio_objects/gpio_unmap.o"])
                        ]
            )

if __name__ == "__main__":
    main()
else:
    pass
