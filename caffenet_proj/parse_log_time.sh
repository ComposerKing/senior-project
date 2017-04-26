#!/bin/bash
#Parse Log for Training Times
#For each iteration chekpoint, output
#[MONTH] [DAY] [HOUR] [MIN] [SEC] [ITERATION]
grep "Iteration" $1 | grep "loss" | sed -n -e 's/s.*Iteration /--/p' | sed  -e 's/(.*//' | sed -e 's/I//' | sed -e 's/,.*//' | sed -e 's/../& /' | sed -e 's/:/ /g' | sed -e 's/\./ --/' | sed -e 's/--.*-//'
