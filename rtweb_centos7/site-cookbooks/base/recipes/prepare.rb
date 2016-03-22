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
# パッケージレポジトリ追加
#
#******************************************************
yum_package "epel-release" do
  action :install
end
#******************************************************
#
# 追加パッケージインストール
#
# ・mailコマンド
# ・expectパッケージ(mkpasswd等)
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
