# seafile-server-installer
These installer scripts offer a quick and easy way to set up the [Seafile Server Community Edition](http://seafile.com/en/home/), using MariaDB, Memcached and NGINX as a Reverse Proxy in under 5 minutes. We're also adding an init script that starts Seafile when booting the server.

### What's it for?
Installing the [Seafile Server Community Edition](http://seafile.com/en/home/) on Debian or Ubuntu (64bit) in a standard and more secure manner then the out of the box setup scripts offer. Instead of SQLite we're using MariaDB and instead of Gunicorn we're using NGINX.


### Why?
There are just too many ways to misconfigure a manual Seafile server installation. We've notices that many people don't realize that the default installation is unsecure. In other cases people get stuck during the installation or forget a step like changing "FILE_SERVER_ROOT" or use IP addresses instead of resolvable DNS names.
This script is derived from our [reference installation for Seafile Server  Professional](https://wiki.seafile.com.de/doku.php?id=debian_7_wheezy_64bit). It helps us to standardize the installation procedure and helps with identifying setup errors more easily.


### How long does the installation take?
The installation time will vary depending on your internet connection speed and hardware. On our SSD-based servers we were able to install a production-ready Seafile server in roughly 5 minutes.


### Operating system
It's meant to run on a [Debian Jessie minimal installation](https://www.youtube.com/watch?v=BCwz9oSSt8g) or [Ubuntu Trusty minimal installation](https://www.youtube.com/watch?v=qdCbWOHwBL4). No desktop environment or other weird stuff like hosting panels (Plesk, ISPConfig, etc.)...


### Which components are used?
1. [Newest Seafile Server Community Edition](https://download.seafile.com.de/)
2. [NGINX](http://nginx.org/packages/mainline/debian/)
3. MariaDB
4. Memcached


### Which special features are enabled by default?
1. HTTPS-Proxy on port 443
2. Forced redirect from unenrypted HTTP port 80 to encrypted HTTPS port 443
2. Seahub with FastCGI
3. [SeafDAV](http://manual.seafile.com/extension/webdav.html) with FastCGI
4. Memcached
5. Seafile autostart


### What does the installer do?
1. Update and upgrade Debian
2. Install NGINX from http://nginx.org/packages/mainline/debian/
3. Create Seafile init script and add it to systemd startup
4. Create unprivilieged system user "seafile" with home directory "/opt/seafile"
5. Download and extract latest Seafile server sources from https://download.seafile.com.de/seafile-server_latest_x86-64.tar.gz
6. Create "seafile" database user and Seafile databases (DB-Credentials in ~/.my.cnf)
7. Initialize various Seafile files
8. Enable SeafDAV, Memcached and MariaDB
9. Setup Seafile to listen to IP (hostname -i) instead of DNS (*Switch this to DNS before live deployment*)
10. Create Seafile admin with individual password
11. Install "seafile-server-change-address" script
12. Display setup infos and what to do next.


### How do I run it?

For **Debian Wheezy (64bit)** run the following lines as root:
<pre>
cd /tmp
wget --no-check-certificate https://raw.githubusercontent.com/SeafileDE/seafile-server-installer/master/seafile-ce_debian-wheezy-amd64
time bash seafile-ce_debian-wheezy-amd64
</pre>

For **Debian Jessie (32bit)** run the following lines as root:
<pre>
cd /tmp
wget --no-check-certificate https://raw.githubusercontent.com/SeafileDE/seafile-server-installer/master/seafile-ce_debian-jessie-i386
time bash seafile-ce_debian-jessie-i386
</pre>

For **Debian Jessie (64bit)** run the following lines as root:
<pre>
cd /tmp
wget --no-check-certificate https://raw.githubusercontent.com/SeafileDE/seafile-server-installer/master/seafile-ce_debian-jessie-amd64
time bash seafile-ce_debian-jessie-amd64
</pre>

For **Ubuntu Trusty (64bit)** run the following lines as root:
<pre>
cd /tmp
wget --no-check-certificate https://raw.githubusercontent.com/SeafileDE/seafile-server-installer/master/seafile-server-community_ubuntu-trusty-amd64
time bash seafile-server-community_ubuntu-trusty-amd64
</pre>

BETA: For **Uberspace** run the following line as user:
<pre>
wget https://raw.githubusercontent.com/SeafileDE/seafile-server-installer/master/seafile-ce_uberspace 
time bash seafile-ce_uberspace
</pre>
 
 
### Caution!
Never run the script on a production server. It's more or less a one trick pony and can seriously damage production systems. So run it only one time and delete it afterwards. 

As a precaution I have added a few simple checks to abort installation if the unprivileged Seafile user or Seafile installation directory pre-exist:

1. Check if you're running this script as root. If not, abort.
2. Check if the user "seafile" exists. If yes, abort.
3. Check if the directory "/opt/seafile" exists. If yes, abort.


### How do I update Seafile?
You will have to handle Seafile updates/upgrades manually after the initial installation. Consult http://manual.seafile.com/deploy/upgrade.html on how to upgrade Seafile.

BTW Ideas on how to automate upgrades are very welcome!


### What do I have to do after the installer has finished?
1. Delete installer script. You wont need it anymore and might even seriously damage your system if you ran it again.
2. Follow the suggested steps at the end of the installation to finalize your Seafile server installation. As a bare minimum you most definitely will want to change the listening IP to a valid DNS name by running "seafile-server-change-address" as root...
3. Install a firewall. TCP-Port 443 needs to be accessible. Optionally you can open TCP-Port 80 which redirects to HTTPS


### License
Copyright 2015, Alexander Jackson <alexander.jackson@seafile.de>

This program is free software: you can redistribute it and/or modify
it under the terms of the [GNU Affero General Public License](http://www.gnu.org/licenses/agpl-3.0.html) as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU Affero General Public License for more details.


### Where can I submit bugs or add suggestions?
Contact me at alexander.jackson@seafile.de or create an [Issue](https://github.com/SeafileDE/seafile-server-community_debian-jessie-amd64/issues/new) on Github. Or just reply in the [corresponding forum thread](https://forum.seafile-server.org/t/howto-seafile-server-community-edition-on-debian-jessie-amd64/1464).
