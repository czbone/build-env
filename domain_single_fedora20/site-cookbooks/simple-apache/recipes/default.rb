#
# Cookbook Name:: simple-apache
# Recipe:: default
#
# Copyright 2013, Martin Janser <martin@gogan.ch>
#
# Apache 2.0 License.
#

#package 'apache'
package 'apache' do
  package_name node['apache']['package']
end

service "apache" do
  service_name "httpd.service"
  provider Chef::Provider::Service::Systemd
  action [:enable, :start]
end

#firewalld_rule 80
