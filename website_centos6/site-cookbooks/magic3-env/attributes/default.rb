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
# Magic3構築環境
#
#******************************************************
# Magic3の情報
default['magic3-env']['magic3_arc_ver']       = '2.15.2'    # 最新ソースバージョン
# その他

#******************************************************
#
# テスト用Magic3の設定
#
#******************************************************
default['magic3-env']['test_doc_root'] = '/var/www/html'
default['magic3-env']['test_magic3_dir_name'] = 'magic3'

#******************************************************
#
# テスト用DBの設定
#
#******************************************************
default['magic3-env']['test_db_name'] = 'testdb'
default['magic3-env']['test_db_user'] = 'root'
default['magic3-env']['test_db_password'] = ''

