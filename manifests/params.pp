class novac::params {

  $ensure = 'latest'
  $branch = 'master'

  case $lsbdistcodename {
    'precise': {
      $gems = {
        'amq-protocol'   => '1.9.2',
        'amqp'           => '1.5.0',
        'json'           => '1.8.1',
        'mysql2'         => 'present',
        'terminal-table' => 'present',
        'eventmachine'   => 'present',
        'sequel'         => 'present',
        'inifile'        => 'present',
        'parallel'       => 'present',
      }

      $packages = {
        'libmysqlclient-dev' => 'present',
        'build-essential'    => 'present',
        'ruby-dev'           => 'present',
      }

    }

    'trusty': {
      $gems = {
        'amq-protocol'   => '1.9.2',
        'amqp'           => '1.5.0',
        'json'           => '1.8.1',
        'mysql2'         => 'present',
        'terminal-table' => 'present',
        'eventmachine'   => 'present',
        'sequel'         => 'present',
        'inifile'        => 'present',
        'parallel'       => 'present',
      }

      $packages = {
        'libmysqlclient-dev' => 'present',
        'build-essential'    => 'present',
        'ruby-dev'           => 'present',
      }
    }
  }

}
