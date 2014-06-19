#
# Cookbook Name:: simple-phpmyadmin
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
#******************************************************
#
# phpMyAdminインストール
#
#******************************************************
remote_file "#{Chef::Config[:file_cache_path]}/phpMyAdmin-#{node['phpmyadmin']['version']}-all-languages.tar.gz" do
  action :create_if_missing
  source "http://downloads.sourceforge.net/phpmyadmin/phpMyAdmin-#{node['phpmyadmin']['version']}-all-languages.tar.gz"
  notifies :run, "bash[install_phpmyadmin]", :immediately
#  not_if { ::File.exists?("#{Chef::Config[:file_cache_path]}/phpMyAdmin-#{node['phpmyadmin']['version']}-all-languages.tar.gz") }
#  checksum node['phpmyadmin']['checksum']
end
bash "install_phpmyadmin" do
  user "root"
  cwd Chef::Config[:file_cache_path]
  code <<-EOH
    tar xzf phpMyAdmin-#{node['phpmyadmin']['version']}-all-languages.tar.gz
    mv phpMyAdmin-#{node['phpmyadmin']['version']}-all-languages #{node['phpmyadmin']['dir']}
  EOH
  action :nothing
#  not_if { ::File.exists?("#{node['phpmyadmin']['dir']}") }
end
template "#{node['phpmyadmin']['dir']}/config.inc.php" do
  source   'config.inc.php.erb'
  owner    'root'
  group    'root'
  mode     '0644'
end
directory node['phpmyadmin']['upload_dir'] do
  owner 'root'
  group 'root'
  mode  '0777'
  recursive true
  action :create
end
directory node['phpmyadmin']['save_dir'] do
  owner 'root'
  group 'root'
  mode  '0777'
  recursive true
  action :create
end
template "#{node['apache']['dir']}/conf.d/phpMyAdmin.conf" do
  source    'phpMyAdmin.conf.erb'
  mode      '0644'
  notifies  :restart, 'service[apache]'
end
