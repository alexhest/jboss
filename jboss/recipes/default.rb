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

#Creating main directory
directory node['jboss']['path'] do
owner 'jboss'
group 'jboss'
mode '0755'
action :create
end

#Creating temp directory
directory "#{node['jboss']['path']}/temp" do
owner 'jboss'
group 'jboss'
mode '0755'
action :create
end

#Downloading JBoss installation
remote_file "#{node['jboss']['path']}/temp/jboss.tar.gz" do
    force_unlink true
    source node['jboss']['url']
    owner 'jboss'
    group 'jboss'
    mode '0755'
    action :create
end

release_name = node['jboss']['url'].
    split('/')[-1].
    sub!('.tar.gz', '')

#Extracting JBoss from archive
execute 'extract_jboss' do
    command "tar xzvf jboss.tar.gz"
    cwd "#{node['jboss']['path']}/temp"
end

#Move JBoss files one directory up
execute 'move_jboss' do
    command "shopt -s nocaseglob && mv #{node['jboss']['path']}/temp/#{release_name}/* #{node['jboss']['path']}/"
    cwd node['jboss']['path']
end
    
#Downloading TestWeb app
remote_file "#{node['jboss']['path']}/temp/test.zip" do
    force_unlink true
    source node['jboss']['testapp_url']
    owner 'jboss'
    group 'jboss'
    mode '0755'
    action :create
end