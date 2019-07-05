# getOpenPort

This is a little python-script, with a shell-script as a starter, will show all open TCP and UDP ports
with the PID and name of the software, each port belongs to.
It uses the BSD version of "netstat" for the general information, and the python-script to format
the output nicely. I recommend using python 3.7.3, because it's what I used to develop the skript

## insatlation:
execute "make" to build the starter script and "make install" to copy all the directory strucktur to 
/usr. If you want to change the installation directory, you need to execut "make" and "make install" with
"INSTALLDIR=/path/you/want". For example: 
"make INSTALLDIR=/path/you/want"
"make install INSTALLDIR=/path/you/want"

## removel:
it works just like the installation, just without the building part. That means, you need to set the
INSTALLDIR if you set it for the installation

## BTW:
If you have any recommendations on how to improve this project or how to improve my code quality in 
general, please let me know.
I am more then happy to receive some tipps from pros!