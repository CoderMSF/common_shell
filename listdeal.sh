#!/bin/bash
str=$(sed "s/\[//; s/\]//" keylist.txt)
MysqlLogin="mysql -uroot -pmysql"
OLD_IFS="$IFS"
IFS=","
array=($str)
IFS="$OLD_IFS"
for i in "${!array[@]}";do
	x=${array[i]}
	y=${x#\"}
	z=${y%\"}
	echo "${y%\"}"
	${MysqlLogin} -e "insert into test.redis_key(r_key) values('"${z}"');"
done


