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
# 構築環境
#
#******************************************************
default['tz'] = 'Asia/Tokyo'
case node["platform_family"]
  when "rhel", "fedora"
    if node['kernel']['machine'] == 'x86_64'
	  default['fedora-env']['rpmforge-release']             = 'rpmforge-release-0.5.3-1.el6.rf.x86_64.rpm'
    else
      default['fedora-env']['rpmforge-release']             = 'rpmforge-release-0.5.3-1.el6.rf.i686.rpm'
  end
end

#******************************************************
#
# PHPの設定
#
#******************************************************
#
# PHP追加モジュール読み込み
#
#default['php']['packages'] = ['php', 'php-pear', 'php-mcrypt', 'php-mbstring', 'php-gd', 'php-mysql', 'php-xml']

# デフォルト値設定
default['php']['date.timezone']       = 'Asia/Tokyo'
default['php']['disable_functions']   = 'popen'
default['php']['post_max_size']       = '8M'
default['php']['upload_max_filesize'] = '2M'

#******************************************************
#
# Apacheの設定
#
#******************************************************
default['apache']['package']     = 'httpd'
