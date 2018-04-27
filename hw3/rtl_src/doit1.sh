#!/bin/bash

#Check for correct number of inputs
if [ "$#" -eq 0 ]; then
  echo "no module argument given"
  echo "Usage: doit <module_name>"
  exit 1
fi

#if there are list files, delete them
count=`ls -1 $1.list 2>/dev/null | wc -l`
if [ $count != 0 ]
then
      #prevent accidental positive comparisons
      for listfiles in `ls $1.list`
      do
            rm Rf $listfiles
            echo "> deleting listfile $listfiles <"
      done
fi
