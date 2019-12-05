#define PY_SSIZE_T_CLEAN
#include <Python.h>

static PyObject *method_pin_write(PyObject *self, PyObject *args) {
    int *pin, value;
    extern void gpioSet(int*);
    extern void gpioClr(int*);

    if (!PyArg_ParseTuple(args, "ii", &pin, &value)) {
        Py_INCREF(Py_None);
    }
    if (value == 1) {
        gpioSet(pin);
    }
    else if (value == 0) {
        gpioClr(pin);
    }
    Py_INCREF(Py_None);
    return Py_None;
}

static PyMethodDef Pin_WriteMethods[] = {
    {"pin_write", method_pin_write, METH_VARARGS, "Writes to GPIO pin"},
    {NULL, NULL, 0, NULL}
};

static struct PyModuleDef pin_writemodule = {
    PyModuleDef_HEAD_INIT,
    "pin_write",
    "Writes to GPIO pin",
    0,
    Pin_WriteMethods,
};

PyMODINIT_FUNC PyInit_pin_write(void) {
    return PyModule_Create(&pin_writemodule);
}
