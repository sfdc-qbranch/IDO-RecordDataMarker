#!/bin/bash

echo
echo '****************************************'
echo 'Installing GIT repo '$2' from user '$1''
echo '****************************************'
echo

sfdx shane:github:package:install -g $1 -r $2
