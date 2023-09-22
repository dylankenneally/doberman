#!/bin/bash

# To be found by Xcode, provisioning profiles need to be stored in ~/Library/MobileDevice/Provisioning Profiles/ and *must* be
# named using their UUID, otherwise they are immediately removed from the filesystem if moved there.

# Run this script from the directory containing the .mobileprovision files you have downloaded from developer.apple.com
# to install them to the correct location.

# This script simply looks for the UUID field value in each mobileprovision plist file (so you can give your downloaded files meaningful name),
# and copies it to the desired directory with the appropriate name.

echo "Installing mobile provisioning profiles to ~/Library/MobileDevice/Provisioning Profiles/"

for PROVISION in `ls ./*.mobileprovision`
do
  echo "Processing $PROVISION"
  UUID=`/usr/libexec/PlistBuddy -c 'Print :UUID' /dev/stdin <<< $(security cms -D -i ./$PROVISION)`
  NAME=`/usr/libexec/PlistBuddy -c 'Print :Name' /dev/stdin <<< $(security cms -D -i ./$PROVISION)`
  cp "./$PROVISION" "$HOME/Library/MobileDevice/Provisioning Profiles/$UUID.mobileprovision"

  echo "Installed $NAME as $UUID.mobileprovision"
done
