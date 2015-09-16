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
owner 'root'
group 'root'
mode '0755'
action :create
end

#Stating JBoss server
execute 'start_jboss' do
command "/usr/bin/sh /etc/init.d/jboss start"
user 'jboss'
group 'jboss'
end