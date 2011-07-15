#!/bin/sh

. /home/hitoshi/work/mongodb/deploy/servers

CONF_NORMAL=normal.conf
CONF_SHARD=shard.conf
CONF_CONFIG=config.conf
CONF_MONGOS=mongos.conf
KEY_FILE=keyfile
DAEMON_FILE=mongod

R_CONF_DIR=/usr/local/mongodb/conf
R_KEY_FILE=/usr/local/mongodb/conf/keyfile
R_DAEMON_FILE=/etc/init.d/mongod

for SERVER in $SERVERS
do
  echo $SERVER
  atscp $CONF_NORMAL asai@${SERVER}:/var/tmp/
  atscp $CONF_SHARD asai@${SERVER}:/var/tmp/
  atscp $CONF_CONFIG asai@${SERVER}:/var/tmp/
  atscp $CONF_MONGOS asai@${SERVER}:/var/tmp/
  atscp $KEY_FILE asai@${SERVER}:/var/tmp/
  atscp $DAEMON_FILE asai@${SERVER}:/var/tmp/
  atssh -t asai@${SERVER} " 
    sudo mkdir -p /usr/local/mongodb/data/normal;
    sudo mkdir -p /usr/local/mongodb/data/shard;
    sudo mkdir -p /usr/local/mongodb/data/config;
    sudo cp /var/tmp/${CONF_NORMAL} ${R_CONF_DIR}/${CONF_NORMAL};
    sudo cp /var/tmp/${CONF_SHARD} ${R_CONF_DIR}/${CONF_SHARD};
    sudo cp /var/tmp/${CONF_CONFIG} ${R_CONF_DIR}/${CONF_CONFIG};
    sudo cp /var/tmp/${CONF_MONGOS} ${R_CONF_DIR}/${CONF_MONGOS};
    sudo cp /var/tmp/${KEY_FILE} ${R_KEY_FILE};
    sudo cp /var/tmp/${DAEMON_FILE} ${R_DAEMON_FILE};
    sudo chmod 600 ${R_KEY_FILE};
    sudo chown root:root ${R_DAEMON_FILE};
    sudo chmod 755 ${R_DAEMON_FILE};
    sleep 1;
  " 
done

