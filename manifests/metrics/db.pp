class novac::metrics::db (
  $mysql_user,
  $mysql_password,
  $mysql_host,
) {

  # instance metrics database
  file { '/etc/novac/instance_metrics.sql':
    ensure => present,
    owner  => 'root',
    group  => 'root',
    mode   => '0640',
    source => 'puppet:///modules/novac/metrics/instance_metrics.sql',
  }

  mysql::db { 'instance_metrics':
    user     => $mysql_user,
    password => $mysql_password,
    host     => $mysql_host,
    sql      => '/etc/novac/instance_metrics.sql',
    require  => File['/etc/novac/instance_metrics.sql'],
  }

}
