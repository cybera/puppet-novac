class novac::quotas {

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

  cron { 'nova-quotas sync':
    command     => 'sleep 15; novac quota-sync',
    environment => 'PATH=/bin:/usr/bin:/sbin:/usr/sbin:/root/novac/bin',
    user        => 'root',
    minute      => ['28','56'],
    require     => Class['novac'],
  }

  cron { 'nova-quotas sync usage':
    command     => 'novac quota-sync-usage',
    environment => 'PATH=/bin:/usr/bin:/sbin:/usr/sbin:/root/novac/bin',
    user        => 'root',
    minute      => '*/6',
    require     => Class['novac'],
  }
}
