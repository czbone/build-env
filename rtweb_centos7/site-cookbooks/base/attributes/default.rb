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
#case node["platform_family"]
#  when "rhel", "fedora"
#    if node['platform_version'].to_f < 6 then
#      default['php']['packages'] = ['php53', 'php-pear', 'php53-mcrypt', 'php53-mbstring', 'php53-gd', 'php53-mysql', 'php53-xml', 'php53-imap']
#    else
      default['php']['packages'] = ['php', 'php-pear', 'php-mbstring', 'php-gd', 'php-mysql', 'php-xml', 'php-imap']
#default['php']['packages'] = ['php', 'php-pear', 'php-mbstring', 'php-gd', 'php-mysql', 'php-xml']
#    end
#end

# デフォルト値設定
default['php']['date.timezone'] = 'Asia/Tokyo'
default['php']['post_max_size'] = '20M'
default['php']['upload_max_filesize'] = '20M'
