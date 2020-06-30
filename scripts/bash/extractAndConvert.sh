#!/bin/bash
#Pulls down a particular package from a PROD org, unzips, converts it to SFDX file format and cleans up after itself

clear
read -p 'SFDX Alias: ' SFDXALIAS
read -p 'Package Name: ' PACKAGENAME

TEMPDIR='temp'$(date +%s)

echo '***********************************'
echo 'Creating temp directory '$TEMPDIR''
echo '***********************************'
mkdir $TEMPDIR

echo
echo '***********************************'
echo 'Retrieving metadata in package: '$PACKAGENAME''
echo '***********************************'
sfdx force:mdapi:retrieve -s -r ./$TEMPDIR -u $SFDXALIAS -p "$PACKAGENAME" -w 10

echo
echo '***********************************'
echo 'Unpacking metadata into '$TEMPDIR''
echo '***********************************'
unzip ./$TEMPDIR/unpackaged.zip -d ./$TEMPDIR/

echo
echo '***********************************'
echo 'Converting metadata from '$PACKAGENAME' into SFDX format'
echo '***********************************'
sfdx force:mdapi:convert -r ./$TEMPDIR

echo
echo '***********************************'
echo 'Deleting folder '$TEMPDIR''
echo '***********************************'
rm -rf $TEMPDIR

echo
echo '*********************************************************************************************************'
echo 'Package '$PACKAGENAME' has been extracted and converted into SFDX format in your project folder'
echo '*********************************************************************************************************'
