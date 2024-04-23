#!/bin/bash

#####################################################################
# ./03-run-tests.sh $PWD files.txt
#####################################################################


if [ "$#" -ne 2 ]
then
  echo "Usage: 03-run-test.sh <projects root directory> <file with directory names to be tested>"
  exit 1
else
   EXPER_HOME=$1
   FILES=$2

   for PROG in $(cat ${EXPER_HOME}/$FILES)
   do
      echo "############### TESTING PROGRAM: $PROG ###############"
      SESSION=S_$PROG

      # Compilando o código
      cd $EXPER_HOME/$PROG

      # Executing all mutants against the test cases
      time exemuta -exec -v . -trace $SESSION

      # Gerating mutation testing report
      report -tcase -S report-concise $SESSION
   done
fi