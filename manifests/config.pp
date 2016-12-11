# PRIVATE CLASS: do not include directly
class sumo::config inherits sumo {
  if $::sumo::config_manage {
    file { $::sumo::sources_path :
      ensure  => 'directory',
      owner   => 'root',
      group   => 'root',
      mode    => '0750',
      seluser => 'system_u',
      selrole => 'object_r',
      seltype => 'etc_t',
    }

    file { $::sumo::config_file :
      ensure  => 'file',
      content => template("${module_name}/user.properties.erb"),
      owner   => 'root',
      group   => 'root',
      mode    => '0640',
      seluser => 'system_u',
      selrole => 'object_r',
      seltype => 'usr_t',
      notify  => Service[$::sumo::service_name],
    }
  }
}