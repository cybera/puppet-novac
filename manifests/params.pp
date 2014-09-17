class novac::params {

  $ensure   = 'latest'
  $revision = 'dev'

  case $lsbdistcodename {
    'precise': {
      $gems = ['amqp', 'mysql2', 'terminal-table', 'eventmachine', 'json', 'sequel', 'inifile']
      $packages = ['libmysqlclient-dev', 'build-essential', 'ruby-dev']
    }

    'trusty': {
      $gems = ['amqp', 'terminal-table', 'eventmachine', 'json', 'sequel', 'inifile']
      $packages = ['ruby-mysql2', 'ruby-dev', 'build-essential']
    }
  }

}