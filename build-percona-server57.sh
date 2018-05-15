#!/bin/bash
# Build Percona Server 5.7 from source code

yum -y install tbb tbb-devel cmake boost boost-devel gcc gcc-c++ git ncurses-devel readline-devel curl-devel zlib-devel wget
cd /usr/local/src
wget https://www.percona.com/downloads/Percona-Server-LATEST/Percona-Server-5.7.21-21/source/tarball/percona-server-5.7.21-21.tar.gz
mkdir /usr/local/boost
cmake . -DCMAKE_BUILD_TYPE=RelWithDebInfo -DBUILD_CONFIG=mysql_release -DFEATURE_SET=community -DWITH_EMBEDDED_SERVER=OFF -DDEFAULT_CHARSET=utf8 -DDEFAULT_COLLATION=utf8_general_ci -DDOWNLOAD_BOOST=1 -DWITH_BOOST=/usr/local/boost -DWITH_SYSTEMD=1
make
make install

useradd -d /dev/null -s /sbin/nologin -M mysql

wget -O /etc/my.cnf https://raw.githubusercontent.com/vynt-kenshiro/build-percona-server57/master/my.cnf
mkdir /var/lib/mysql/
chown mysql:mysql /var/lib/mysql
wget -O /usr/lib/systemd/system/mysqld.service https://raw.githubusercontent.com/vynt-kenshiro/build-percona-server57/master/mysqld.service
