class novac::api_reports::cron {

  cron { 'novac api reports raw':
    command     => "novac dair-api-report-raw >/dev/null",
    environment => 'PATH=/bin:/usr/bin:/sbin:/usr/sbin:/root/novac/bin',
    user        => 'root',
    minute      => '7',
    hour        => '*',
  }

  cron { 'novac api reports mysql':
    command     => "novac dair-api-report-mysql && novac dair-api-report-summary > /dev/null",
    environment => 'PATH=/bin:/usr/bin:/sbin:/usr/sbin:/root/novac/bin',
    user        => 'root',
    minute      => '10',
    hour        => '*',
  }

}
