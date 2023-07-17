**<h1>The Scyther tool repository</h1>**

This README describes the organization of the repository of the Scyther tool for security protocol analysis. Scyther is a tool for the automatic verification of security protocols.
For installation, usage instructions, and pre-built binaries of the Scyther tool refer to this [link] (https://cispa.saarland/group/cremers/scyther/index.html)

**Note:** The graphical user interface of Scyther is written in the Python language. Note that currently, Scyther does not support Python 3 (as it is not supported by the wxPython library below).

**Requirements**
To be able to use all of Scyther's features, the following three dependencies are needed. If you only require the back-end tool (used from the command line) then you need only the first.

**The GraphViz library**

This library is used by the Scyther tool to draw graphs. It can be freely downloaded from:

    http://www.graphviz.org/

Download the latest stable release and install it.

**Python**

Stable releases of the Python interpreter are available from:

    http://www.python.org/download/


**Mac OS X**

If the package yields an error when you try to install it, please use the following, in the directory where you downloaded it:

     $ sudo installer -pkg graphviz-2.34.0.pkg -target /
      wxPython libraries

The GUI user interface uses the wxPython libraries. The recommended way of installing is through pip and described on this page:

    https://www.wxpython.org/download.php

This version of Scyther requires at least wxPython 4.0. Note that older versions of Scyther did not work with wxPython 4.

For Ubuntu users, it is important to add an additional parameter, e.g., for Ubuntu 20.04, the recommended pip install is:

     $ sudo apt install python-pip
     $ pip install -U \
      -f https://extras.wxpython.org/wxPython4/extras/linux/gtk3/ubuntu-20.04 \
      wxPython

**License**

Currently, these Scyther sources are licensed under the GPL 2, as indicated in the source code. Contact Cas Cremers if you have any questions.