#!/bin/bash
# Title:		F1 WP Import DB
# Description:	This script will connect to the WordPress DEV|STAGE|LIVE environment, export an .sql file 
#				copy of it's database and import that one into the project's Vagrant 
#				environment. A time saver tool for development.
# Author:		Forum One
# Author URI:	https://forumone.com
# Version:		1.1.0
# Usage:		- 1) Adjust values within the REMOTE CONFIG section below.
#				- 2) From the Vagrant project <root>, run ./bin/wp_import_db.sh


# ======================================== REMOTE CONFIG ======================================== #
# Adjust below variable values as needed.
# {DEV|STAGE|LIVE} Details:
USER_AT_HOST="user@webhost.com"							# User and host where to connect via SSH.
WEB_ROOT="/var/www/vhosts/project_name.dev/public/"		# WordPress remote environment web root.
# ======================================== END REMOTE CONFIG ======================================== #


# ======================================== COMMON CONFIG ======================================== #
SCRIPT_BASE_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
VM_WEB_ROOT=$SCRIPT_BASE_DIR"/../public/"

# Vagrant VM Details:
VAGRANT_USER_AT_HOST="vagrant@127.0.0.1"
VAGRANT_PORT=2222
VAGRANT_SSH_ID_FILE=$SCRIPT_BASE_DIR"/../.vagrant/machines/default/virtualbox/private_key"
VAGRANT_VM_WEB_ROOT="/vagrant/public/"
# ======================================== END COMMON CONFIG ======================================== #



# ======================================== FUNCTIONS ======================================== #
# Processes the database migration from the remote environment to the local Vagrant VM.
function f1_run {

	# REMOTE ENV WORKFLOW:
	# 1- Exports the DB on remote environment.
	echo ">>> Connecting to $USER_AT_HOST:$WEB_ROOT environment and exporting the database..." &&
	SSH_OUTPUT_RESULT=$( ssh $USER_AT_HOST "cd $WEB_ROOT &&
	wp db export &&
	exit"
	) &&
	# 2- Extract the .sql file name from $SSH_OUTPUT_RESULT.
	SQL_FILE_NAME=$( echo $SSH_OUTPUT_RESULT | awk -F[\'\'] '{print $2}' ) &&
	# 3- SCP download to the local Vagrant VM the .sql file.
	echo ">>> Downloading $SQL_FILE_NAME from $USER_AT_HOST:$WEB_ROOT environment..." &&
	scp $USER_AT_HOST":"$WEB_ROOT$SQL_FILE_NAME $VM_WEB_ROOT &&
	# 4- Removes the .sql file from remote environment.
	echo ">>> Removing $SQL_FILE_NAME from $USER_AT_HOST:$WEB_ROOT environment..." &&
	ssh $USER_AT_HOST "cd $WEB_ROOT &&
	rm $SQL_FILE_NAME &&
	exit" &&


	# VAGRANT VM WORKFLOW:
	# 5- Removes all existing tables from the Vagrant VM environment database and imports the .sql file copy from remote environment.
	echo ">>> Removing existing tables from the Vagrant VM env database, importing $SQL_FILE_NAME contents, and removing $SQL_FILE_NAME file afterwards..." &&
	ssh $VAGRANT_USER_AT_HOST -p $VAGRANT_PORT -i $VAGRANT_SSH_ID_FILE "cd $VAGRANT_VM_WEB_ROOT &&
	wp db reset --yes &&
	wp db import $SQL_FILE_NAME &&
	rm $SQL_FILE_NAME &&
	exit" &&

	echo "--- THE END ---"

}

# Prints an OK message with some ASCII art.
function f1_norun {
	echo ">>> Ok next time..."
	echo "	________________________¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶________
	____________________¶¶¶___________________¶¶¶¶_____
	________________¶¶¶_________________________¶¶¶¶___
	______________¶¶______________________________¶¶¶__
	___________¶¶¶_________________________________¶¶¶_
	_________¶¶_____________________________________¶¶¶
	________¶¶_________¶¶¶¶¶___________¶¶¶¶¶_________¶¶
	______¶¶__________¶¶¶¶¶¶__________¶¶¶¶¶¶_________¶¶
	_____¶¶___________¶¶¶¶____________¶¶¶¶___________¶¶
	____¶¶___________________________________________¶¶
	___¶¶___________________________________________¶¶_
	__¶¶____________________¶¶¶¶____________________¶¶_
	_¶¶_______________¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶______________¶¶__
	_¶¶____________¶¶¶¶___________¶¶¶¶¶___________¶¶___
	¶¶¶_________¶¶¶__________________¶¶__________¶¶____
	¶¶_________¶______________________¶¶________¶¶_____
	¶¶¶______¶________________________¶¶_______¶¶______
	¶¶¶_____¶_________________________¶¶_____¶¶________
	_¶¶¶___________________________________¶¶__________
	__¶¶¶________________________________¶¶____________
	___¶¶¶____________________________¶¶_______________
	____¶¶¶¶______________________¶¶¶__________________
	_______¶¶¶¶¶_____________¶¶¶¶¶_____________________"
}
# ======================================== END FUNCTIONS ======================================== #



# ======================================== APP INVOKE ======================================== #
# EDUCATION, ASK FIRST
echo "Replace the local Vagrant VM database with a copy from remote env DB?: (Y|N)"
read inPut
case $inPut in
	"Y") f1_run
;;
"N") f1_norun
;;
esac
exit








