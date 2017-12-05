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
    provider   => 'init',
    ensure     => running,
    enable     => true,
    hasstatus  => false,
    hasrestart => false,
    pattern    => '/root/novac/libexec/novac-quota-daemon',
    require    => File['/etc/init.d/nova-quotas'],
  }

}
