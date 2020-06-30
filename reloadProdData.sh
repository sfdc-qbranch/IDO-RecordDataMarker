#!/bin/bash
read -p 'Scratch default username: ' scratchUser
read -p 'Test or Prod [t/p]?: ' targetInstance

DEFAULTPWD=$DX_DEF_PWD

# Encrypt the default password
ENCRYPT_RESULT=$(java -cp bin/dataloader/dataloader.jar com.salesforce.dataloader.security.EncryptionUtil -e $DEFAULTPWD data/prod/config/login.key | sed -n '1!p')

#Remove any whitespace
ENCRYPT_RESULT="$(echo -e "${ENCRYPT_RESULT}" | sed -e 's/^[[:space:]]*//')"
echo 'using encrypted PWD of '$ENCRYPT_RESULT''

SCRATCH_PWD=$ENCRYPT_RESULT

if [ "$targetInstance" == 't' ]; then
  ./scripts/bash/loadProdData.sh $scratchUser $SCRATCH_PWD https://test.salesforce.com
fi

if [ "$targetInstance" == 'p' ]; then
  ./scripts/bash/loadProdData.sh $scratchUser $SCRATCH_PWD https://login.salesforce.com
fi
