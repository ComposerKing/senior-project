#!/bin/bash
#Parse Log for Validation
#For each Test Net instantiation - outputs:
#   accuracy
#   loss 
grep "Test net" log10.txt | sed -n -e 's/^.*= //p' | sed -e 's/loss)//'
