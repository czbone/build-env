#
# Cookbook Name:: magic3-env
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
#******************************************************
#
# リアルタイムWebベース環境用
#
#******************************************************
#******************************************************
#
# Apacheの設定
#
#******************************************************
default['apache']['default_site_enabled'] = true

#******************************************************
#
# PHPの設定
#
#******************************************************
#
# PHP追加モジュール読み込み
#
default['php']['packages'] = ['php', 'php-pear', 'php-mbstring', 'php-gd', 'php-mysql', 'php-xml', 'php-imap']

# デフォルト値設定
default['php']['date.timezone'] = 'Asia/Tokyo'
default['php']['post_max_size'] = '20M'
default['php']['upload_max_filesize'] = '20M'

#******************************************************
#
# MySQLの設定
#
#******************************************************
default['mysql']['server_root_password']            = 'root'
default['mysql']['tunable']['character-set-server'] = 'utf8'
default['mysql']['tunable']['collation-server']     = 'utf8_general_ci'
