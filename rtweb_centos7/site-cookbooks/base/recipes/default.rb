#
# Cookbook Name:: base
# Recipe:: default
#
# Copyright 2016, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
#mysql_service 'default' do
#  version '5.5'
#  initial_root_password ''
#  action [:create, :start]
#end

#mysql_client 'default' do
#  action :create
#end
#******************************************************
#
# �p�b�P�[�W���|�W�g���ǉ�
#
#******************************************************
yum_package "epel-release" do
  action :install
end

#******************************************************
#
# �ǉ��p�b�P�[�W�C���X�g�[��
#
# �Email�R�}���h
# �Eexpect�p�b�P�[�W(mkpasswd��)
#
#******************************************************
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
