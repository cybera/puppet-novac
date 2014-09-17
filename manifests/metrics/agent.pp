class novac::metrics::agent {

  file { '/usr/local/bin/instance_metrics.rb':
    ensure => present,
    owner  => 'root',
    group  => 'root',
    mode   => '0750',
    source => 'puppet:///modules/novac/metrics/instance_metrics.rb',
  }

}
