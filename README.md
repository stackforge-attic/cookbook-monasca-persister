mon-persister cookbook
======================
Configures and sets up the MON Persister

Requirements
------------
Sysctl is required for setting os level memory limits.
Additionally when using as part of a chef server it requires the hp_common_functions cookbook.

Data Bags
---------
The node[:mon_persister][:data_bag] data bag is used for all items. When used in standard chef all data bag items can have a location as the suffix and the get_data_bag_item
function will pull the most specific. Item details:

  - mon_persister is needed for configuration
  - `?_credentials` is and encrytped data bag for user/password credentials
