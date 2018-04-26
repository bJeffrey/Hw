#!/bin/bash
# this is for assignmnet #3
echo "Starting"
# create the work directory if it doesn't exist
if [ ! -d "work" ] ; then

  echo "work does not exist, making it"

  vlib work

fi



# compile mul.sv and mul_ctl.sv if they exist

if [ -s "mul_ctl.sv" ] ; then

  vlog -novopt mul_ctl.sv

fi



if [ -s "mul.sv" ] ; then

  vlog -novopt mul.sv

fi



# first run of the simulation

if [ -s "my.do" ] ; then

	vsim mul -do my.do -quiet -c -t 1ps

fi





# synthesize mul

if [ -s "dv_script" ] ; then

	dc_shell-xg-t -f dv_script

fi



# compile the gate library if it hasn't been done yet

if [ -s grep mul work/_info/* ] ; then



fi



# compile the .gate.v file

if [ -s "mul.gate.v" ] then

	vlog -novopt mul.gate.v

fi



# second run of the simulation

vsim mul -do my.do -quiet -c -t 1ps
