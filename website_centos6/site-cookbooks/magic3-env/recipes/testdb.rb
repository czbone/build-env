#
# Cookbook Name:: magic3
# Recipe:: default
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
include_recipe 'database::mysql'
#******************************************************
#
# Magic3最新ソースの取得して配置
#
#******************************************************
remote_file "#{Chef::Config[:file_cache_path]}/magic3_#{node['magic3-env']['magic3_arc_ver']}.tar.gz" do
  source "https://api.github.com/repos/magic3org/magic3/tarball/v#{node['magic3-env']['magic3_arc_ver']}"
  notifies :run, "bash[install_magic3_src]", :immediately
  not_if { ::File.exists?("#{Chef::Config[:file_cache_path]}/magic3_#{node['magic3-env']['magic3_arc_ver']}.tar.gz") }
end
bash "install_magic3_src" do
  user "root"
  cwd "#{node['magic3-env']['test_doc_root']}"
  code <<-EOH
    if [ -d #{node['magic3-env']['test_magic3_dir_name']} ]; then
      rm -rf _#{node['magic3-env']['test_magic3_dir_name']}
      mv #{node['magic3-env']['test_magic3_dir_name']} _#{node['magic3-env']['test_magic3_dir_name']}
    fi
    destdir=`tar tzf "#{Chef::Config[:file_cache_path]}/magic3_#{node['magic3-env']['magic3_arc_ver']}.tar.gz" | head -n 1`
    destdirname=`basename $destdir`
    tar xzf "#{Chef::Config[:file_cache_path]}/magic3_#{node['magic3-env']['magic3_arc_ver']}.tar.gz"
	mv ${destdirname} #{node['magic3-env']['test_magic3_dir_name']}
	chown -R apache:apache #{node['magic3-env']['test_magic3_dir_name']}
  EOH
  action :nothing
end
#******************************************************
#
# サンプルデータベース作成
#
#******************************************************
mysql_database node['magic3-env']['test_db_name'] do
  connection(
    :host     => '127.0.0.1',
    :username => node['magic3-env']['test_db_user'],
    :password => node['magic3-env']['test_db_password']
  )
  action :create
end
