sudo apt-get update
sudo apt-get install vsftpd
sudo cp /etc/vsftpd.conf /etc/vsftpd.conf.orig
sudo ufw enable
sudo ufw allow 20/tcp
sudo ufw allow 21/tcp
sudo ufw allow 40000:50000/tcp
sudo service vsftpd restart
sudo useradd -m ftpuser -s /usr/sbin/nologin
sudo passwd ftpuser
echo -ne "/usr/sbin/nologin" >> /etc/shells
echo -ne "write_enable=YES\nlocal_umask=022\nchroot_local_user=YES\nallow_writeable_chroot=YES\npasv_enable=Yes\npasv_min_port=40000\npasv_max_port=40100\nallow_anon_ssl=NO\nforce_local_data_ssl=YES\nforce_local_logins_ssl=YES\nssl_tlsv1=YES\nssl_sslv2=NO\nssl_sslv3=NO\nrequire_ssl_reuse=NO\nssl_ciphers=HIGH" >> /etc/vsftpd.conf
echo "ftpuser" | sudo tee -a /etc/vsftpd.userlist
sudo openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/vsftpd.pem -out /etc/ssl/private/vsftpd.pem
sed -i 's@rsa_cert_file=/etc/ssl/certs/ssl-cert-snakeoil.pem@rsa_cert_file=/etc/ssl/private/vsftpd.pem@g' /etc/vsftpd.conf
sed -i 's@rsa_private_key_file=/etc/ssl/private/ssl-cert-snakeoil.key@rsa_private_key_file=/etc/ssl/private/vsftpd.pem@g' /etc/vsftpd.conf
sed -i 's@ssl_enable=NO@ssl_enable=YES@g' /etc/vsftpd.conf
sudo systemctl restart vsftpd
sudo apt-get install nginx
sudo ufw allow 'Nginx HTTP'
mount --bind /var/www/html /home/ftpuser/
sudo chown -R ftpuser /var/www/html
