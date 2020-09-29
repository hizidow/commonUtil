#!/bin/bash

grep -v 'at ' $1 |grep -v 'api '|grep -v 'Exception'|grep -v 'nohup' | awk -F ' - ' '{print $3}' > input.txt

awk -F ',' '{cost[$1]+=$13;cmd_num[$1]+=1;if(!($1 in cmd_begin_time)){cmd_begin_time[$1]=$9};cmd_end_time[$1]=$11;}
END{print "cmd        cmd_exec_num   cmd_tps   cost_time_avg   begin_time      end_time";
for (i in cost){y1=substr(cmd_begin_time[i],0,4);m1=substr(cmd_begin_time[i],6,2);d1=substr(cmd_begin_time[i],9,2);
h1=substr(cmd_begin_time[i],12,2);M1=substr(cmd_begin_time[i],15,2);s1=substr(cmd_begin_time[i],18,2);
y2=substr(cmd_end_time[i],0,4);m2=substr(cmd_end_time[i],6,2);d2=substr(cmd_end_time[i],9,2);
h2=substr(cmd_end_time[i],12,2);M2=substr(cmd_end_time[i],15,2);s2=substr(cmd_end_time[i],18,2);
printf("%s %s\t",i,cmd_num[i]);
printf("%.2f %.2f\t",cmd_num[i]/(mktime(y2" "m2" "d2" "h2" "M2" "s2)-mktime(y1" "m1" "d1" "h1" "M1" "s1)),cost[i]/cmd_num[i]);printf("%s %s\t",cmd_begin_time[i],cmd_end_time[i]);
printf "\n"}}' input.txt
