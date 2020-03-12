#!/bin/sh

# RUN QA TOOLS

# Create directory for analyze reports /logs
mkdir -p /logs

# PHPLOC - basic info about code
phploc /code > /logs/phploc/result.log

# SEND RESULTS TO CHECKER API - todo
