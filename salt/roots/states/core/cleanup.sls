# Miscellanous rules to clean up after ourselves, etc

make-logs-viewable:
  cmd.run:
    - name: chmod ugo+rx /var/log/{nginx,php-fpm,vagrant}
