#!/bin/bash
apt-get install build-essential checkinstall -y
apt-get install libreadline-gplv2-dev libncursesw5-dev libssl-dev libsqlite3-dev tk-dev libgdbm-dev libc6-dev libbz2-dev -y
wget https://www.python.org/ftp/python/3.7.6/Python-3.7.6.tgz
tar -zxvf Python-3.7.6.tgz -C /usr/local/
cd /usr/local/Python-3.7.6/
./configure --enable-optimizations
make altinstall
if [ $? -eq 0 ]; then
    echo "python3.7.6 install successed"
else
    apt-get install --reinstall zlibc zlib1g zlib1g-dev -y
    apt-get install libffi-dev libssl-dev -y
    make altinstall
fi

curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
python3.7 get-pip.py


