#!/bin/sh

start(){
	num=`ps -ef|grep  wiremock | grep -v grep | wc -l`
	if [ $num -gt 0 ];then
		echo 'wireMock is running,please check'
	else
		nohup java -jar wiremock-standalone-2.23.2.jar --port 8888 >> ./log/wire.log 2>&1 & 
		echo $?
		echo 'wireMock start success'
	fi
}
stop(){
	num=`ps -ef|grep  wiremock | grep -v grep | wc -l`
        if [ $num -lt 1 ];then
		echo 'wireMock is not running,please check'
	else
		pid=`ps -ef|grep  wiremock | grep -v grep | awk '{print $2}'`
		kill -9 "$pid"
		num=`ps -ef|grep  wiremock | grep -v grep | wc -l`
			if [ $num -lt 1 ];then
                	echo 'wireMock has been stopped'
			fi
	fi
	
}
restart(){
	stop
	start
}

del(){
	find ./mappings/ -name *"$filename"* | xargs rm -fr
	echo 'delete file success'
}
if [ $# -eq 1 ];then
	dotype=$1
	
	if [ "$dotype" == "start" ];then
        	start
        	exit 0
	fi
	if [ "$dotype" == "stop" ];then
        	stop
        	exit 0
	fi
	if [ "$dotype" == "restart" ];then
        	restart
        	exit 0
	fi

elif [ $# -eq 2 ];then
	dotype=$1
	filename=$2
	
	if [ "$dotype" == "del" ];then
		del
	fi
else
	echo 'input params error'

fi
