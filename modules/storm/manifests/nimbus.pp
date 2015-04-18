class storm::nimbus inherits storm{

	##$stormLogDir="$stormInstallDir/apache-storm-$version/logs"
##	$logFileName="nimbus.log"
#	$stormZookeeperServer="192.168.56.7"
#	$stormLocalDir="$stormInstallDir/apache-storm-$version/local"
#	$nimbusHost="192.168.56.7"
#	$supervisorSlotPort1="6700"
#	$supervisorSlotPort2="6701"
#
#	Exec {
#		path => ['/usr','/usr/bin','/bin']
#	}
#
#	exec { 'Download Storm':
#		cwd => '/tmp', 
#		command => "wget http://mirrors.sonic.net/apache/storm/apache-storm-$version/apache-storm-$version.tar.gz",
#		creates => "/tmp/apache-storm-$version.tar.gz",
#		alias => 'download-storm',
#	}
#	
#	exec { 'Prepare Storm Install Directory':
#		command => "mkdir -p $stormInstallDir && chmod 755 $stormInstallDir",
#		require => Exec['download-storm'],
#		alias => 'prepare-storm-dir',
#	}
#
#	exec { 'Untar Storm':
#		cwd => '/tmp',
#		command => "tar -xzf apache-storm-$version.tar.gz -C $stormInstallDir",
#		creates => "$stormInstallDir/apache-storm-$version",
#		alias => 'untar-storm',
#		require => Exec['prepare-storm-dir'],
#	}
#
#	exec { 'create dirs':
#	    command => "mkdir -p $stormInstallDir/apache-storm-$version/logs && mkdir -p $stormInstallDir/apache-storm-$version/local && chmod -R 755 $stormInstallDir/apache-storm-$version/logs",
#	    require => Exec['untar-storm'],
#	    alias => 'create-dirs',
#	  }
#
#    file { "$stormInstallDir/apache-storm-$version/conf/storm.yaml" :
#	    ensure  => file,
#	    mode    => '0644',
#	    content => template('storm/storm.yaml.erb'),
#	    require => Exec['create-dirs'],
#	  	alias => 'storm-config',
#	  }
#
#    file { "$stormInstallDir/apache-storm-$version/logback/cluster.xml" :
#	    ensure  => file,
#	    mode    => '0644',
#	    content => template('storm/cluster.xml.erb'),
#	    require => File['storm-config'],
#	    alias => 'logging-setup',
#	  }	

	exec { 'Start Nimbus':
		command => "sudo $stormInstallDir/apache-storm-$version/bin/storm nimbus &",
		require => File['logging-setup'],
		alias => 'start-nimbus',
		subscribe => File["$stormInstallDir/apache-storm-$version/conf/storm.yaml"],
	}

	service { 'nimbus':
		ensure => running,
		hasstatus => false,
		pattern => "$stormInstallDir/apache-storm-$version",
		require => Exec['start-nimbus'],
	}
}