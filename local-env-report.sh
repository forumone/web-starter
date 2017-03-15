#!/usr/bin/env bash
#
# Script to do basic checks of local developer environment.
# Reports files not owned by the user, how to fix,
# versions of pertinent software

# Bail if run as root / sudo
if [[ "$UID" == "0" ]]
then
  echo "Do not run me with sudo or as root!"
  exit 1
fi

# Bail if running inside a vm...
if [[ "$USER" == "vagrant" ]]
then
  echo "Do not run me inside vagrant - run me from your host environment."
  exit 1
fi

# Detect platform
platform="unknown"
if [[ "$OSTYPE" == "linux-gnu" ]]
then
  platform='linux'
elif [[ "$OSTYPE" == "darwin"* ]]
then
  platform='osx'
fi

if [[ "$platform" == "unknown" ]]
then
  echo "Platform not detected. Bailing out."
  exit 1
fi


# report files not owned by user in $HOME
echo -e "Checking home directory permissions. This might take a moment... \n"
PERMPROBS=$(find $HOME ! -user $UID 2>&1)
PERMLOG="/tmp/permission-problems.txt"
MYUSER=$UID
MYHOME=$HOME

echo -e "----------------"
if [[ "$PERMPROBS" == "" ]]
then
  echo -e "No permissions problems detected. \n"
else
  echo -e "Warning! Incorrect owner set on some files in your home directory. This can lead 
to permissions errors within vagrant. Problem files are logged in $PERMLOG.
Fix the issue with the following command:
  sudo chown -R $MYUSER $MYHOME \n"
  echo "$PERMPROBS" > "$PERMLOG"
fi

# Check version of vbox, vagrant, osx / linux
MYVBOX="unknown"
MYVAGRANT="unknown"
MYUNAME="unknown"

case $platform in
  osx)
    MYVBOX=$(VirtualBox --help |head -1)
    MYVAGRANT=$(vagrant --version)
    MYUNAME=$(uname -a ; sw_vers -productVersion)
    ;;
  linux)
    MYVBOX=$(VirtualBox --help |head -1)
    MYVAGRANT=$(vagrant --version)
    MYUNAME=$(uname -a ; cat /etc/lsb-release)
    ;;
esac

# SSH checks. Try SSHing to github to see if things are loaded correctly
SSHHEALTH="unknown"
SSHGITHUB="$( ssh -o ConnectTimeout=5 -o BatchMode=yes -o StrictHostKeyChecking=no git@github.com 2>&1 )"

if $(echo "$SSHGITHUB" | grep -q "successfully")
then
  SSHHEALTH="Successfully authenticated with Github. Public key is registered."
else
  SSHHEALTH="Github SSH Failure."
fi

# Check whether SSH agent identities loaded, exists, etc
SSHIDENTS=$(ssh-add -l)
if $(echo $SSHIDENTS | grep -q 'No identities')
then
  SSHHEALTH+=" No ssh-agent identities."
  # Check whether a key exists at all...
  if [[ -f $HOME/.ssh/id_rsa ]]
  then
    SSHHEALTH+=", key exists"
  else
    SSHHEALTH="No key found at ~/.ssh/id_rsa."
  fi
else
  SSHHEALTH+=" Identities registered with ssh-agent."
fi

# Print report
echo -e "----------------"
echo -e "SSH tests: $SSHHEALTH \n"
echo -e "Versions report"
echo -e "----------------"
echo "Virtualbox found as: $MYVBOX"
echo "Vagrant found as: $MYVAGRANT"
echo "Platform info: $MYUNAME"
