#
# Cookbook Name:: ceilometer
# Recipe:: ceilometer-db-setup
#
# Copyright 2012, AT&T
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

::Chef::Recipe.send(:include, Opscode::OpenSSL::Password)

# Allow for using a well known db password
node.set_unless["ceilometer"]["db"]["password"] = node["developer_mode"] ? 'ceilometer' : secure_password

if node['db']['provider'] == 'mysql'
  include_recipe "mysql::client"
  include_recipe "mysql::ruby"

  create_db_and_user("mysql",
                     node["ceilometer"]["db"]["name"],
                     node["ceilometer"]["db"]["username"],
                     node["ceilometer"]["db"]["password"])
end
if node['db']['provider'] == 'postgresql'
  include_recipe "postgresql::client"
  include_recipe "postgresql::ruby"
  create_db_and_user("postgresql",
                     node["ceilometer"]["db"]["name"],
                     node["ceilometer"]["db"]["username"],
                     node["ceilometer"]["db"]["password"])
end
