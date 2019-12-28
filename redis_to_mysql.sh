#!/bin/bash

MysqlLogin="mysql -uroot -pmysql"
all_key=$(redis-cli -h 127.0.0.1 -p 6379 -a xxx -n 0 keys "*")
IFS=$'\n';
arrIN=($all_key);
unset IFS;

for key in "${arrIN[@]}";do
	value=$(redis-cli -h 127.0.0.1 -p 6379 -a xxx -n 0 get ${key})
	${MysqlLogin} -e "insert into test.redis_record(r_key,r_value) values('${key}','${value}');"
done



#CREATE TABLE `redis_record` (
#  `id` int(8) NOT NULL AUTO_INCREMENT,
#  `r_key` text NOT NULL,
#  `r_value` text NOT NULL,
#  PRIMARY KEY (`id`)
#) ENGINE=InnoDB AUTO_INCREMENT=707 DEFAULT CHARSET=utf8
