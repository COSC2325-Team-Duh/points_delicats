#define PY_SSIZE_T_CLEAN
#include <Python.h>

uint32_t *gpio_memory;

static PyObject *method_pin_write(PyObject *self, PyObject *args) {
    int pin, value;
    extern void gpioSet(uint32_t*, int);
    extern void gpioClr(uint32_t*, int);
    if (!PyArg_ParseTuple(args, "ii", &pin, &value)) {
        Py_INCREF(Py_None);
        return Py_None;
    }
    if (value == 1) {
        gpioSet(gpio_memory, pin);
    }
    else if (value == 0) {
        gpioClr(gpio_memory, pin);
    }
    Py_INCREF(Py_None);
    return Py_None;
}

static PyObject *method_set_pin_mode(PyObject *self, PyObject *args) {
    int *pin, *mode;
    extern void gpioSelect(uint32_t*, int*, int*);

    if (!PyArg_ParseTuple(args, "ii", &pin, &mode)) {
        Py_INCREF(Py_None);
        return Py_None;
    }
    gpioSelect(gpio_memory, pin, mode);

    Py_INCREF(Py_None);
    return Py_None;
}

static PyObject * method_setup_pins(PyObject *self, PyObject *args) {
    extern uint32_t* mapMem();
    gpio_memory = mapMem();
    printf("GPIO Loc: %p\n", gpio_memory);
    Py_INCREF(Py_None);
    return Py_None;
}
static PyMethodDef Pin_WriteMethods[] = {
    {"pin_write", method_pin_write, METH_VARARGS, "Writes to GPIO pin"},
    {"set_pin_mode", method_set_pin_mode, METH_VARARGS, "Assembly GPIO interface"},
    {"setup_pins", method_setup_pins, METH_VARARGS, "MAPS the GPIO address and sets up library"},
    {NULL, NULL, 0, NULL}
};

static struct PyModuleDef pin_writemodule = {
    PyModuleDef_HEAD_INIT,
    "pin_write",
    "Writes to GPIO pin",
    -1,
    Pin_WriteMethods,
};

PyMODINIT_FUNC PyInit_pin_write(void) {
    return PyModule_Create(&pin_writemodule);
}
