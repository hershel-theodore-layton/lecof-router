#!/bin/sh
rm vendor/autoload.php vendor/composer/*.php

# Processes the `requires:4.128` comments in .hhconfig.

HHVM_VERSION_MAJOR=`hhvm --php -r "echo HHVM_VERSION_MAJOR;"`
if [ "$HHVM_VERSION_MAJOR" -ne "4" ]; then exit; fi

# Deletes any line from .hhconfig that contains `requires:<hhvm_version>`
# if <hhvm_version> is greater than the current hhvm version.
# Does not support anything outside of the hhvm 4.x range.

HHVM_VERSION_MINOR=`hhvm --php -r "echo HHVM_VERSION_MINOR;"`
NEXT=$(($HHVM_VERSION_MINOR + 1))

# On hhvm 4.102, this would create the pattern:
# "requires:4.103|requires:4.104|...|requires:4.172"
FUTURE_VERSIONS=`for i in $(seq $NEXT 172); do echo "requires:4.$i"; done`
FUTURE_VERSIONS=`echo $FUTURE_VERSIONS | sed "s/ /|/g"`

sed -i -E /$FUTURE_VERSIONS/d .hhconfig
