# PRIVATE CLASS: do not include directly
class sumo::install {
  if $::sumo::package_manage {
    package { $::sumo::package_name :
      ensure => $::sumo::package_ensure,
    }
  }
}
