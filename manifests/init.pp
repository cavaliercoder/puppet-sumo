# Class: sumo
# ===========================
#
# Full description of class sumo here.
#
# Parameters
# ----------
#
# Document parameters here.
#
# * `sample parameter`
# Explanation of what this parameter affects and what it defaults to.
# e.g. "Specify one or more upstream ntp servers as an array."
#
# Variables
# ----------
#
# Here you should define a list of variables that this module would require.
#
# * `sample variable`
#  Explanation of how this variable affects the function of this class and if
#  it has a default. e.g. "The parameter enc_ntp_servers must be set by the
#  External Node Classifier as a comma separated list of hostnames." (Note,
#  global variables should be avoided in favor of class parameters as
#  of Puppet 2.6.)
#
# Examples
# --------
#
# @example
#    class { 'sumo':
#      servers => [ 'pool.ntp.org', 'ntp.local.company.com' ],
#    }
#
# Authors
# -------
#
# Author Name <author@domain.com>
#
# Copyright
# ---------
#
# Copyright 2016 Your name here, unless otherwise noted.
#
class sumo (
  $package_manage = $::sumo::params::package_manage,
  $package_name   = $::sumo::params::package_name,
  $package_ensure = $::sumo::params::package_ensure,

  $service_manage = $::sumo::params::service_manage,
  $service_name   = $::sumo::params::service_name,
  $service_ensure = $::sumo::params::service_ensure,
  $service_enable = $::sumo::params::service_enable,
) inherits sumo::params {
  class { '::sumo::install' : } ->
  class { '::sumo::service' : }
}
