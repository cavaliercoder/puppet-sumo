# configure the agent to send 'SystemStats' such as CPU and memory usage and so on
# see: https://help.sumologic.com/Send_Data/Sources/03Use_JSON_to_Configure_Sources/JSON_Parameters_for_Installed_Sources
define sumo::hostmetrics (
  $source_name = 'Host_Metrics',
  $description = undef,
  $ensure      = 'present',
  $category    = undef, # prefer OS/Linux/Metrics
  $metrics     = ['CPU_User','CPU_Sys','Mem_Used'],
  $interval    = 10000, # ten seconds
) {
  validate_string($source_name)
  validate_array($metrics)
  validate_numeric($interval)

  $_source_name = downcase(regsubst($source_name, '[^a-zA-Z0-9]', ''))
  $_config_path = "${::sumo::sources_path}/${_source_name}.json"
  $_file_ensure = $ensure ? {
    'present' => 'file',
    'absent'  => 'absent',
  }

  file { $_config_path:
    ensure  => $_file_ensure,
    content => template("${module_name}/hostmetrics.json.erb"),
    owner   => 'root',
    group   => 'root',
    mode    => '0640',
    seluser => 'system_u',
    selrole => 'object_r',
    seltype => 'etc_t',
    notify  => Service[$::sumo::service_name],
  }
}
