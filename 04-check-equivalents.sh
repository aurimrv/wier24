#!/bin/bash

#####################################################################
# ./04-check-equivalents.sh $PWD files.txt
#####################################################################


if [ "$#" -ne 2 ]
then
  echo "Usage: 04-check-equivalents.sh <projects root directory> <file with directory names to be tested>"
  exit 1
else
   EXPER_HOME=$1
   FILES=$2

   for PROG in $(cat ${EXPER_HOME}/$FILES)
   do
      SESSION=S_$PROG

      # Compilando o código
      cd $EXPER_HOME/$PROG
      echo "$EXPER_HOME/$PROG"

      # Marking all equivalent mutants
      equivalents=$(cat equivalent_$PROG.txt)
      echo $equivalents
      muta -equiv -x "$equivalents" $SESSION

      # Executing all mutants against the test cases
      exemuta -exec -v . -trace $SESSION

      report -tcase -S report-live-equiv $SESSION
      report -tcase -L 512 $SESSION
   done
fi