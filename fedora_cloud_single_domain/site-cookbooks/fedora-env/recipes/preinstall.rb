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
# packageリソースDNFフック前処理
#
# ・Pythonをインストール
#
#******************************************************
bash "pre_package" do
  user "root"
  code <<-EOH
    yum -y install python
	yum -y install python-dnf-plugins-extras-migrate
  EOH
end
#******************************************************
#
# 環境構築前に実行する処理
#
# ・RPMforgeリポジトリ追加
#
#******************************************************
#yum_package "yum-plugin-priorities" do
#  action :install
#end
#remote_file "#{Chef::Config[:file_cache_path]}/#{node['fedora-env']['rpmforge-release']}" do
#  source "http://pkgs.repoforge.org/rpmforge-release/#{node['fedora-env']['rpmforge-release']}"
#  notifies :install, "rpm_package[rpmforge-release_package]", :immediately
#  not_if { ::File.exists?("#{Chef::Config[:file_cache_path]}/#{node['fedora-env']['rpmforge-release']}") }
#end
#rpm_package "rpmforge-release_package" do
#  source "#{Chef::Config[:file_cache_path]}/#{node['fedora-env']['rpmforge-release']}"
#  action :nothing
#end
#template "/etc/yum.repos.d/CentOS-Base.repo" do
#  source  'CentOS-Base.repo.erb'
#  owner   'root'
#  group   'root'
#  mode    '0644'
#end
#yum_package "rpmforge-release" do
#  action :upgrade
#end
#******************************************************
#
# 追加パッケージインストール
#
# ・wget
# ・mailコマンド
# ・expectパッケージ(mkpasswd等)
#
#******************************************************
package "wget" do
  action :install
end
package "mailx" do
  action :install
  package_name value_for_platform(
    ["redhat", "centos", "scientific"] => { "default" => "mailx" },
    ["debian", "ubuntu" ] => { "default" => "bsd-mailx" }
  )
end
package "expect" do
  action :install
end
package "zip" do
  action :install
end
package "unzip" do
  action :install
end
