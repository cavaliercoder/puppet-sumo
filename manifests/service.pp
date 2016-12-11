# PRIVATE CLASS: do not include directly
class sumo::service {
  if $::sumo::service_manage {
    $unitfile = '/usr/lib/systemd/system/collector.service'

    file { $unitfile :
      ensure  => 'file',
      content => template("${module_name}/collector.service.erb"),
      owner   => 'root',
      group   => 'root',
      mode    => '0644',
      seluser => 'system_u',
      selrole => 'object_r',
      seltype => 'systemd_unit_file_t',
    }

    exec { 'reload collector unit file' :
      command     => '/bin/systemctl daemon-reload',
      refreshonly => true,
      subscribe   => File[$unitfile],
      notify      => Service[$::sumo::service_name],
    }

    service { $::sumo::service_name :
      ensure => $::sumo::service_ensure,
      enable => $::sumo::service_enable,
    }
  }
}
