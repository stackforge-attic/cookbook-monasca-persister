node.default[:mon_persister][:group] = 'persister'
node.default[:mon_persister][:data_bag] = 'mon_persister'

#Sysctl settings
#This style is picked up by the sysctl cookbook in HP Cloud basenode
node.default[:sysctl]['net.core.rmem_max'] = '16777216'
#This style is used by the sysctl community cookbook
node.default[:sysctl][:params][:net][:core][:rmem_max] = '16777216'
