class novac (
  $ensure     = $::novac::params::ensure,
  $branch     = $::novac::params::branch,
  $sudo_users = [],
) inherits novac::params {

  Package<| tag == 'novac-packages' |> -> Package<| tag == 'novac-gems' |>

  $::novac::params::packages.each |$package, $version| {
    package { $package:
      ensure => $version,
      tag    => 'novac-packages',
    }
  }

  $::novac::params::gems.each |$gem, $version| {
    package { $gem:
      ensure   => $version,
      provider => 'gem',
      tag      => 'novac-gems',
    }
  }

  file { '/etc/novac':
    ensure => directory,
    owner  => 'root',
    group  => 'root',
    mode   => '0750',
  }

  file { '/etc/novac/config.ini':
    ensure  => present,
    owner   => $owner,
    group   => $group,
    mode    => '0640',
    require => File['/etc/novac'],
  }

  vcsrepo { '/root/novac':
    ensure   => $ensure,
    provider => git,
    source   => 'https://github.com/cybera/novac',
    revision => $branch,
  }

  file { '/etc/sudoers.d/novac':
    ensure => present,
    owner  => 'root',
    group  => 'root',
    mode   => '0440',
  }

  $sudo_users.each |$user| {
    file_line { "/etc/sudoers.d/novac ${user}":
      path    => '/etc/sudoers.d/novac',
      line    => "${user} ALL = NOPASSWD: /root/novac/bin/novac",
      require => File['/etc/sudoers.d/novac'],
    }
  }

  file_line { '/root/.bashrc novac path':
    path => '/root/.bashrc',
    line => 'PATH=$PATH:/root/novac/bin',
  }

  Ini_setting<<| tag == 'novac' |>>

}
