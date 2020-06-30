#!/bin/bash
echo
echo '****************************************'
echo 'Running APEX Script '$1''
echo '****************************************'
echo

sfdx force:apex:execute -f $1 -u $2
