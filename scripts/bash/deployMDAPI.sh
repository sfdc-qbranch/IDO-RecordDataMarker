#!/bin/bash
read -p 'SFDX Org Alias: ' orgAlias
read -p 'MetaData Package Name: ' packName

sfdx force:mdapi:deploy -u $orgAlias -w 20 --deploydir "mdapi-source/$packName"
