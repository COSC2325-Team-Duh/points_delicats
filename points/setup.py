from distutils.core import setup, Extension

def main():
    setup(name="points",
            version="1.0.0",
            ext_modules=[Extension("set_pin_mode", ["set_pin_mode.c"],
                            extra_objects=["./gpio_objects/gpio_map.o",
                                           "./gpio_objects/gpio_sel.o",
                                           "./gpio_objects/gpio_unmap.o"]),
                         Extension("pin_write", ["pin_write.c"],
                             extra_objects=["./gpio_objects/gpio_map.o",
                                            "./gpio_objects/gpio_set.o",
                                            "./gpio_objects/gpio_clr.o",
                                            "./gpio_objects/gpio_unmap.o"])])

if __name__ == "__main__":
    main()
else:
    pass
