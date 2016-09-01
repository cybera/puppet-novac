class novac::quotas::daemon {

  file { '/etc/init.d/nova-quotas':
    ensure => present,
    owner  => 'root',
    group  => 'root',
    mode   => '0755',
    source => 'puppet:///modules/novac/nova-quotas',
  }

  file { '/var/log/nova':
    ensure => directory,
  }

  file { '/var/log/nova/quotas.log':
    ensure  => present,
    require => File['/var/log/nova'],
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
