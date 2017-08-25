# Nginx-FTP
SSH script to install and configure Nginx and FTP for basic HTTP web service.

Created for Ubuntu 16.04.3 x64 and run on Digital Ocean Droplets

This script can be run to automatically to install and configure both VSFTPD and Nginx. You will be prompted to provide a password for user 'ftpuser'.

The ftpuser will have FTP (TLS-enabled) access to /home/ftpuser directory that is binded to the root directory (/var/www/html) of Nginx.

