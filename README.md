monasca-persister cookbook
======================
Configures and sets up the Monasca Persister

Requirements
------------
Sysctl is required for setting os level memory limits.
Additionally when using as part of a chef server it requires the hp_common_functions cookbook.

Using Vertica
------------
If Vertica is used as the database for Monasca, the Vertica JDBC jar that matches the Vertica version must be placed in /opt/monasca/vertica. The jar from Vertica will be named like vertica-jdbc-7.0.1-0.jar and must be renamed to vertica_jdbc.jar when placed in /opt/monasca/vertica. You can find the Vertica JDBC jar in /opt/vertica/java on a system with the Vertica database installed. This cookbook will copy the Vertica JDBC Jar from /vagrant and place it in /opt/monasca/vertica if run using Chef Solo.

Data Bags
---------
The node[:monasca_persister][:data_bag] data bag is used for all items. When used in standard chef all data bag items can have a location as the suffix and the get_data_bag_item
function will pull the most specific. Item details:

  - monasca_persister is needed for configuration, see the @settings usages in templates/default/persister-config.yml.erb for details
  - `mon_credentials` is an encrytped data bag for user/password, see the @credentials usages in templates/default/persister-config.yml.erb for details
