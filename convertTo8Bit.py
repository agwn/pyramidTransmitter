#!/usr/bin/env python

with open('CIE.txt','r') as inputFile:
    for line in inputFile.readlines():
        val = int(line.rstrip())
        print (val >> 8)

