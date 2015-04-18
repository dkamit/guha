##guha

Simple puppet script to install storm in cluster.

#Prerequisits 

- Java 1.6 or above
- Python 2.6.6 or above

#References
[Zookeeper installation] (http://zookeeper.apache.org/doc/r3.3.3/zookeeperStarted.html#sc_InstallingSingleMode)
[Storm Installation] (https://storm.apache.org/documentation/Setting-up-a-Storm-cluster.html)

#Usage

execute papply.sh to install the components defined in site.pp 

#Checking setup

execute ps -eaf | grep zookeeper to check the zookeeper startup successfully

execute ps -eaf | grep storm to check the storm nodes installation in that node

check the Storm UI and check the Nimbus and Supervisor are helthy
