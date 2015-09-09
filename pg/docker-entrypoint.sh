#!/bin/sh

chown -R postgres "$PGDATA"
gosu postgres initdb
gosu postgres echo "host all  all    0.0.0.0/0  md5" >> "$PGDATA"/pg_hba.conf
gosu postgres echo "listen_addresses='*'" >> "$PGDATA"/postgresql.conf
echo "CREATE USER docker WITH SUPERUSER PASSWORD 'docker';" | gosu postgres postgres --single -jE
echo

exec gosu postgres "$@"
