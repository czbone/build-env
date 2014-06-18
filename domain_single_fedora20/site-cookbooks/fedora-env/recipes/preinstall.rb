#
# Cookbook Name:: fedora-env
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
#******************************************************
#
# 環境構築前に実行する処理
#
# ・RPMforgeリポジトリ追加
#
#******************************************************
yum_package "yum-plugin-priorities" do
  action :install
end
remote_file "#{Chef::Config[:file_cache_path]}/#{node['fedora-env']['rpmforge-release']}" do
  source "http://pkgs.repoforge.org/rpmforge-release/#{node['fedora-env']['rpmforge-release']}"
  notifies :install, "rpm_package[rpmforge-release_package]", :immediately
  not_if { ::File.exists?("#{Chef::Config[:file_cache_path]}/#{node['fedora-env']['rpmforge-release']}") }
end
rpm_package "rpmforge-release_package" do
  source "#{Chef::Config[:file_cache_path]}/#{node['fedora-env']['rpmforge-release']}"
  action :nothing
end
#template "/etc/yum.repos.d/CentOS-Base.repo" do
#  source  'CentOS-Base.repo.erb'
#  owner   'root'
#  group   'root'
#  mode    '0644'
#end
yum_package "rpmforge-release" do
  action :upgrade
end
#******************************************************
#
# NetworkManagerの停止
#
#******************************************************
#execute "Disabling Network manager" do
#  command <<-'EOH'
#    chkconfig network on
#    chkconfig NetworkManager off
#    service NetworkManager stop
#  EOH
#end
#******************************************************
#
# FirewalldのMask状態の解除
#
#******************************************************
bash "unmask_firewalld" do
  user "root"
  code <<-EOH
    if [ "`systemctl is-enabled firewalld`" = "masked" ]
    then
      systemctl unmask firewalld
	fi
  EOH
end

