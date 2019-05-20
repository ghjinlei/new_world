#!/usr/bin/python

#-*- coding:utf-8 -*-
import pexpect
import sys

def main():
    port = sys.argv[1]
    serv_addr = sys.argv[2]
    child = pexpect.spawn("nc localhost {port}".format(port = port))
    child.logfile_read = sys.stdout
    child.expect("Welcome to skynet console")
    child.sendline("call {serv_addr} 'Shutdown'\r".format(serv_addr = serv_addr))
    child.expect("OK")
    child.sendline("info {serv_addr}\r".format(serv_addr = serv_addr))
    child.expect("OK")
    child.interact()

if __name__ == "__main__":
        main()
