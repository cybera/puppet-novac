class novac::params {

  $ensure = 'latest'
  $branch = 'master'

  case $lsbdistcodename {
    'precise': {
      $gems = ['amqp', 'mysql2', 'terminal-table', 'eventmachine', 'json', 'sequel', 'inifile', 'parallel']
      $packages = ['libmysqlclient-dev', 'build-essential', 'ruby-dev']
    }

    'trusty': {
      $gems = ['amqp', 'terminal-table', 'eventmachine', 'json', 'sequel', 'inifile', 'parallel']
      $packages = ['ruby-mysql2', 'ruby-dev', 'build-essential']
    }
  }

}
