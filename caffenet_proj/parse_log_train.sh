#!/bin/bash
#Parse Log for Training Net
#Outputs "[ITERATION NUMBER] [LOSS VALUE]"
grep "Iteration" $1 | grep "loss" | sed -n -e 's/^.*Iteration //p' | sed -n -e 's/(.*), loss = //p'
