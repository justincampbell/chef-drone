include_recipe 'chef-vault::default'
include_recipe 'drone::_docker'

docker_image 'agent' do
  repo node['drone']['repo']
  tag node['drone']['version']
end

docker_container 'agent' do
  repo node['drone']['repo']
  tag node['drone']['version']
  command 'agent'
  env agent_env
  volumes node['drone']['agent']['volumes']
  network_mode node['drone']['agent']['network_mode'] if node['drone']['agent']['network_mode']
  restart_policy 'always'
  detach true
  log_driver node['drone']['docker']['log_driver'] if node['drone']['docker']['log_driver']
  log_opts node['drone']['docker']['log_opts']
  sensitive true
end
