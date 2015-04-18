class zookeeper {
	
	$version = "3.3.6"
	$tickTime = "2000"
	$dataDir = "/etc/data"
	$clientPort = "2182"
	$zkInstallDir = "/home/kaybus/install"

	Exec {
		path => ['/usr','/usr/bin','/bin']
	}

	file {'/etc/data': 
		ensure => "directory",
		mode => "776"
	}

	exec { 'Download Zookeeper':
		cwd => '/tmp', 
		command => "wget http://mirror.cc.columbia.edu/pub/software/apache/zookeeper/zookeeper-$version/zookeeper-$version.tar.gz",
		creates => "/tmp/zookeeper-$version.tar.gz",
	}

	exec { 'Prepare Zookeeper Install Directory':
		command => "mkdir -p $zkInstallDir && chmod 755 $zkInstallDir",
		require => Exec['Download Zookeeper'],
		alias => "prepare-zk-dir"
	}

	exec { 'Untar Zookeeper':
		cwd => '/tmp',
		command => "tar -xzf zookeeper-$version.tar.gz -C $zkInstallDir",
		creates => "$zkInstallDir/zookeeper-$version",
		alias => 'untar-zookeeper',
		require => Exec['prepare-zk-dir']
	}

	file { "$zkInstallDir/zookeeper-$version/conf/zoo.cfg":
		content => template('zookeeper/zoo.cfg.erb'),
		mode => '755',
		alias => 'zookeeper-config',
		require => Exec['untar-zookeeper']
	}

	exec { 'Start Zookeeper':
		command => "sh $zkInstallDir/zookeeper-$version/bin/zkServer.sh start",
		require => File['zookeeper-config'],
		alias => 'start-zk',
		subscribe => File["$zkInstallDir/zookeeper-$version/conf/zoo.cfg"],
	}

	service { 'zookeeper':
		ensure => running,
		hasstatus => false,
		pattern => "$zkInstallDir/zookeeper-$version/bin",
		require => Exec['start-zk'],
		restart => "sudo $zkInstallDir/zookeeper-$version/bin/zkServer.sh restart",
	}
}