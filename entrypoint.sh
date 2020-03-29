#!/bin/sh

# INTERNAL FUNCTIONS - @TODO - extract to separently file
printToConsole() {
  printf "\n*** $1 ***" | tr a-z A-Z
}

printEmptyLine() {
  printf "\n"
}

checkHomeDir() {
  if [ ! -d $PHPQA_HOME_DIR ]; then
    printToConsole "PHPQA HOME DIRECTORY DOESN'T EXIST"
    printToConsole "TRY TO CREATE DIRECTORY AT $PHPQA_HOME_DIR"
    mkdir -p $PHPQA_HOME_DIR
  fi
  cd $PHPQA_HOME_DIR
  printToConsole "Change working directory to $PHPQA_HOME_DIR"
  printEmptyLine
}

checkCodeDir() {
  if [ ! -d $PHPQA_CODE_DIR ]; then
    printToConsole "CODE DIRECTORY DOESN'T EXIST - LACK CODE TO ANALYZE - EXIT"
    exit
  fi
  printToConsole "Directory with code to analyze: $PHPQA_CODE_DIR"
  printEmptyLine
}

checkLogsDir() {
  if [ ! -d $PHPQA_LOGS_DIR ]; then
    printToConsole "Logs directory ($PHPQA_LOGS_DIR) doesn't exist. Try to create it."
    mkdir -p $PHPQA_LOGS_DIR -m 777
  fi
  printToConsole "Diretory for result reports: $PHPQA_LOGS_DIR"
  printEmptyLine
}

checkTestsDir() {
  if [ ! -d "$PHPQA_TEST_DIR" ]; then
    printToConsole "Tests directory doesn't exist."
    return 1
  fi

  return 0
}

runTool() {
  printToConsole "Running $1"
  rm -Rf $PHPQA_LOGS_DIR/$1.log
  $@ >>$PHPQA_LOGS_DIR/$1.log
  printToConsole "Finish $1"
  printEmptyLine
  sendReport $1
}

sendReport() {
  url=http://$PHPQA_ENGINEER_HOST/index.php/api/report/$1

  machine=$PHPQA_MACHINE_NAME
  component=$PHPQA_COMPONENT_NAME
  file=$PHPQA_LOGS_DIR/$1.log

  if curl --fail -X POST -F build=$build -F machine=$machine -F component=$component -F report=@/$PHPQA_LOGS_DIR/$1.log ${url}; then
    printToConsole "Successfully sended report"
  else
    echo "fail"
  fi
}

isEngineerServiceReady() {

  printToConsole "Waiting for Engineer Service"
  printToConsole "Reporting build: {$1}"
  printEmptyLine

  until nc -z $PHPQA_ENGINEER_HOST $PHPQA_ENGINEER_PORT; do
    printf '.'
    sleep 5
  done

  echo "** SUCCESS ** | Engineer Service ready!"
  printEmptyLine
}

build=$(head -200 /dev/urandom | cksum | cut -f1 -d " ")

# Starting info
checkHomeDir

# Code directory
checkCodeDir

# Logs directory
checkLogsDir

# Check that Engineer Service is ready
isEngineerServiceReady

# RUN QA TOOLS
printToConsole "Running tools"

# PHPLOC - basic info about code
runTool phploc $PHPQA_CODE_DIR

# PHPUNIT - tests suites
checkTestsDir

if [ "$?" == 0 ]; then
  runTool phpunit $PHPQA_TEST_DIR
fi
