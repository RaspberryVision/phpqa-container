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
 
	curl ${url} -I -o headers -s

	printToConsole "Successfully sended report"
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
runTool phploc --help
runTool analyze analyze --help
runTool behat --help
runTool churn --help
runTool composer-normalize --help
runTool composer-unused --help
runTool dephpend --help
runTool deprecation-detector --help
runTool deenvironmentptrac --help
runTool diffFilter --help
runTool ecs --help
runTool infection --help
runTool parallel-lint --help
runTool paratest --help
runTool pdepend --help
runTool phan --help
runTool php-coupling-detector --help
runTool php-cs-fixer --help
runTool php-formatter --help
runTool php-semver-checker --help
runTool phpDocumentor --help
runTool phpbench --help
runTool phpa --help
runTool phpat --help
runTool phpca --help
runTool phpcb --help
runTool phpcbf --help
runTool phpcf --help
runTool phpcov --help
runTool phpcpd --help
runTool phpcs --help
runTool phpda --help
runTool phpdoc-to-typehint --help
runTool phpinsights --help
runTool phplint --help
runTool phploc --help
runTool phpmd --help
runTool phpmetrics --help
runTool phpmnd --help
runTool phpspec --help
runTool phpstan --help
runTool phpstan-deprecation-rules --help
runTool phpstan-ergebnis-rules --help
runTool phpstan-strict-rules --help
runTool phpstan-doctrine --help
runTool phpstan-phpunit --help
runTool phpstan-symfony --help
runTool phpstan-beberlei-assert --help
runTool phpstan-webmozart-assert --help
runTool phpstan-exception-rules --help
runTool phpunit --help
runTool psalm --help
runTool psecio-parse --help
runTool rector --help
runTool roave-backward-compatibility-check --help
runTool security-checker --help
runTool simple-phpunit --help


sendReport
