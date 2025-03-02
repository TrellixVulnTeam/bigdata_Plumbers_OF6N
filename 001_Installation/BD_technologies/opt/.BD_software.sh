"""
In this file, we will be downloading and installing the Hadoop software
"""

#!/bin/sh


sudo apt-get update

sudo wget -O jdk-8u221-linux-x64.tar.gz \
-c --content-disposition \
"https://javadl.oracle.com/webapps/download/AutoDL?BundleId=239835_230deb18db3e4014bb8e3e8324f81b43"

tar -zxvf jdk-8u221-linux-x64.tar.gz

rm jdk-8u221-linux-x64.tar.gz

echo "JAVA_HOME=/opt/jdk1.8.0_221" >> .bash_profile.sh
echo "export PATH=$PATH:$JAVA_HOME/bin" >> .bash_profile.sh

sudo apt-get install openssh-server openssh-client

ssh-keygen -t rsa -P ""

cat $HOME/.ssh/id_rsa.pub >> $HOME/.ssh/authorized_keys

sudo apt-get install rsync

sudo wget https://apache.claz.org/hadoop/common/hadoop-2.7.7/hadoop-2.7.7.tar.gz

tar -zxvf hadoop-2.7.7.tar.gz

rm hadoop-2.7.7.tar.gz

echo "export HADOOP_HOME=/opt/hadoop-2.7.7" >> .bash_profile.sh
echo "export HADOOP_INSTALL=$HADOOP_HOME" >> .bash_profile.sh
echo "export HADOOP_MAPRED_HOME=$HADOOP_HOME" >> .bash_profile.sh
echo "export HADOOP_COMMON_HOME=$HADOOP_HOME" >> .bash_profile.sh
echo "export HADOOP_HDFS_HOME=$HADOOP_HOME" >> .bash_profile.sh
echo "export YARN_HOME=$HADOOP_HOME" >> .bash_profile.sh
echo "export HADOOP_COMMON_LIB_NATIVE_DIR=$HADOOP_HOME/lib/native" >> .bash_profile.sh
echo "export PATH=$PATH:$HADOOP_HOME/sbin:$HADOOP_HOME/bin" >> .bash_profile.sh

source .bash_profile.sh

cd hadoop-2.7.7/etc/hadoop

echo "export JAVA_HOME=/opt/jdk1.8.0_221" >> hadoop-env.sh

echo "<configuration>
<property>
  <name>fs.default.name</name>
    <value>hdfs://localhost:9000</value>
</property>
</configuration>" >> core-site.xml



echo "<configuration>
<property>
 <name>dfs.replication</name>
 <value>1</value>
</property>
</configuration>" >> hdfs-site.xml


echo "<configuration>
 <property>
  <name>mapreduce.framework.name</name>
   <value>yarn</value>
 </property>
</configuration>" >> mapred-site.xml


echo "<configuration>
 <property>
  <name>yarn.nodemanager.aux-services</name>
    <value>mapreduce_shuffle</value>
 </property>
</configuration>" >> yarn-site.xml
