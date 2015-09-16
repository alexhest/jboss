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

jboss_path = node["jboss"]["path"]
jboss_tmp = node["jboss"]["tmp"]
jboss_user = node["jboss"]["user"]
jboss_testapp = node["jboss"]["testapp_url"]

remote_file "#{jboss_tmp}/test.zip" do
    force_unlink true
    source jboss_testapp
    owner jboss_user
    group jboss_user
    mode '0755'
    action :create
end

#Extracting TestWeb from archive
execute 'extract_jboss' do
    command "unzip -d #{jboss_path}/standalone/deployments -j test.zip "
    cwd jboss_tmp
    user jboss_user
    group jboss_user
end

#Restarting JBoss
execute 'restart_jboss' do
command "/etc/init.d/jboss restart"
user 'root'
group 'root'
end