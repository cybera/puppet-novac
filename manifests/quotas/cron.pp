class novac::quotas::cron {

  cron { 'nova-quotas sync':
    command     => 'sleep 15; novac quota-sync',
    environment => 'PATH=/bin:/usr/bin:/sbin:/usr/sbin:/root/novac/bin',
    user        => 'root',
    minute      => 12,
    hour        => '*/2',
    require     => Class['novac'],
  }

  cron { 'nova-quotas sync usage':
    command     => 'novac quota-sync-usage',
    environment => 'PATH=/bin:/usr/bin:/sbin:/usr/sbin:/root/novac/bin',
    user        => 'root',
    minute      => 32,
    hour        => '*/3',
    require     => Class['novac'],
  }
}
