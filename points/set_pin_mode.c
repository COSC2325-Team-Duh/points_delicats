#define PY_SSIZE_T_CLEAN
#include <Python.h>

static PyObject *method_set_pin_mode(PyObject *self, PyObject *args) {
    int *pin, *mode;
    extern void gpioSelect(int*, int*);

    if (!PyArg_ParseTuple(args, "ii", &pin, &mode)) {
        Py_INCREF(Py_None);
        return Py_None;
    }
    gpioSelect(pin, mode);

    Py_INCREF(Py_None);
    return Py_None;
};

static PyMethodDef Set_Pin_ModeMethods[] = {
    {"set_pin_mode", method_set_pin_mode, METH_VARARGS, "Assembly GPIO interface"},
    {NULL, NULL, 0, NULL}
};

static struct PyModuleDef set_pin_modemodule = {
    PyModuleDef_HEAD_INIT,
    "set_pin_mode",
    "Assembly GPIO Interface",
    0,
    Set_Pin_ModeMethods,
};

PyMODINIT_FUNC PyInit_set_pin_mode(void) {
    return PyModule_Create(&set_pin_modemodule);
}
