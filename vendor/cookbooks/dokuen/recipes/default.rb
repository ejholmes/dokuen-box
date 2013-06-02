include_recipe "ruby_build::default"
include_recipe "rbenv::system"
include_recipe "nginx"
include_recipe "gitolite::basic"

user node['dokuen']['user'] do
  action :create
end

group node['gitolite']['group'] do
  action  :modify
  members node['dokuen']['user']
  append  true
end

directory "#{node['gitolite']['home']}/repositories" do
  mode 0775
  action :create
end

directory "#{node['gitolite']['home']}/.mason" do
  mode 0775
  group node['gitolite']['username']
  user  node['gitolite']['group']
  action :create
end

rbenv_gem "dokuen" do
  action :install
end

rbenv_rehash "Rehashing rbenv"

directory node['dokuen']['directory'] do
  recursive true
end

rbenv_script "setup dokuen" do
  cwd  node['dokuen']['directory']
  code "dokuen setup ."
end

cookbook_file "#{node['gitolite']['home']}/.gitolite.rc" do
  source "gitolite.rc"
  user   node['gitolite']['username']
  group  node['gitolite']['group']
end

template "#{node['nginx']['dir']}/conf.d/dokuen.conf" do
  source "nginx.erb"
end

service "nginx" do
  action :restart
end

template "/etc/sudoers.d/dokuen" do
  source "sudoers.erb"
  owner  "root"
  group  "root"
  mode   0440
end
