#
# Cookbook Name:: jboss
# Recipe:: default
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
#include_recipe "java_se"

#Creating JBoss user
user 'jboss' do
  comment 'A JBoss user'
end

#Creating directory
directory '/opt/jboss' do
owner 'jboss'
group 'jboss'
mode '0755'
action :create
end

#Downloading JBoss installation
remote_file '/opt/jboss/jboss.tar.gz' do
    force_unlink true
    source node['jboss']['url']
    owner 'jboss'
    group 'jboss'
    mode '0755'
    action :create
end

#Downloading TestWeb app
#remote_file '/opt/jboss/test.zip' do
#    force_unlink true
#    source node['jboss']['testapp_url']
#    owner 'jboss'
#    group 'jboss'
#    mode '0755'
#    action :create
#end