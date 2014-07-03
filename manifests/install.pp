# == Class: prezto
#
# This is the prezto module. It installs prezto for a user and changes
# their shell to zsh. It has been tested under Ubuntu.
#
# prezto is a community-driven framework for managing your zsh configuration: https://github.com/sorin-ionescu/prezto
##
# === Parameters
#
#  None.
#
# === Examples
#
# class { 'prezto': }
# prezto::install { 'username': }
#
#
define prezto::install () {

  if $name == 'root' { $home = '/root' } else { $home = "/home/${name}" }
  $zprezto = "${home}/.zprezto"
  $runcoms = "${zprezto}/runcoms"

  user {"prezto for ${name}":
    shell => '/usr/bin/zsh'
  }

  file { $zprezto:
    ensure => directory,
    owner => $name,
    group => $name,
    recurse => true,
    source => "/home/zprezto/checkout"
  }

  file { "${home}/.zlogin":
    ensure  => symlink,
    target  => "${runcoms}/zlogin",
    require => File[$zprezto]
  }

  file { "${home}/.zlogout":
    ensure  => symlink,
    target  => "${runcoms}/zlogout",
    require => File[$zprezto]
  }

  file { "${home}/.zpreztorc":
    ensure  => symlink,
    target  => "${runcoms}/zpreztorc",
    require => File[$zprezto]
  }

  file { "${home}/.zprofile":
    ensure  => symlink,
    target  => "${runcoms}/zprofile",
    require => File[$zprezto]
  }

  file { "${home}/.zshenv":
    ensure  => symlink,
    target  => "${runcoms}/zshenv",
    require => File[$zprezto]
  }

  file { "${home}/.zshrc":
    ensure  => symlink,
    target  => "${runcoms}/zshrc",
    require => File[$zprezto]
  }

  file { "${zprezto}/.git":
    ensure => absent,
    require => File[$zprezto],
    force => true
  }
}
