#
# Cookbook Name:: jboss
# Recipe:: Init
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
jboss_user = node["jboss"]["user"]

#Installing init script
template '/etc/init.d/jboss' do
source 'init.erb'
owner jboss_user
group jboss_user
mode '0754'
action :create
end

#Starting JBoss server
execute 'start_jboss' do
command "/etc/init.d/jboss start"
user 'root'
group 'root'
end