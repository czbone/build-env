#
# Cookbook Name:: fedora-env
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
include_recipe "php"
#include_recipe "phpmyadmin"

#%W[
#  #{node['apache']['dir']}/ssl
#  #{node['apache']['dir']}/conf-available
#  #{node['apache']['dir']}/conf-enabled
#  #{node['apache']['cache_dir']}
#].each do |path|
#  directory path do
#    mode  '0755'
#    owner 'root'
#    group node['apache']['root_group']
#  end
#end
#******************************************************
#
# Apache設定ファイル読み込み
#
#******************************************************
#****** Apache2管理外モジュール追加 *****
#apache_module "unixd"

#******************************************************
#
# ROOT環境
#
#******************************************************
cookbook_file "/root/.bash_profile" do
  source "root_bash_profile.txt"
end

#******************************************************
#
# ファイアウォールの設定
#
#******************************************************
bash "open_default_port" do
  user "root"
  code <<-EOH
    firewall-cmd --permanent --add-service=http
	firewall-cmd --permanent --add-service=ssh
	firewall-cmd --permanent --add-service=https
	firewall-cmd --permanent --add-service=ntp
  EOH
#  notifies :restart, 'service[firewalld]'
end

#phpmyadmin_db 'Test DB' do
#    host '127.0.0.1'
#    port 3306
#    username 'root'
#    password 'password'
#    hide_dbs %w{ information_schema mysql phpmyadmin performance_schema }
#end
#******************************************************
#
# phpMyAdminインストール
#
#******************************************************
#remote_file "#{Chef::Config[:file_cache_path]}/phpMyAdmin-#{node['fedora-env']['phpmyadmin_version']}-all-languages.tar.gz" do
#  action :create_if_missing
#  source "http://downloads.sourceforge.net/phpmyadmin/phpMyAdmin-#{node['fedora-env']['phpmyadmin_version']}-all-languages.tar.gz"
#  notifies :run, "bash[install_phpmyadmin]", :immediately
##  not_if { ::File.exists?("#{Chef::Config[:file_cache_path]}/phpMyAdmin-#{node['fedora-env']['phpmyadmin_version']}-all-languages.tar.gz") }
##  checksum node['phpmyadmin']['checksum']
#end
#bash "install_phpmyadmin" do
#  user "root"
#  cwd Chef::Config[:file_cache_path]
#  code <<-EOH
#    tar xzf phpMyAdmin-#{node['fedora-env']['phpmyadmin_version']}-all-languages.tar.gz
#    mv phpMyAdmin-#{node['fedora-env']['phpmyadmin_version']}-all-languages #{node['fedora-env']['phpmyadmin_dir']}
#  EOH
#  action :nothing
#  not_if { ::File.exists?("#{node['fedora-env']['phpmyadmin_dir']}") }
#end
#template "#{node['fedora-env']['phpmyadmin_dir']}/config.inc.php" do
#  source   'phpmyadmin_config.inc.php.erb'
#  owner    'root'
#  group    'root'
#  mode     '0644'
#end