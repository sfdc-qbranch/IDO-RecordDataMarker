#!/bin/bash
clear
DXPACKAGENAME="IDO Record Data Marker"

#read -p 'Use Snapshot? [y/n]: ' USESNAPSHOT


if [ "$USESNAPSHOT" == 'y' ]
then
  echo 'Using a snapshot to create the package version'
  sfdx force:package:version:create  --installationkeybypass --definitionfile config/snapshot-scratch-def.json --wait 10 --path force-app --package "$DXPACKAGENAME" $@
else
  echo 'Creating package version using a clean scratch org'
  sfdx force:package:version:create  --installationkeybypass --definitionfile config/project-scratch-def.json --wait 10 --path force-app --package "$DXPACKAGENAME" $@
fi
