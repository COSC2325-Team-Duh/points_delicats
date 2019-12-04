#!/bin/bash
echo "TOUCHY DOTS"
echo ""
echo "This script will install a virtual env, activate it, and compile"
echo "and install the required assembly and c code to access the GPIO."

PROJ_DIR=$PWD

pip3 install --user virtualenv
virtualenv -p python3 .env

source .env/bin/activate
cd $PWD/points

python setup.py install
cd $PROJ_DIR

echo ""
echo ""
echo "***********************👇 NOTE 👇****************************"
echo "Before running main.py, be sure to run the following command:"
echo ""
echo "source .env/bin/activate"
