#!bash

cd `dirname $0`
windres terminal.rc -o terminal.coff
gcc terminal.c terminal.coff -o ../terminal.exe -mwindows
rm terminal.coff
