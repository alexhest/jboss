#
# Cookbook Name:: jboss
# Recipe:: Deploy
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
#include_recipe "jboss"

#Downloading TestWeb app

jboss_path = node['jboss']['path']
jboss_tmp = node['jboss']['tmp']

remote_file "#{jboss_tmp}/test.zip" do
    force_unlink true
    source node['jboss']['testapp_url']
    owner 'jboss'
    group 'jboss'
    mode '0755'
    action :create
end

#Extracting TestWeb from archive
execute 'extract_jboss' do
    command "unzip -d #{jboss_path}/standalone/deployments -j test.zip "
    cwd jboss_tmp
    user 'jboss'
    group 'jboss'
end

#Installing init script
template '/etc/init.d/jboss' do
source 'init.erb'
owner 'root'
group 'root'
mode '0755'
action :create
end

