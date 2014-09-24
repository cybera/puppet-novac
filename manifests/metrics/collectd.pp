class novac::metrics::collectd {

  ensure_packages(['socat'], { ensure => latest })

  # Import users' daily cloud usage
  cron { 'cloud user resource metrics':
    command     => 'novac cloud-user-metrics | socat - UNIX-CLIENT:/var/run/collectd-unixsock > /dev/null',
    environment => 'PATH=/bin:/usr/bin:/sbin:/usr/sbin:/root/novac/bin',
    user        => 'root',
    minute      => 0,
    hour        => 1,
  }

  # instance metrics cron
  cron { 'cloud instance usage metrics':
    command     => 'novac cloud-instance-metrics 2> /dev/null',
    environment => 'PATH=/bin:/usr/bin:/sbin:/usr/sbin:/root/novac/bin',
    user        => 'root',
    minute      => '*/10',
  }

  # instance metrics to graphite cron
  cron { 'import cloud instance usage metrics to collectd':
    command     => 'novac cloud-instance-metrics-collectd  | socat - UNIX-CLIENT:/var/run/collectd-unixsock > /dev/null',
    environment => 'PATH=/bin:/usr/bin:/sbin:/usr/sbin:/root/novac/bin',
    user        => 'root',
    minute      => '5',
    hour        => '*',
  }

}
