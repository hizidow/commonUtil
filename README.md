# commonUtil
一些常用的工具代码

#######################################################
##collectd 使用说明
######################################################
以下操作需要root权限

1.上传  collectd.tar.gz 建议采用rz
2.解压  tar -zxvf collectd.tar.gz
3.复制启动文件collectd   cp -f /opt/collectd/collectd /etc/init.d/
4.修改jvm.conf文件  ###jmx端口 一般默认为10055

vim /opt/collectd/conf/jvm.conf 
5.修改collectd.conf 

vim /opt/collectd/etc/collectd.conf
service collectd start

备注：
关闭：service collectd start  重启 service collectd restart

判断collect是否启动成功

ps -ef|grep collectd
netstat -anp|grep collectd

#######################################################
##collectd 使用说明结束
######################################################
