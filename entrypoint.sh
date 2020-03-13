#!/bin/sh

# Initialize dirs

#PHPQA_HOME_DIR=~/phpqa
#PHPQA_CODE_DIR=$PHPQA_HOME_DIR/code
#PHPQA_LOGS_DIR=$PHPQA_HOME_DIR/logs

# INTERNAL FUNCTIONS - @TODO - extract to separently file 
printToConsole()
{
	printf "\n*** $1 ***" | tr a-z A-Z
}

checkHomeDir()
{
	if [ ! -d $PHPQA_HOME_DIR ]
	then
		printToConsole "PHPQA HOME DIRECTORY DOESN'T EXIST"
		printToConsole "TRY TO CREATE DIRECTORY AT $PHPQA_HOME_DIR"
		mkdir $PHPQA_HOME_DIR
	fi
	cd $PHPQA_HOME_DIR
	printToConsole "Change working directory to $PHPQA_HOME_DIR"
}

checkCodeDir()
{
	if [ ! -d $PHPQA_CODE_DIR ]
	then
		printToConsole "CODE DIRECTORY DOESN'T EXIST - LACK CODE TO ANALYZE - EXIT"
		#exit
	fi
	printToConsole "Directory with code to analyze: $PHPQA_CODE_DIR"
}

checkLogsDir() 
{
	if [ ! -d $PHPQA_LOGS_DIR ]
	then
		printToConsole "Logs directory ($PHPQA_LOGS_DIR) doesn't exist. Try to create it."
		mkdir $PHPQA_LOGS_DIR && chmod -R 777 $PHPQA_LOGS_DIR
	fi
	printToConsole "Diretory for result reports: $PHPQA_LOGS_DIR"
}

runTool()
{
	printToConsole "Running $1"
	rm -Rf $PHPQA_LOGS_DIR/$1
	mkdir -p $PHPQA_LOGS_DIR/$1
	$1 $PHPQA_CODE_DIR > $PHPQA_LOGS_DIR/$1/result.log
	printToConsole "Finish $1"
	reportTool $1
}

reportTool()
{
	printToConsole "Sending results to Checker..."
	printToConsole "Analyze report successfully sended to Checker."
}

# Starting info
checkHomeDir

# Code directory
checkCodeDir

# Logs directory
checkLogsDir

# RUN QA TOOLS
printToConsole "Running tools..."

# PHPLOC - basic info about code
runTool phploc
runTool phpunit
runTool phpmd

# SEND RESULTS TO CHECKER API - todo
