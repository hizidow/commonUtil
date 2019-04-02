#!/bin/sh

function start()
{
        pid_num=`ps -ef | grep '\/sbin\/collectd' | grep -v '\-\-color=auto' | awk '{print $2}' | wc -l`

        if [[ $pid_num -gt 0 ]] ; then
                echo 'collectd is running'
        else
                /opt/collectd/sbin/collectd
        fi
}

function stop()
{
        pid=`ps -ef | grep '\/sbin\/collectd' | grep -v '\-\-color=auto' | awk '{print $2}'`
        kill -9 $pid
}

function restart()
{
        stop
        start
}

if  [[ "$1" != "start" ]] && [[ "$1" != "stop" ]] && [[ "$1" != "restart" ]];then
        echo 'input param error,please input start or stop restart'
        exit 0
fi

if [ "$1" == "start" ];then
        start
        exit 0
fi
if [ "$1" == "stop" ];then
        stop
        exit 0
fi
if [ "$1" == "restart" ];then
        restart
        exit 0
fi
