# PRIVATE CLASS: do not include directly
class sumo::service {
  if $::sumo::service_manage {
    service { $::sumo::service_name :
      ensure => $::sumo::service_ensure,
      enable => $::sumo::service_enable,
    }
  }
}
