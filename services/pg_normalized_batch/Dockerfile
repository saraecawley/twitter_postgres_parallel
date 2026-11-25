FROM postgis/postgis:13-3.5

RUN rm -f /etc/apt/sources.list.d/pgdg.list && apt-get update && apt-get install -y \
    less \
    make

WORKDIR /tmp/db

RUN mkdir /data && chown postgres /data

# copy over the pagila database;
# we rename the files so that they get executed in the correct order
COPY schema.sql /docker-entrypoint-initdb.d/01.sql
