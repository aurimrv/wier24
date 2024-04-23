#!/bin/bash

#####################################################################
# ./01-create-test-session.sh $PWD files.txt
#####################################################################


if [ "$#" -ne 2 ]
then
  echo "Usage: 01-create-test-session <projects root directory> <file with directory names to be tested>"
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

      # Compiling original program
      compilation=$(cat compile.txt)
      $compilation

      # Compiling original program
      compilationcov=$(cat compile-coverage.txt)
      $compilationcov

      # Creating test-session
      test-new -S $PROG -E $PROG -C "$compilation" $SESSION

      # Creating original program instrumented version
      instrum -EE $SESSION __${PROG} 

      # Compiling instrumented version
      gcc __${PROG}_inst.c  __${PROG}_pp.c driver.c -o ${PROG}_inst -w -lm -I$PROTEUMIMHOME

      # Generating unit mutants considering all mutation operators
      functions=$(cat functions.txt | awk '{printf("-unit %s ", $1)}')
      muta-gen $functions -u- 1.0 0 $SESSION

      # Gerating initial testing report
      exemuta -exec -v . -trace $SESSION
      report -tcase -S report-initial $SESSION
   done
fi