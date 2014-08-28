# encoding: UTF-8#
#

group node[:monasca_persister][:group] do
  action :create
end
user node[:monasca_persister][:user] do
  action :create
  system true
  gid node[:monasca_persister][:group]
end

package 'monasca-persister' do # The package depends on openjdk-7-jre
  action :upgrade
end

service 'monasca-persister' do
  action :enable
  provider Chef::Provider::Service::Upstart
end

# Create the log file directory
directory '/var/log/monasca' do
  recursive true
  owner node[:monasca_persister][:user]
  group node[:monasca_persister][:group]
  mode 0775
  action :create
end

# TODO: encrypt the credentials data bag item
credentials = data_bag_item(node[:monasca_persister][:data_bag], 'mon_credentials')
settings = data_bag_item(node[:monasca_persister][:data_bag], 'monasca_persister')

template '/etc/monasca/persister-config.yml' do
  action :create
  owner 'root'
  group node[:monasca_persister][:group]
  mode '640'
  source 'persister-config.yml.erb'
  variables(
    credentials: credentials,
    settings: settings
  )
  notifies :restart, 'service[monasca-persister]'
end

if settings['database_configuration']['database_type'] == 'vertica'

  # Create the directory for the vertica JDBC jar
  directory '/opt/monasca/vertica' do
    recursive true
    owner 'root'
    group 'root'
    mode 0755
    action :create
  end

  # Copy the vertica jdbc jar from /vagrant
  bash 'vertica_jdbc.jar' do
    action :run
    code <<-EOL
    DEST=/opt/monasca/vertica/vertica_jdbc.jar
    if [ ! -s ${DEST} ]; then
       SRC=`ls /vagrant/vertica-jdbc-*.jar`
       if [ $? != 0 ]; then
          echo 'You must place a Vertica JDBC jar in the directory where you do the "vagrant up"' 1>&2
          exit 1
       fi
       cp "$SRC" $DEST
       RC=$?
       if [ $RC != 0 ]; then
          exit $RC
       fi
       chown root:root $DEST
       chmod 0555 $DEST
    fi
    EOL
  end
end
