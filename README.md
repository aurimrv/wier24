# WIER`2024

## Pre-requirements

Scripts below uses ProteumIM testing tool which requires to set a environment variable called `PROTEUMIMHOME` pointing to ProteumIM baase directory. 

### Configure ProteumIM - Mutation Testing tool for C

```
cd $HOME/wier24
tar zxvf ProteumIM.tgz
```

Assuming you uncompess this file in your `$HOME/wier24` directory, in Linux, please, edit `.bashrc` file and include the following lines:

```
export PROTEUMIMHOME=$HOME/wier24/ProteumIM64
export PATH=$PROTEUMIMHOME/bin:$PATH
```

### Configure gcc, gvoc, lcov - Coverage testing tool for C

```
sudo apt-get -y install lcov
```

### Set executon attribute on scripts

```
cd $HOME/wier24
chmod a+x *.sh
```

## Hands-on 

### Test session creation

```
./01-create-test-session.sh $PWD files.txt
```

### Evaluate coverage of `testset-0.txt`

```
./02-import-tests.sh $PWD files.txt testset-0.txt
```

### Evaluate coverage and mutation score of adequate test set for coverage testing `testset-cov.txt`

```
./02-import-tests.sh $PWD files.txt testset-cov.txt
```

```
./03-run-tests.sh $PWD files.txt
```

### Example of live and equivalent mutants

19 and 33 - equivalent
72 - non-equivalent 


### Discard equivalent mutants

```
./04-check-equivalents.sh $PWD files.txt
```

## Evaluate mutation score of adequate test set for mutation testing `testset-mt.txt`

```
./02-import-tests.sh $PWD files.txt testset-mt.txt
```

```
./03-run-tests.sh $PWD files.txt
```