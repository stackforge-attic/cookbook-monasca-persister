package 'mon-persister' do #The package depends on openjdk-7-jre
  action :upgrade
end

service 'mon-persister' do
  action :enable
  provider Chef::Provider::Service::Upstart
end

# Create the log file directory
directory "/var/log/mon" do
    recursive true
    owner "persister"
    group node[:mon_persister][:group]
    mode 0755
    action :create
end

# Todo encrypt the credentials data bag item
credentials = data_bag_item(node[:mon_persister][:data_bag], 'mon_credentials')
settings = data_bag_item(node[:mon_persister][:data_bag], 'mon_persister')

template '/etc/mon/persister-config.yml' do
  action :create
  owner 'root'
  group node[:mon_persister][:group]
  mode "640"
  source "persister-config.yml.erb"
  variables(
    :credentials => credentials,
    :settings => settings
  )
  notifies :restart, "service[mon-persister]"
end
