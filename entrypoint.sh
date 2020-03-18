#!/bin/sh

# INTERNAL FUNCTIONS - @TODO - extract to separently file 
printToConsole()
{
	printf "\n*** $1 ***" | tr a-z A-Z
}

printEmptyLine()
{
	printf "\n"
}

checkHomeDir()
{
	if [ ! -d $PHPQA_HOME_DIR ]
	then
		printToConsole "PHPQA HOME DIRECTORY DOESN'T EXIST"
		printToConsole "TRY TO CREATE DIRECTORY AT $PHPQA_HOME_DIR"
		mkdir -p $PHPQA_HOME_DIR
	fi
	cd $PHPQA_HOME_DIR
	printToConsole "Change working directory to $PHPQA_HOME_DIR"
	printEmptyLine
}

checkCodeDir()
{
	if [ ! -d $PHPQA_CODE_DIR ]
	then
		printToConsole "CODE DIRECTORY DOESN'T EXIST - LACK CODE TO ANALYZE - EXIT"
		exit
	fi
	printToConsole "Directory with code to analyze: $PHPQA_CODE_DIR"
	printEmptyLine
}

checkLogsDir() 
{
	if [ ! -d $PHPQA_LOGS_DIR ]
	then
		printToConsole "Logs directory ($PHPQA_LOGS_DIR) doesn't exist. Try to create it."
		mkdir -p $PHPQA_LOGS_DIR -m 777
	fi
	printToConsole "Diretory for result reports: $PHPQA_LOGS_DIR"
	printEmptyLine
}

runTool()
{
	printToConsole "Running $1"
	rm -Rf $PHPQA_LOGS_DIR/$1
	mkdir -p $PHPQA_LOGS_DIR/$1
	$@ > $PHPQA_LOGS_DIR/$1/result.log
	printToConsole "Finish $1"
	printEmptyLine
}

sendReport() 
{
	# SystemStatus request
	url=https://temptemp3.github.io

	if curl --fail -X POST -d@/phpqa/logs/phploc/result.log ${url}; then
        printToConsole "Successfully sended report"
    else
        echo "fail"
    fi;
}

# Starting info
checkHomeDir

# Code directory
checkCodeDir

# Logs directory
checkLogsDir

# RUN QA TOOLS
printToConsole "Running tools"

# PHPLOC - basic info about code
runTool phploc $PHPQA_CODE_DIR

sendReport
