yum install python-jinja2-26 --enablerepo=epel -y

echo 'export PYTHONPATH=/usr/lib/python2.6/site-packages/Jinja2-2.6-py2.6.egg:$PYTHONPATH' > /etc/profile.d/salt-jinja.sh
chmod 755 /etc/profile.d/salt-jinja.sh
