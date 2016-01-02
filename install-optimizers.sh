#!/bin/bash

wget https://github.com/tjko/jpegoptim/archive/RELEASE.1.4.1.tar.gz -O jpegoptim-1.4.1.tar.gz
tar xfvz jpegoptim-1.4.1.tar.gz
cd jpegoptim-RELEASE.1.4.1/
./configure && make && make install
cd ..
