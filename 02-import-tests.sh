#!/bin/bash

#####################################################################
# ./02-import-tests.sh $PWD files.txt testset.txt
#####################################################################


if [ "$#" -ne 3 ]
then
  echo "Usage: 02-import-tests <projects root directory> <file with directory names to be tested> <test-set-file>"
  exit 1
else
   EXPER_HOME=$1
   FILES=$2
   TESTSET=$3

   for PROG in $(cat ${EXPER_HOME}/$FILES)
   do
      echo "############### TESTING PROGRAM: $PROG ###############"
      SESSION=S_$PROG

      # Compilando o código
      cd $EXPER_HOME/$PROG

      # Importing test cases
      tc=1
      NTC=$(wc -l $TESTSET | awk '{print $1}')
      while [ $tc -le $NTC ]; 
      do
         param=$(head -$tc $TESTSET | tail -1)
         echo "Importing TC $tc of $NTC - param: $param"
         tcase-add -p "$param" -EE ${PROG}_inst -trace $SESSION

         #Running to measure coverage
         ./${PROG}Cov $param

         tc=$((tc + 1))
      done

      echo "############### REPORT OF TEST EXECUTION ON $PROG ###############"
      tcase -l $SESSION > report-tests-run-original.lst

      # Generating coverage report
      gcov ${PROG}.c
      lcov --capture --directory . --output-file coverage.info
      genhtml coverage.info --output-directory coverage_report
   done
fi