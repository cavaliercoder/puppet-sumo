# PRIVATE CLASS: do not include directly
class sumo::params {
  $package_manage = true
  $package_name   = 'SumoCollector'
  $package_ensure = 'latest'

  $service_manage = true
  $service_name   = 'collector'
  $service_ensure = 'running'
  $service_enable = true

  $config_manage    = true
  $config_file      = '/opt/SumoCollector/config/user.properties'
  $config_sources_path   = '/etc/sumo.sources.d'
  $config_collector_name = $::fqdn
  $config_accessid  = undef
  $config_accesskey = undef
  $config_ephemeral = false

  # config for sources
  $config_timezone  = 'UTC'
}
