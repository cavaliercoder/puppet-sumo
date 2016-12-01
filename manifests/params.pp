# PRIVATE CLASS: do not include directly
class sumo::params {
  $package_manage = true
  $package_name   = 'SumoLogic'
  $package_ensure = 'latest'

  $service_manage = true
  $service_name   = 'collector'
  $service_ensure = 'running'
  $service_enable = true
}
