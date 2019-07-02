#!/usr/bin/python
#
# getPortFormatet.py: formats the output of a pre-editet netstat call, so it
#                     look nice and neet. It is mainy ment for other Programs
#                     like "conky" or "wtfutil". But, it can also be used for 
#                     a quick overview of all open Ports in the cli
#
# Author: b00l34n 
#         
# Ver.: 1.0


import os     # for executing Shell Comands
import sys    # for resiving Arguments
import signal # for system Signal catching
import time   # for timing the interval output

PORT_ADDRES_LEN = 22 # max number of Chars in an Address segment
STATUS_LEN = 13      # max number of Chars in the Status segment
INTERVAL_TIME = 3    # time between outputs in seconds

# the shell-comand that gets all of the port information
GSS='netstat -np 2> /dev/null | grep "[ut][dc]p" | sed "s/\s\{2,\}/ /g" | cut -d " " -f "1 4-" | sed "s/ / | /g" ' 


##
# This Class is, as the name says, used to cancel the infint loops with SIGTERM.
# I got the consept from a StackOverflow post by 
# "Mayank Jaiswal" (https://stackoverflow.com/users/578989/mayank-jaiswal) 
# This is the like to the original post:
# https://stackoverflow.com/questions/18499497/how-to-process-sigterm-signal-gracefully/31464349#31464349
#
class GracefulKiller:
  kill_now = False
  def __init__(self):
    signal.signal(signal.SIGTERM, self.exit_gracefully)

  def exit_gracefully(self,signum, frame):
    self.kill_now = True


##
# method for executing the "shell-script", and reads form its output
# for every read line-feed, this methode begins a new line in the list,
# wich resolves in an empty line at the end of the list
#
# @param "script" string: [path]skript|comand  
# @return ""       array: List of lines the skript printet out
def readGetStat( script ):
    readFromStdOut=os.popen(script).read() # exec skript
    if len(readFromStdOut) > 1:
        return readFromStdOut.split("\n");     # return the list
    else:
        print("============================================ NO PORTS OPEN ============================================")
        return(" ")
#  //readGetStat

##
# method for formating one line in the list
#
# @param  listElem int: index der host- oder remote- Addresse
# @param  list   array: Die Liste in denen der segmentierte String enthalten ist
# @param  MAX      int: Die Maxiemale, bis dahin aufzufülende, Anzahl an zeichen
# @return > list array: Die bearbeiteten Strings in einem array
def einrueck( listElem , list , MAX ):
   PORT_ADDRES_LEN = 21 
   if len(list[ listElem ]) < MAX: 
       for i in range( len(list[listElem]), MAX ):
            list[ listElem ] = list[ listElem ] + " "
# //addressEinrück


##
# this method executes the formating prosess for every line in the list
# and prints it on stdout
# 
# @param stirngIN: the list of strings, the shell-skript printed out
# @stdout:         the formated(finished) output 
def genOutPut( stirngIN ):
    if len(stirngIN) >= 2:
        for lines in stirngIN:
            if len(lines) > 3:
                list = lines.split("|")
                einrueck(1,list,PORT_ADDRES_LEN)
                einrueck(2,list,PORT_ADDRES_LEN)
                einrueck(3,list,STATUS_LEN)
                res = ""
                for i in range(0,len(list)-1):
                    if i == len(list)-2 :
                        res = res + list[i]
                    else :
                        res = res + list[i] + "│"
                # // for i
                print(res)
            else:
                print(lines)
            # // if len(lines)
        # // for lines
    else:
        print(stirngIN[0])
# //genOutPut 

##
# calls the genOutPut() function in an infinit
#
# @stdout:         the formated(finished) output 
def loopOutPut():
    killer = GracefulKiller()
    while not killer.kill_now:
        genOutPut(readGetStat(GSS))
        time.sleep(INTERVAL_TIME)
# // cleanOutput


##
# calls the loopOutPut() function in an infinit loop
# also executes the the shell comands
#   $ clear
#
# @stdout:         the formated(finished) output 
def cleanOutput():
    killer = GracefulKiller()
    while not killer.kill_now:
        os.system('clear')
        genOutPut(readGetStat(GSS))
        time.sleep(INTERVAL_TIME)
    print ("")
# // cleanOutput

##
# the main routin:
# given argument are prossesed there and the corosponding 
# funktion gets called
#
def main():
    MAX_OPTION_NUM = 1
    # ok now, i see how this is everything but KISS,
    # BUT, this is supposed to be a future prooved design.
    # If more options are going to be implementet, this is
    # realy going to be usefull! At least... i hope so...
    switch = {
        "-c": 0,
        "-s": 1,
        "-l": 2
    }
    switchRes = switch.get(sys.argv[1],"=== PY-ERROR: no Arguments given ===")
    
    if switchRes == 0:
        cleanOutput()
    if switchRes == 1:
        genOutPut(readGetStat(GSS))
    if switchRes == 2:
        loopOutPut()    
    if switchRes > MAX_OPTION_NUM:
        print(switchRes)

    # // switch
# // main
main()
