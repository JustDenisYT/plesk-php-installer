#/bin/bash


# Variables:
 
URL=$1
NAME=$2

# Install devel-libs, if not installed
yum install libxml2-devel openssl-devel bzip2-devel curl-devel libpng-devel libjpeg-devel libtiff-devel libxslt-devel aspell-devel net-snmp-devel readline-devel unixODBC-devel libicu-devel libc-client-devel freetype-devel libXpm-devel libvpx-devel enchant-devel gmp-devel db4-devel openldap-devel postgresql-devel sqlite-devel aspell-devel pcre-devel t1lib-devel.x86_64 libmcrypt-devel.x86_64 libtidy libtidy-devel mysql-devel
 
#Getting PHP
wget $1 -O /usr/local/src/$2.tar.gz
 
# Unpacking
tar xzvf /usr/local/src/$2.tar.gz -C /usr/local/src/
 
# Move to unpacked folder
cd /usr/local/src/$2/
 
# Configure PHP build script
./configure --with-libdir=lib64 --cache-file=./config.cache --prefix=/usr/local/$2 --with-config-file-path=/usr/local/$2/etc --disable-debug --with-pic --disable-rpath  --with-bz2 --with-curl --with-freetype-dir=/usr/local/$2 --with-png-dir=/usr/local/$2 --enable-gd-native-ttf --without-gdbm --with-gettext --with-gmp --with-iconv --with-jpeg-dir=/usr/local/$2 --with-openssl --with-pspell --with-pcre-regex --with-zlib --enable-exif --enable-ftp --enable-sockets --enable-sysvsem --enable-sysvshm --enable-sysvmsg --enable-wddx --with-kerberos --with-unixODBC=/usr --enable-shmop --enable-calendar --with-libxml-dir=/usr/local/$2 --enable-pcntl --with-imap --with-imap-ssl --enable-mbstring --enable-mbregex --with-gd --enable-bcmath --with-xmlrpc --with-ldap --with-ldap-sasl --with-mysql=/usr --with-mysqli --with-snmp --enable-soap --with-xsl --enable-xmlreader --enable-xmlwriter --enable-pdo --with-pdo-mysql --with-pear=/usr/local/$2/pear --with-mcrypt --without-pdo-sqlite --with-config-file-scan-dir=/usr/local/$2/php.d --without-sqlite3 --enable-intl
 
# Build
make
 
# Install
make install
 
# Create a default php.ini
cp -a /etc/php.ini /usr/local/$2/etc/php.ini
# Set the timezone we grabbed earlier
sed -i "s#;date.timezone =#date.timezone = $timezone#" /usr/local/$2/etc/php.ini
 
# Register new PHP version in Plesk
/usr/local/psa/bin/php_handler --add -displayname "$2" -path /usr/local/$2/bin/php-cgi -phpini /usr/local/$2/etc/php.ini -type fastcgi -id "fastcgi-5i"
