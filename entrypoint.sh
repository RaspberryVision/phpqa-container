#!/bin/sh

# RUN QA TOOLS

# PHPLOC - basic info about code
phploc /code > /logs/phploc/result.log

# SEND RESULTS TO CHECKER API - todo
