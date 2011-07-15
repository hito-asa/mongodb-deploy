#!/bin/sh

. /home/hitoshi/work/mongodb/deploy/servers

CONF_NORMAL=normal.conf
CONF_SHARD=shard.conf
CONF_CONFIG=config.conf
CONF_MONGOS=mongos.conf

for SERVER in $NORMAL_SERVERS
do
  atssh -t asai@${SERVER} "sudo service mongod restart_normal" 
done

for SERVER in $SHARD_SERVERS
do
  atssh -t asai@${SERVER} "sudo service mongod restart_shard" 
done

for SERVER in $CONFIG_SERVERS
do
  atssh -t asai@${SERVER} "sudo service mongod restart_config" 
done

for SERVER in $MONGOS_SERVERS
do
  atssh -t asai@${SERVER} "sudo service mongod restart_mongos" 
done

