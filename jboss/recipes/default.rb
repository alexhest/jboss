#
# Cookbook Name:: jboss
# Recipe:: default
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
include_recipe "java_se"

jboss_url = node["jboss"]["url"]
jboss_path = node["jboss"]["path"]
jboss_tmp = node["jboss"]["tmp"]
jboss_user = node["jboss"]["user"]
jboss_testapp = node["jboss"]["testapp_url"]


#Creating JBoss user
user jboss_user do
  comment 'A JBoss user'
end

#Cleaning temp directory
directory jboss_tmp do
ignore_failure true
recursive true
action :delete
end

#Creating JBoss directory
directory jboss_path do
owner 'jboss'
group 'jboss'
mode '0755'
action :create
end

#Creating TEMP directory
directory jboss_tmp do
owner 'jboss'
group 'jboss'
mode '0755'
action :create
end

#Downloading JBoss installation
remote_file "#{jboss_tmp}/jboss.tar.gz" do
    force_unlink true
    source jboss_url
    owner 'jboss'
    group 'jboss'
    mode '0755'
    action :create
end

#Getting name of release
release_name = jboss_url.
    split('/')[-1].
    sub!('.tar.gz', '')

#Extracting JBoss from archive
execute 'extract_jboss' do
    command "tar xzvf jboss.tar.gz"
    cwd jboss_tmp
    user 'jboss'
    group 'jboss'
end

#Move JBoss files one directory up
execute 'move_jboss' do
    command "shopt -s nocaseglob && mv #{jboss_tmp}/#{release_name}/* #{jboss_path}/"
    cwd jboss_path
end

#Copying JBoss config from files resources
cookbook_file "#{jboss_path}/standalone/configuration/standalone.xml" do
source 'standalone.xml'
owner 'jboss'
group 'jboss'
mode '0644'
action :create
end