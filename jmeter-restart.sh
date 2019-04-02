#!/bin/sh

num=`ps -ef|grep apache-jmeter-5.0/bin/jmeter | grep -v grep | wc -l`

dotype=$1
script_name=$2
slave=$3
date=`date +%Y-%m-%d_%H:%M:%S`
if [ -d ./script ];then
        echo ''
else
        mkdir ./script
fi

if [ -d ./result ];then
        echo ''
else
        mkdir ./result
fi
if [ -d ./output ];then
        echo ''
else
        mkdir ./output
fi

start(){
        if [ $num -gt 0 ];then
                echo "jmeter is already in processing,please try it later"
        else
        nohup ./apache-jmeter-5.0/bin/jmeter -n -t ./script/"$script_name" -l ./result/"$script_name""$date".jtl -R 192.168.6.59:1099,192.168.6.61:1099 >./output/"$script_name""$date".log 2>&1 &
        echo 'start success'
        fi
}

stop(){
        if [ $num -gt 0 ];then
                ./apache-jmeter-5.0/bin/shutdown.sh
                sleep 5s
                num_new=`ps -ef|grep apache-jmeter-5.0/bin/jmeter | grep -v grep | wc -l`
                if [ $num_new -eq 0 ];then
                        echo 'stop success'
                else
                        echo 'stop failed'
                fi
        else
                echo 'jmeter is already stopped'
        fi
}

if  [[ "$dotype" != "start" ]] && [[ "$dotype" != "stop" ]] ;then
        echo 'input param error,please input start or stop'
        exit 0
fi

if [ "$dotype" == "start" ];then
        start
        exit 0
fi
if [ "$dotype" == "stop" ];then
        stop
        exit 0
fi
