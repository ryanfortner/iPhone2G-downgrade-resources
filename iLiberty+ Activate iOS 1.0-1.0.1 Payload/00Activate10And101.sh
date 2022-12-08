#!/bin/sh
#
# Id:      com.zjlotto.iLiberty.Activate10And101
# Name:    Activate 1.0 - 1.0.1
# Author:  Dylan Cooke
# Version: 1.0
# Script:  http://thebwain.blogspot.com/downloads/00Activate10And101.sh
# Pack:    http://thebwain.blogspot.com/downloads/Activate10And101.zip
# URL:     http://thebwain.blogspot.com/
# Desc:    This payload activates iPhone firmwares 1.0 and 1.0.1
#          The lockdownd is patched (fake factory activation).
#          This payload should work on iPhone and iPod Touch.
#

. $FUNCTIONS

echo "Activate 1.0 and 1.0.1"
echo "----------------------"

PACK=Activate10And101

GetFirmwareVersion fw_ver
LOCKDOWND=UNKNOWN
if [ ${fw_ver} = "1.0" ]; then
	LOCKDOWND=Lockdownd10
elif [ ${fw_ver} = "1.0.1" ]; then
	LOCKDOWND=Lockdownd101
else
	echo "Wrong firmware version: ${fw_ver}"
	echo "Operation aborted"
	sleep 5
	exit 1
fi

run unzip -o ${PL_DIR}/${PACK}.zip -d ${PL_DIR}
if [ $? -ne 0 ]; then
	echo "Failed, abort in 10 seconds"
	sleep 10
	exit 1
fi
rm -f ${PL_DIR}/${PACK}.zip

echo "Activating firmware ${fw_ver}..."
cd ${PL_DIR}/${PACK}
run unzip -o ${LOCKDOWND}.zip -d /usr/libexec/
if [ $? -ne 0 ]; then
	echo "Failed, abort in 10 seconds"
	sleep 10
	exit 1
else
	echo "Completed"
fi

echo "Fixing permission..."
chmod 555 /usr/libexec/lockdownd
cd ${PL_DIR} && rm -rf ${PL_DIR}/${PACK}

echo "Done"

