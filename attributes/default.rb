# encoding: UTF-8#
#
node.default[:monasca_persister][:user] = 'persister'
node.default[:monasca_persister][:group] = 'monasca'
node.default[:monasca_persister][:data_bag] = 'monasca_persister'

# Sysctl settings
# This style is picked up by the sysctl cookbook in HP Cloud basenode
node.default[:sysctl]['net.core.rmem_max'] = '16777216'
# This style is used by the sysctl community cookbook
node.default[:sysctl][:params][:net][:core][:rmem_max] = '16777216'
