class novac::quotas::daemon {

  file { '/etc/init.d/nova-quotas':
    ensure => present,
    owner  => 'root',
    group  => 'root',
    mode   => '0755',
    source => 'puppet:///modules/novac/nova-quotas',
  }

  service { 'nova-quotas':
    ensure     => running,
    enable     => true,
    hasstatus  => false,
    hasrestart => false,
    status     => 'ps aux | grep quota-daemon | grep -v grep',
    require    => File['/etc/init.d/nova-quotas'],
  }

}
