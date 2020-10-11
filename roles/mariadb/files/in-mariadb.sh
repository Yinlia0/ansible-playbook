#!/bin/bash
datadir="/data/mariadb"
mariadbconf="my.cnf"
mariadbtar="mariadb-10.4.12-linux-systemd-x86_64.tar.gz"
mariadbc="mariadb-10.4.12-linux-systemd-x86_64"

yum -y install libaio.so.1 libaio-devel
groupadd mysql
useradd -g mysql mysql
mkdir -p $datadir && mkdir $datadir/{log,log-bin,data}

cd /opt/package
tar zxf $mariadbtar && mv $mariadbc mariadb
mv mariadb /usr/local/
cp $mariadbconf /etc && cp mysql.sh /etc/profile.d/
cd /data && chmod 766 mariadb && chown -R mysql.mysql mariadb

/usr/local/mariadb/scripts/mysql_install_db --user=mysql

cp mariadb.service /usr/lib/systemd/system
# 包下载地址
# https://mariadb.com/kb/en/mariadb-10412-release-notes/
# 开机自启动mariadb
# systemctl enable mariadb
# 通过mysqladmin 更改密码，需要先更改认证模式
# mysqladmin -uroot -p password 6spEvePSWP5DpUzh
# 改认证模式
# update mysql.user set plugin = 'mysql_native_password' where user = 'root';
# 然后再
# set password = password('123456')

systemctl daemon-load
bash && source /etc/profile
