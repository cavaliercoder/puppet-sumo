# install local file source
# see: https://help.sumologic.com/Send_Data/Sources/03Use_JSON_to_Configure_Sources#Common_parameters_for_all_Source_types
define sumo::localfile (
  $source_name          = $name,
  $description          = undef,
  $ensure               = 'present',
  $category             = undef,
  $path_expression      = undef,
  $auto_date_parsing    = true,
  $auto_line_matching   = true,
  $multiline_processing = true,
  $force_timezone       = false,
  $timezone             = $::sumo::timezone,
  $filters              = [],
) {
  validate_string($source_name)
  validate_string($category)
  validate_string($path_expression)
  validate_array($filters)

  $filters.each |$filter| {
    validate_hash($filter)
    validate_string($filter['name'])
    validate_string($filter['filterType'])
    validate_string($filter['regexp'])
    if $filter['mask'] != undef {
      validate_string($filter['mask'])
    }
    if $filter['transparentForwarding'] != undef {
      validate_string($filter['transparentForwarding'])
    }
  }

  $_source_name = downcase(regsubst($source_name, '[^a-zA-Z0-9]', ''))
  $_config_path = "${::sumo::sources_path}/${_source_name}.json"
  $_file_ensure = $ensure ? {
    'present' => 'file',
    'absent'  => 'absent',
  }

  file { $_config_path:
    ensure  => $_file_ensure,
    content => template("${module_name}/localfile.json.erb"),
    owner   => 'root',
    group   => 'root',
    mode    => '0640',
    seluser => 'system_u',
    selrole => 'object_r',
    seltype => 'etc_t',
    notify  => Service[$::sumo::service_name],
    filters => $filters,
  }
}
