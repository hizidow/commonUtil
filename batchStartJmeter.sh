#!/bin/sh

script_home="./zzdjmx"
result_home="./zzdjtl"
output_home="./output"

if [ ! -d $script_home ];then
        mkdir $script_home
fi

if [ ! -d $result_home ];then
        mkdir $result_home
fi

if [ ! -d $output_home ] ;then
        mkdir $output_home
fi

jmx_list=(`ls $script_home | grep jmx`)
jmx_list_len=${#jmx_list[@]}
for((i=0;i<$jmx_list_len;i++));
do
        ######-----------get script execute time-------####
        time=`cat ./$script_home/${jmx_list[$i]} | grep ThreadGroup.duration | tr -cd "[0-9]"`

        echo "begain script $script_home/${jmx_list[$i]}"
        nohup ./jmeter -n -t $script_home/${jmx_list[$i]} -l ./$result_home/${jmx_list[$i]}.jtl > ./$output_home/${jmx_list[$i]}.log 2>&1 &

        ######---------- wait for more 60s until script teardown-------- #####
        sleep `expr $time + 60`"s"
        echo "sleep `expr $time + 60`s done"
        #######---------if script can not stop by self ,forced stop by kill---- #####
        num=`ps -ef| grep "${jmx_list[$i]}" | wc -l`
        if [ $num -gt 1 ];then
                ps -ef| grep "${jmx_list[$i]}" | grep java | awk '{print $2}' | xargs kill -9
        fi

        echo "end script $script_home/${jmx_list[$i]}"
done;
