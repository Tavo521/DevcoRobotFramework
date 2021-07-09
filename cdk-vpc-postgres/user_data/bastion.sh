#!/bin/bash -ex
sudo amazon-linux-extras install -y postgresql11
sudo yum -y install python-pip python-devel gcc postgresql-server postgresql-devel postgresql-contrib
sudo postgresql-setup initdb
sudo systemctl start postgresql
sudo sed -i 's,host    all             all             127.0.0.1/32            ident,host    all             all             0.0.0.0/0            md5,g' /var/lib/pgsql/data/pg_hba.conf
sudo sed -i 's,host    all             all             ::1/128                 ident,host    all             all             ::1/128                 md5,g' /var/lib/pgsql/data/pg_hba.conf
sudo systemctl restart postgresql
sudo systemctl enable postgresql
sudo echo "CREATE DATABASE devcopruebas; CREATE USER userdevco WITH PASSWORD 'admin'; ALTER ROLE userdevco SET client_encoding TO 'utf8'; ALTER ROLE userdevco SET default_transaction_isolation TO 'read committed'; ALTER ROLE userdevco SET timezone TO 'UTC'; GRANT ALL PRIVILEGES ON DATABASE devcopruebas TO userdevco;" >> /tmp/tempfile
sudo -u postgres /bin/psql -f /tmp/tempfile
sudo sed -i "s/#listen_addresses = 'localhost'/listen_addresses = '*'/g" /var/lib/pgsql/data/postgresql.conf
sudo sed -i 's/#port = 5432/port = 5432/g' /var/lib/pgsql/data/postgresql.conf 
sudo systemctl restart postgresql
