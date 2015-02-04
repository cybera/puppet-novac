class novac (
  $ensure = $::novac::params::ensure,
  $branch = $::novac::params::branch,
  $config = {},
) inherits novac::params {

  Package<| tag == 'novac-packages' |> -> Package<| tag == 'novac-gems' |> -> Package<| tag == 'novac-pip' |>

  ensure_packages(
    $::novac::params::packages,
    { tag => 'novac-packages' }
  )

  ensure_packages(
    $::novac::params::gems,
    { provider => 'gem', tag => 'novac-gems' }
  )

  ensure_packages(
    $::novac::params::eggs,
    { provider => 'pip', tag => 'novac-pip' }
  )

  file { '/etc/novac':
    ensure => directory,
    owner  => 'root',
    group  => 'root',
    mode   => '0750',
  }

  file { '/etc/novac/config.ini':
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => '0640',
    require => File['/etc/novac'],
  }

  vcsrepo { '/root/novac':
    ensure   => $ensure,
    provider => git,
    source   => 'http://github.com/cybera/novac',
    revision => $branch,
  }

  file_line { '/root/.bashrc novac path':
    path => '/root/.bashrc',
    line => 'PATH=$PATH:/root/novac/bin',
  }

  $config.each |$database, $database_info| {
    $database_info.each |$k, $v| {
      ini_setting { "/etc/novac/config.ini ${database} ${k} = ${v}":
        path    => '/etc/novac/config.ini',
        section => $database,
        setting => $k,
        value   => $v,
        require => File['/etc/novac/config.ini'],
      }
    }
  }

}
