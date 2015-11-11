#
# Cookbook Name:: fedora-env
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
include_recipe "php"
#include_recipe "timezone-ii"
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
# Apache�ݒ�t�@�C���ǂݍ���
#
#******************************************************
#****** Apache2�Ǘ��O���W���[���ǉ� *****
#apache_module "unixd"

#******************************************************
#
# ROOT��
#
#******************************************************
cookbook_file "/root/.bash_profile" do
  source "root_bash_profile.txt"
end

#******************************************************
#
# �t�@�C�A�E�H�[���̐ݒ�
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
#******************************************************
#
# PHP�ݒ�t�@�C���ǂݍ���
#
#******************************************************
template "/etc/php.ini" do
  source "php.ini.erb"
  mode 0644
  notifies :restart, 'service[apache]'
end
