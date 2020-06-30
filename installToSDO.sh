#!/bin/bash
# 1) SFDX org alias
# 2) SDO UserName

read -p 'SFDX Org Alias: ' orgAlias
read -p 'SDO username: ' SDOUserName
read -p 'Use Packages or MDAPI? p/m: ' deployMethod
read -p 'Is PROD or Sandbox? p/s: ' orgType

PROJECTNAME="PROJECT NAME"

DEFAULTPWD=$DX_DEF_PWD
# Encrypt the default password
ENCRYPT_RESULT=$(java -cp bin/dataloader/dataloader.jar com.salesforce.dataloader.security.EncryptionUtil -e $DEFAULTPWD data/prod/config/login.key | sed -n '1!p')

#Remove any whitespace
ENCRYPT_RESULT="$(echo -e "${ENCRYPT_RESULT}" | sed -e 's/^[[:space:]]*//')"
echo 'using encrypted PWD of '$ENCRYPT_RESULT''
SCRATCH_PWD=$ENCRYPT_RESULT
STARTTIME=$(date +%s)


# EDIT - tailor the list of packages to be installed for your IDO
if [ "$deployMethod" == 'p' ]; then

  echo
  echo '*************************************************'
  echo '****  Installing a pile of TTH IDO packages  ****'
  echo '*************************************************'
  echo

  echo "****  Installing IDO TTH COMMONS package...  ****"
  echo
  sfdx force:package:install --package "IDO TTH Commons - Deployed" -u $orgAlias --wait 30 --apexcompile package --securitytype AllUsers

  echo "****  Installing IDO TTH Traveler Base Datamodel package...  ****"
  echo
  sfdx force:package:install --package "IDO TTH Traveler Base Datamodel - Deployed" -u $orgAlias --wait 30 --apexcompile package --securitytype AllUsers

  echo "****  Installing IDO TTH Loyalty Datamodel package...  ****"
  echo
  sfdx force:package:install --package "IDO TTH Loyalty Datamodel - Deployed" -u $orgAlias --wait 30 --apexcompile package --securitytype AllUsers

  echo "****  Installing IDO TTH Res/Booking datamodel package...  ****"
  echo
  sfdx force:package:install --package "IDO TTH Reservation/Booking Datamodel - Deployed" -u $orgAlias --wait 30 --apexcompile package --securitytype AllUsers

  echo "****  IDO TTH SDO Tools Extension package...  ****"
  echo
  sfdx force:package:install --package "IDO TTH SDO Tool Extensions - Deployed" -u $orgAlias --wait 30 --apexcompile package --securitytype AllUsers

  echo "****  Demo Component - Marketing Cloud Engagement History...  ****"
  echo
  sfdx force:package:install --package "Demo Component - Marketing Cloud Engagement History" -u $orgAlias --wait 30 --apexcompile package --securitytype AllUsers

  echo "****  Demo Component - Lightning File Gallery...  ****"
  echo
  sfdx force:package:install --package "Demo Component - Lightning File Gallery" -u $orgAlias --wait 30 --apexcompile package --securitytype AllUsers

  echo "****  IDO TTH Guest 360 package...  ****"
  echo
  sfdx force:package:install --package "IDO TTH Guest 360 - Deployed" -u $orgAlias --wait 30 --apexcompile package --securitytype AllUsers
fi


if [ "$deployMethod" == 'm' ]; then
  echo '*************************************************'
  echo 'Installing to SDO via MDAPI....'
  echo '*************************************************'

  echo
  echo 'Deleting temp MDAPI folder...'
  rm -rf mdapi_temp

  echo
  echo 'Converting from SFDX format to MDAPI and placing in mdapi_temp folder...'
  sfdx force:source:convert -r ido-tth -d mdapi_temp

  echo
  echo 'Running Metadata Deploy...'
  sfdx force:mdapi:deploy -u $orgAlias -w 60 -d mdapi_temp

fi

echo
echo '*************************************************'
echo '****         Run pre data APEX Scripts       ****'
echo '*************************************************'
echo

#Apply permission sets
sfdx force:apex:execute -f scripts/apex/applyPermSets.apex -u $orgAlias

echo
echo '*************************************************'
echo '****         Load T&H Specific Data          ****'
echo '*************************************************'
echo
# Run data loader from terminal/command line
# https://developer.salesforce.com/docs/atlas.en-us.dataLoader.meta/dataLoader/command_line_intro.htm
# make it work for MacOS - https://github.com/theswamis/dataloadercliq
# sfdc.username = $2
# sfdc.password = $3

if [ "$orgType" == 'p' ]; then
  ./scripts/bash/loadProdData.sh $SDOUserName $SCRATCH_PWD https://login.salesforce.com
fi

if [ "$orgType" == 's' ]; then
  ./scripts/bash/loadProdData.sh $SDOUserName $SCRATCH_PWD https://test.salesforce.com
fi



echo
echo '*************************************************'
echo '****        Run post data APEX Scripts       ****'
echo '*************************************************'
echo

#Load up booking images
sfdx force:apex:execute -f scripts/apex/applyBookingImages.apex -u $orgAlias



echo
echo '*************************************************'
echo '****     Running post install Scripts        ****'
echo '*************************************************'
echo
# Leverage Shane Mc Extensions
# ** Activate Theme - https://github.com/mshanemc/shane-sfdx-plugins#sfdx-shanethemeactivate--n-string--b--u-string---apiversion-string---json---loglevel-tracedebuginfowarnerrorfataltracedebuginfowarnerrorfatal
# ** Geting Object IDs for use later - https://github.com/mshanemc/shane-sfdx-plugins#sfdx-shanedataidquery--o-string--w-string--u-string---apiversion-string---json---loglevel-tracedebuginfowarnerrorfataltracedebuginfowarnerrorfatal
# ** Upload Files - https://github.com/mshanemc/shane-sfdx-plugins#sfdx-shanedatafileupload--f-filepath--c--p-id--n-string--u-string---apiversion-string---json---loglevel-tracedebuginfowarnerrorfataltracedebuginfowarnerrorfatal
# Apply Dark Theme
#sfdx shane:theme:activate -u $1 -n THDark


ENDTIME=$(date +%s)
BUILD_TIME_SEC=$(($ENDTIME - $STARTTIME))

echo
echo '************************************************************************'
echo "Build took $BUILD_TIME_SEC seconds to complete..."
echo '************************************************************************'
echo


./scripts/bash/buildLog.sh DevHub $BUILD_TIME_SEC "$PROJECTNAME"

#Open Org
sfdx force:org:open -p /lightning/page/home -u $orgAlias
