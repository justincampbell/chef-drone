include_recipe 'drone::_docker'

docker_image 'drone' do
  repo 'drone/drone'
  tag node['drone']['version']
  action :pull
end

docker_container 'drone' do
  repo 'drone/drone'
  tag node['drone']['version']
  port '80:8000'
  env drone_env
  volumes ['/var/lib/drone:/var/lib/drone', '/var/run/docker.sock:/var/run/docker.sock']
  restart_policy 'always'
  sensitive true
end
