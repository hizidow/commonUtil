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
	if [ $? -eq 0 ];then
                echo 'restart success'
        fi
}

moveback(){
	file=`find ./map_del/ -name *"$filename"*`
        mv "$file" ./mappings/
        if [ $? -eq 0 ];then
                echo 'moveback file success'
        fi

}


move(){
	file=`find ./mappings/ -name *"$filename"*`
	mv "$file" ./map_del/
	if [ $? -eq 0 ];then
                echo 'move file success'
        fi
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
	
	if [ "$dotype" == "move" ];then
		move
	fi
	if [ "$dotype" == "moveback" ];then
		moveback
	fi
else
	echo 'input params error'

fi
