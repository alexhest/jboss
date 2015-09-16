#
# Cookbook Name:: jboss
# Recipe:: Init
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

#Installing init script
template '/etc/init.d/jboss' do
source 'init.erb'
owner 'jboss'
group 'jboss'
mode '0754'
action :create
end

#Starting JBoss server
execute 'start_jboss' do
command "/etc/init.d/jboss start"
user 'root'
group 'root'
end