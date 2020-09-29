#!/bin/bash

grep -v 'at ' $1 |grep -v 'api '|grep -v 'Exception'|grep -v 'nohup' | awk -F ' - ' '{print $3}' > input.txt

awk -F ',' '{cost[$1]+=$13;cmd_num[$1]+=1;if(!($1 in cmd_begin_time)){cmd_begin_time[$1]=$9};cmd_end_time[$1]=$11;}END{print "cmd        cmd_exec_num   cmd_tps   cost_time_avg   begin_time      end_time";for (i in cost){printf("%s %s\t",i,cmd_num[i]);printf("%.2f %.2f\t",cmd_num[i]*1000/cost[i],cost[i]/cmd_num[i]);printf("%s %s\t",cmd_begin_time[i],cmd_end_time[i]);printf "\n"}}' input.txt
