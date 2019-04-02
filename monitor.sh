#!/bin/sh

#######################################################
## 监控脚本，参数说明，需要输入三个参数：第一个参数 采集间隔，单位：秒，
## 第二个参数 采集次数，第三个 本次采集指标标志。
#######################################################

pid=`jps | grep -vi jps | awk '{print $1}'`

if [ ! -d ${HOME}/monitorlog/ ]; then

        mkdir -p ${HOME}/monitorlog/

fi

home=`echo ${HOME}/monitorlog/`

if [ $# == 3 ]; then

        vmstat -a $1 $2 > ${home}wdx-vmstat-${3}.log &

        iostat -dxk $1 $2 > ${home}wdx-iostat-${3}.log &

        sar -n DEV $1 $2 > ${home}net-${3}.log &

        sar -n EDEV $1 $2 > ${home}net_error-${3}.log &

        top -b -d $1 -n $2|grep -P '(load|Cpu)' > ${home}load-${3}.log  &

        jstat -gcutil $pid ${1}s $2 > ${home}wdx-gc-${3}.log &

else

        echo 'input param error'

fi
