yum install python-jinja2-26 git --enablerepo=epel -y

echo 'export PYTHONPATH=/usr/lib/python2.6/site-packages/Jinja2-2.6-py2.6.egg:$PYTHONPATH' > /etc/profile.d/salt-jinja.sh
chmod 755 /etc/profile.d/salt-jinja.sh

# Pre-fetch git formulas
cd /srv/salt/formulas
for repo in $(grep github.com /vagrant/salt/minion |awk '{print $2}' |sed -e 's/:$//')
do
  repodir=$(echo $repo | sed -e 's/.*forumone\///' |sed -e 's/\.git$//')
  echo $repodir
  if [[ ! -d $repodir ]]
  then
    git fetch $repo || echo "Already exists."
  else
    cd $repodir
    git pull
    cd ..
  fi
done
