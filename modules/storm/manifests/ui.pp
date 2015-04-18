class storm::ui inherits storm {

	Exec {
		path => ['/usr','/usr/bin','/bin']
	}

	exec { 'Start UI':
		command => "sudo $stormInstallDir/apache-storm-$version/bin/storm ui &",
		require => File['logging-setup'],
		alias => 'start-ui',
		subscribe => File["$stormInstallDir/apache-storm-$version/conf/storm.yaml"],
	}

	service { 'ui':
		ensure => running,
		hasstatus => false,
		pattern => "$stormInstallDir/apache-storm-$version",
		require => Exec['start-ui'],
		restart => "sudo $stormInstallDir/apache-storm-$version/bin/storm ui & "
	}
}