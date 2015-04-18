node 'kaybus.dev' {
	include zookeeper
	include storm::nimbus
	include storm::supervisor
	include storm::ui
}