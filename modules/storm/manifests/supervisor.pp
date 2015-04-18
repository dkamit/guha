class storm::supervisor inherits storm {

	Exec {
		path => ['/usr','/usr/bin','/bin']
	}

	exec { 'Start Supervisor':
		command => "sudo $stormInstallDir/apache-storm-$version/bin/storm supervisor &",
		require => File['logging-setup'],
		alias => 'start-supervisor',
		subscribe => File["$stormInstallDir/apache-storm-$version/conf/storm.yaml"],
	}

	service { 'supervisor':
		ensure => running,
		hasstatus => false,
		pattern => "$stormInstallDir/apache-storm-$version",
		require => Exec['start-supervisor'],
	}
}