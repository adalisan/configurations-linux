#!/bin/env bash
export JAVA_HOME=/opt/jdk1.8.0_20-x86_64
export MY_JAVA=/opt/jdk1.8.0_20-x86_64
export JAVA_CPPFLAGS="-I/opt/jdk1.8.0_20-x86_64/include -I/opt/jdk1.8.0_20-x86_64/include/linux"
R_HOME=/home/sadali/rd/local/R-3.5.0 PATH=/home/sadali/rd/local/R-3.5.0:/home/sadali/local/anaconda/bin:$PATH \
 /home/sadali/local/anaconda/bin/rstudio  &
