# --------------------------------------------- #
# getOpenPort                                   #
# installation file                             #
# b00l34n                                       #
#                                               #
# Makefile                                      #
# version: 1.1                                  #
# --------------------------------------------- #

INSTALLDIR        = /usr

NEEDED_PY_VERSION = Python 3.7.3
GET_PY_VERSION    = $(shell python -V)

.PHONY: install uninstall check help
.SUFFIXES: .py .sh .head .body
.SECONDARY:

default: build 

check:
ifeq "$(shell python -V)" "Python 3.7.3"
	@echo -e "[  \e[1;32mOK\e[0m  ] Checking for dependencies"		
else
	@echo -e "[ \e[1;31mFAIL\e[0m ] Checking for dependencies" >&2
	@echo "         Make sure you are using the Python Version 3.7.3" >&2
	@exit 1	
endif

build:
	@mkdir ./bin
	@cat ./src/starter.head > ./bin/getOpenPort.sh
	@echo "INSTALLDIR="$(INSTALLDIR) >> ./bin/getOpenPort.sh
	@cat ./src/starter.body >> ./bin/getOpenPort.sh

install: check
	@cp -r ./share/* $(INSTALLDIR)/share 
	@cp -r ./bin/* $(INSTALLDIR)/share/getOpenPort
	@ln $(INSTALLDIR)/share/getOpenPort/getOpenPort.sh $(INSTALLDIR)/bin/getOpenPort
	@chmod 747 $(INSTALLDIR)/bin/getOpenPort
	@echo -e "[  \e[1;32mOK\e[0m  ] Installing files"	

uninstall:
	rm -rf $(INSTALLDIR)/share/getOpenPort
	rm $(INSTALLDIR)/bin/getOpenPort
ifneq "$(shell ls $(INSTALLDIR)/bin | grep 'getOpenPort')" "getOpenPort"
	@echo -e "[  \e[1;32mOK\e[0m  ] removed starer-skript"		
else
	@echo -e "[ \e[1;31mFAIL\e[0m ] removed starer-skript" >&2
	@echo "         Make sure you are root while uninstalling!">&2
endif
ifneq "$(shell ls $(INSTALLDIR)/share | grep 'getOpenPort')" "getOpenPort"
	@echo -e "[  \e[1;32mOK\e[0m  ] removed python-skript"		
else
	@echo -e "[ \e[1;31mFAIL\e[0m ] removed python-skript" >&2
	@echo "         Make sure you are root while uninstalling!">&2
endif

help:
	@echo "Makefile to install the getOpenPort Skripts."
	@echo ""
	@echo "VARIABLES"
	@echo "  INSTALLDIR  - specifies the directory where to copy the files"
	@echo "                (default=/usr)"
	@echo ""
	@echo "TARGETS"
	@echo "	install      - checks the python version and installs the skripts"
	@echo "	uninstall    - removes all the skripts out of the system files"
	@echo "	check        - checks if the python version is right"
	@echo "	help         - display this help and exit"
	@echo ""

debug:
	@echo "= GET_PYTHON_VERSION:\n	 =" 
	$(GET_PY_VERSION)
