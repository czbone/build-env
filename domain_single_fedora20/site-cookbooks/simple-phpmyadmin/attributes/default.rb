#
# Cookbook Name:: simple-phpmyadmin
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
#******************************************************
#
# phpMyAdminの設定
#
#******************************************************
default['phpmyadmin']['version']           = '4.2.3'
default['phpmyadmin']['dir']        = '/usr/share/phpMyAdmin'
default['phpmyadmin']['upload_dir'] = '/var/lib/phpMyAdmin/upload'
default['phpmyadmin']['save_dir']   = '/var/lib/phpMyAdmin/save'
