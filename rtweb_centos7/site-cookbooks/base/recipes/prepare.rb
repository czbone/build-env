#
# Cookbook Name:: base
# Recipe:: default
#
# Copyright 2016, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
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
