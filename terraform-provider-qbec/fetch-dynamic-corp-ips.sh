#!/bin/bash

# We use a bash script for illustration but this
# could have been any executable.
# The program can receive input from qbec.
keyname=$1

# This is the hypothetical program that calls out to the IPs 
# service to get the list of IPs.
# For illustrating use qbec provided parseYaml native function,
# we'll assume the api returns a yaml doc.

# Would have been the output of a curl to the actual api here
printf "$keyname:\n  - '33.33.33.33/32' \n  - '44.44.44.44/32'\n"