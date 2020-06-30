#!/bin/bash

read -p 'MetaData Package Name: ' packName

sfdx force:source:convert -d "mdapi-source/$packName" -n "$packName"
