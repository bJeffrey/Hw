#!/bin/bash
#script "doit"
#requires one argument which is the module name of interest
#check for single arguement given
# "$#" is the number of arguments given

if [ $# ­eq 0 ] ; then
      echo "no module argument given"
      echo "Usage:  doit <module_name>"
exit
fi
#prevent accidental positive comparisons
for listfiles in `ls $1.list`
 do
   rm ­Rf $listfiles 
   echo "­­> deleting listfile $listfiles <­­"
 done
#create the work directory is its not there
if [ ! ­d "work" ] ;  then
  echo "­­> directory work does not exist, creating it now <­­."
  vlib work
fi
#check to see if the cell library has been compiled
#bash return status variable "$?" holds program completion status
#using the "quiet" mode of grep
grep  ­q XOR3X2.v work/_info
if [ $? ­eq  0 ] ; then
  echo "­­> compiled cells found in work directory <­­"
else
  echo "­­> compiled cells not found, compiling cell library <­­"
  vlog_cells
fi
#compile the verilog source file
if [ ­s "$1.v" ] ;  then
  echo " "
  echo "compiling verilog file $1.v"
  echo " "
  vlog mult.v
  echo " "
fi
#run the rtl level simulation
#eliminate warnings on port miscompares and timescale mismatchs
vsim $1 ­do do.do ­quiet ­c +nowarnTFMPC +nowarnTSCALE
#move list file assumed to be the golden one
mv $1.list $1.golden.list
######
#build the dc_shell script here
#has all info except design specific net names and pins
echo "read_verilog $1.v"                                    >| script$$
echo "link"                                                 >> script$$
echo "source dc_constraints"                                >> script$$
echo "compile"                                              >> script$$
echo "write ­format verilog ­hierarchy ­output  $1.gate.v"  >> script$$
echo "quit"                                                 >> script$$
cp script$$  dc_syn_script
rm script$$
######
#synthesize the design
dc_shell­xg­t ­f dc_syn_script
#use only to view gates
#remember to comment out quit command in dc_syn_script
#design_vision­xg ­f dc_syn_script
#compile the gate level design
#image in work is overwritten
vlog adder.gate.v
#run the gate­level simulation
#eliminate warnings on port miscompares and timescale mismatchs
vsim adder  ­do do.do ­quiet ­c +nowarnTFMPC +nowarnTSCALE
#check for differences between golden and gate output
diff adder.list adder.golden.list >| diff_report
if [ ! ­s "diff_file" ]; then
  echo " "
  echo "­­> Gate list file MATCHES rtl list file <­­"
  echo " "
else
  echo " "
  echo "­­> Gate list file DOES NOT match rtl list file <­­"
  echo " "
  exit
fi
