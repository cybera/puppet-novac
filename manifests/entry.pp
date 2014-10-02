define novac::entry (
  $file = '/etc/novac/config.ini',
  $server,
  $location,
  $config,
) {

  $config.each |$database, $database_info| {
    $database_info.each |$k, $v| {
      @@ini_setting { "${server} ${file} ${location} ${database} ${k} = ${v}":
        path    => $file,
        section => $database,
        setting => $k,
        value   => $v,
        require => File[$file],
        tag     => ['novac', $location],
      }
    }
  }
}
