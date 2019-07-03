# --------------------------------------------- #
# getOpenPort					#
# installation file				#
# b00l34n					#
#						#
# Makefile                                      #
# version: 0.1 					#
# --------------------------------------------- #

NEEDED_PY_VERSION= Python 3.7.3
GET_PY_VERSION=    $(shell python -V)

.PHONY: install uninstall check help
.SUFFIXES: .py .sh
.SECONDARY:

default: install 

check:
ifeq "$(shell python -V)" "Python 3.7.3"
	@GOO=0
	@echo -e "[  \e[1;32mOK\e[0m  ] Checking for dependencies"		
else
	@echo -e "[ \e[1;31mFAIL\e[0m ] Checking for dependencies" >&2
	@echo "         Make sure you are using the Python Version 3.7.3" >&2	
endif

install: check
ifeq "$(GOO)" "0"
	sudo cp -r ./share/* /usr/share 
	sudo cp -r ./bin/* /usr/share/getOpenPort 
	sudo ln /usr/bin/getOpenPort /usr/share/getOpenPort.sh
	@echo -e "[  \e[1;32mOK\e[0m  ] Installing files"	
else
	@echo -e "[ \e[1;31mFAIL\e[0m ] Installing files" >&2
	@echo "         Make sure you are root while installing!">&2
endif

uninstall:
	sudo rm -rf /usr/share/getOpenPort
	sudo rm /usr/bin/getOpenPort
ifneq "$(shell ls /usr/bin | grep 'getOpenPort')" "getOpenPort"
	@echo -e "[  \e[1;32mOK\e[0m  ] removed starer-skript"		
else
	@echo -e "[ \e[1;31mFAIL\e[0m ] removed starer-skript" >&2
	@echo "         Make sure you are root while uninstalling!">&2
endif
ifneq "$(shell ls /usr/share | grep 'getOpenPort')" "getOpenPort"
	@echo -e "[  \e[1;32mOK\e[0m  ] removed python-skript"		
else
	@echo -e "[ \e[1;31mFAIL\e[0m ] removed python-skript" >&2
	@echo "         Make sure you are root while uninstalling!">&2
endif

help:
	@echo "Makefile to install the getOpenPort Skripts."
	@echo ""
	@echo "TARGETS"
	@echo "	install   - checks the python version and installs the skripts"
	@echo "	uninstall - removes all the skripts out of the system files"
	@echo "	check     - checks if the python version is right"
	@echo "	help      - display this help and exit"
	@echo ""
