# phpqa-container

This image is available on DockerHUB: [raspberryvision/phpqa](https://hub.docker.com/repository/docker/raspberryvision/phpqa)

Very simple, based on https://github.com/jakzal/phpqa container. Provides access to many QA control tools in the docker container. Note, after work, send results to the API service checker. All scripts run in container defined in `entrypoint.sh` file.

## How to works?

The container has access to all available tools from the CLI level, the analyzed code is attached as a volume in the container, it is mapped to the directory `/code` whose content will be analyzed.

All logs and reports are saved in the `/logs/$toolName` directory.

## Environments

**PHPQA_HOME_DIR** - main directory for QA operations (default `/phpqa`).
**PHPQA_CODE_DIR** - the catalog that will be analyzed (default `/phpqa/code`).
**PHPQA_LOGS_DIR** - directory for logs and analysis reports (default `/phpqa/logs`).
**PHPQA_TOOLS** - list of tools to be launched along with startup parameters (default `PHPLOC`).

## Available tools
**analyze** - Visualizes metrics and source code  
**behat** - Helps to test business expectations  
**churn** - Discovers good candidates for refactoring  
**composer-normalize** - Composer plugin to normalize composer.json files  
**composer-unused** - Show unused packages by scanning your code  
**dephpend** - Detect flaws in your architecture  
**deprecation-detector** - Finds usages of deprecated code  
**deenvironmentptrac** - Enforces dependency rules between software layers  
**diffFilter** - Applies QA tools to run on a single pull request  
**ecs** - Sets up and runs coding standard checks  
**infection** - AST based PHP Mutation Testing Framework  
**parallel-lint** - Checks PHP file syntax  
**paratest** - Parallel testing for PHPUnit  
**pdepend** - Static Analysis Tool  
**phan** - Static Analysis Tool  
**php-coupling-detector** - Detects code coupling issues  
**php-cs-fixer** - PHP Coding Standards Fixer  
**php-formatter** - Custom coding standards fixer  
**php-semver-checker** - Suggests a next version according to semantic versioning  
**phpDocumentor** - Documentation generator  
**phpbench** - PHP Benchmarking framework  
**phpa** - Checks for weak assumptions  
**phpat** - Easy to use architecture testing tool  
**phpca** - Finds usage of non-built-in extensions  
**phpcb** - PHP Code Browser  
**phpcbf** - Automatically corrects coding standard violations  
**phpcf** - Finds usage of deprecated features  
**phpcov** - a command-line frontend for the PHP_CodeCoverage library  
**phpcpd** - Copy/Paste Detector  
**phpcs** - Detects coding standard violations  
**phpda** - Generates dependency graphs  
**phpdoc-to-typehint** - Automatically adds type hints and return types based on PHPDocs  
**phpinsights** - Analyses code quality, style, architecture and complexity  
**phplint** - Lints php files in parallel  
**phploc** - A tool for quickly measuring the size of a PHP project  
**phpmd** - A tool for finding problems in PHP code  
**phpmetrics** - Static Analysis Tool  
**phpmnd** - Helps to detect magic numbers  
**phpspec** - SpecBDD Framework  
**phpstan** - Static Analysis Tool  
**phpstan-deprecation-rules** - PHPStan rules for detecting deprecated code  
**phpstan-ergebnis-rules** - Additional rules for PHPstan  
**phpstan-strict-rules** - Extra strict and opinionated rules for PHPStan  
**phpstan-doctrine** - Doctrine extensions for PHPStan  
**phpstan-phpunit** - PHPUnit extensions and rules for PHPStan  
**phpstan-symfony** - Symfony extension for PHPStan  
**phpstan-beberlei-assert** - PHPStan extension for beberlei/assert  
**phpstan-webmozart-assert** - PHPStan extension for webmozart/assert  
**phpstan-exception-rules** - PHPStan rules for checked and unchecked exceptions  
**phpunit** - The PHP testing framework  
**phpunit-8** - The PHP testing framework (8.x version)  
**phpunit-7** - The PHP testing framework (7.x version)  
**psalm** - Finds errors in PHP applications  
**psecio-parse** - Scans code for potential security-related issues  
**rector** - Tool for instant code upgrades and refactoring  
**roave-backward-compatibility-check** - Tool to compare two revisions of a class API to check for BC breaks  
**security-checker** - Checks composer dependencies for known security vulnerabilities  
**simple-phpunit** - Provides utilities to report legacy tests and usage of deprecated code  

## Todo
Consider to use multistage build - https://docs.docker.com/develop/develop-images/multistage-build/

Here is a alternative image:
https://github.com/EdgedesignCZ/phpqa
