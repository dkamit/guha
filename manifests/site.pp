node 'kaybus.dev' {
	include zookeeper
	include storm::nimbus
	include storm::supervisor
	include storm::ui
}

# To install in clustered environemt
#node 'master' {
#	include zookeeper
#	include storm::nimbus
#	include storm::ui
#}
#
#node /^slave\d+$/ {
#	include storm::supervisor	
#}