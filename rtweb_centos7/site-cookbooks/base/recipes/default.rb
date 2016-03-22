#
# Cookbook Name:: base
# Recipe:: default
#
# Copyright 2016, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
mysql_service 'default' do
#  version '5.5'
  initial_root_password "#{node['mysql']['server_root_password']}"
  socket '/var/lib/mysql/mysql.sock'
  action [:create, :start]
end
#mysql_config 'default' do
#  source 'my.cnf.erb'
#  notifies :restart, 'mysql_service[default]'
#  action :create
#end
mysql_client 'default' do
  action :create
end
template "/etc/mysql-default/conf.d/my.cnf" do
  source "my.cnf.erb"
  mode 0644
  notifies :restart, 'mysql_service[default]'
end
