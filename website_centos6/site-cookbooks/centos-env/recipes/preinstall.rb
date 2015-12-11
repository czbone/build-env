#
# Cookbook Name:: centos-env
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
#**************************************************************************************************
#
# Magic3環境構築前に実行する処理
#
# ・RPMforge,EPEL,REMIリポジトリ追加
#
#**************************************************************************************************
yum_package "yum-plugin-priorities" do
  action :install
end
remote_file "#{Chef::Config[:file_cache_path]}/#{node['centos-env']['rpmforge-release']}" do
  source "http://pkgs.repoforge.org/rpmforge-release/#{node['centos-env']['rpmforge-release']}"
  notifies :install, "rpm_package[rpmforge-release_package]", :immediately
  not_if { ::File.exists?("#{Chef::Config[:file_cache_path]}/#{node['centos-env']['rpmforge-release']}") }
end
rpm_package "rpmforge-release_package" do
  source "#{Chef::Config[:file_cache_path]}/#{node['centos-env']['rpmforge-release']}"
  action :nothing
end
template "/etc/yum.repos.d/CentOS-Base.repo" do
  source  'CentOS-Base.repo.erb'
  owner   'root'
  group   'root'
  mode    '0644'
end
yum_package "rpmforge-release" do
  action :upgrade
end
