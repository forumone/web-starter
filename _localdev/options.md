---
title: Hiera Options
---

Hiera allows settings to be changed for a variety of services within the
virtual machine. These changes may be made to any of the YAML files that
contain configuration, though some configuration options may exist in
the host or platform configuration that would need to be overridden in
the host configuration.

<span id="general"></span>General
---------------------------------

<table>
<colgroup>
<col width="33%" />
<col width="33%" />
<col width="33%" />
</colgroup>
<thead>
<tr class="header">
<th align="left">Variable</th>
<th align="left">Description</th>
<th align="left">Default</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td align="left">forumone::ports</td>
<td align="left">Ports that are opened in the firewall</td>
<td align="left"><ul>
<li>80</li>
<li>443</li>
<li>1080</li>
<li>8080</li>
<li>8081</li>
<li>18983</li>
<li>8983</li>
<li>3306</li>
<li>13306</li>
</ul></td>
</tr>
<tr class="even">
<td align="left">classes</td>
<td align="left">Puppet classes applied to the VM; used to add additional classes from Puppetforge, etc.</td>
<td align="left"><ul>
<li>forumone</li>
<li>forumone::ssh_config</li>
</ul></td>
</tr>
</tbody>
</table>

<span id="php"></span>PHP
-------------------------

<table>
<colgroup>
<col width="33%" />
<col width="33%" />
<col width="33%" />
</colgroup>
<thead>
<tr class="header">
<th align="left">Variable</th>
<th align="left">Description</th>
<th align="left">Default</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td align="left">forumone::php::prefix</td>
<td align="left">PHP version installed; note this is the package name prefix to use, e.g. [prefix]-common</td>
<td align="left">php54</td>
</tr>
<tr class="even">
<td align="left">forumone::php::modules</td>
<td align="left">PHP modules installed</td>
<td align="left"></td>
</tr>
</tbody>
</table>

<span id="drush"></span>Drush
-----------------------------

| Variable                 | Description                | Default |
|--------------------------|----------------------------|---------|
| forumone::drush::version | Version of Drush installed | 7.x-5.9 |

<span id="database"></span>Database
-----------------------------------

<table>
<colgroup>
<col width="33%" />
<col width="33%" />
<col width="33%" />
</colgroup>
<thead>
<tr class="header">
<th align="left">Variable</th>
<th align="left">Description</th>
<th align="left">Default</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td align="left">forumone::database::server</td>
<td align="left">Whether the database component is installled as a server</td>
<td align="left">true</td>
</tr>
<tr class="even">
<td align="left">forumone::database::version</td>
<td align="left">Version of Percona installed</td>
<td align="left">5.5</td>
</tr>
<tr class="odd">
<td align="left">forumone::database::manage_repo</td>
<td align="left">Whether the Percona repository configuration is controlled by Puppet</td>
<td align="left">true</td>
</tr>
<tr class="even">
<td align="left">forumone::database::configuration</td>
<td align="left">Configuration included in my.cnf</td>
<td align="left"><ul>
<li>mysqld/log_bin: absent</li>
</ul></td>
</tr>
</tbody>
</table>

<span id="webserver"></span>Web Server
--------------------------------------

| Variable                       | Description                                 | Default |
|--------------------------------|---------------------------------------------|---------|
| forumone::webserver::webserver | Which web server installed, apache or nginx | nginx   |
| forumone::webserver::port      | Port that the web server is listening on    | 8080    |

### <span id="apache"></span>Apache

| Variable                                         | Description                          | Default |
|--------------------------------------------------|--------------------------------------|---------|
| forumone::webserver::apache\_startservers        | Number of servers to start           | 8       |
| forumone::webserver::apache\_minspareservers     | Minimum number of spare servers      | 5       |
| forumone::webserver::apache\_maxspareservers     | Maximum number of spare servers      | 16      |
| forumone::webserver::apache\_maxclients          | Maximum number of clients            | 16      |
| forumone::webserver::apache\_maxrequestsperchild | Maximum number of requests per child | 200     |

### <span id="nginx"></span>Nginx

<table>
<colgroup>
<col width="33%" />
<col width="33%" />
<col width="33%" />
</colgroup>
<thead>
<tr class="header">
<th align="left">Variable</th>
<th align="left">Description</th>
<th align="left">Default</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td align="left">forumone::webserver::nginx_conf</td>
<td align="left">Nginx configuration</td>
<td align="left"><ul>
<li>client_max_body_size 200m</li>
<li>client_body_buffer_size 2m</li>
<li>set_real_ip_from 127.0.0.1</li>
<li>real_ip_header X-Forwarded-For</li>
</ul></td>
</tr>
<tr class="even">
<td align="left">forumone::webserver::nginx_worker_processes</td>
<td align="left">Number of worker processes</td>
<td align="left">1</td>
</tr>
<tr class="odd">
<td align="left">forumone::webserver::php_fpm_listen</td>
<td align="left">Path to PHP-FPM socket</td>
<td align="left">/var/run/php-fpm.sock</td>
</tr>
</tbody>
</table>
