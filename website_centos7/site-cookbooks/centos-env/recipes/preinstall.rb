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
# ・RPMforgeリポジトリ追加
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

#yum_key 'RPM-GPG-KEY-MariaDB' do
#  url 'https://yum.mariadb.org/RPM-GPG-KEY-MariaDB'
#  action :add
#end
#yum_repository 'MariaDB' do
#  repo_name 'MariaDB'
#  url 'http://yum.mariadb.org/10.0/centos6-amd64'
#  key 'RPM-GPG-KEY-MariaDB'
#  action :create
#end
template "/etc/yum.repos.d/mariadb.repo" do
  source "MariaDB.repo.erb"
  mode 00644
  owner "root"
  group "root"
end
#**************************************************************************************************
#
# MariaDB用の処理
#
# ・パッケージインストール時にmariadb-libsとのコンフリクトが発生するので削除。
#
#**************************************************************************************************
bash "pre_mariadb" do
  user "root"
  cwd Chef::Config[:file_cache_path]
  code <<-EOH
    rpm -q mariadb-libs
	if [ "$?" -eq 0 ] ; then
      rpm -e --nodeps mariadb-libs
	fi
  EOH
end
package "MySQL-shared" do
  action :install
end
#**************************************************************************************************
#
# 追加パッケージインストール
#
# ・wget
# ・mailコマンド
# ・expectパッケージ(mkpasswd等)
# ・zip,unzip
#
#**************************************************************************************************
#package "wget" do
#  action :install
#end
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