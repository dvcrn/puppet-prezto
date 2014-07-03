# == Class: prezto
#
# This is the prezto module. It installs prezto for a user and changes
# their shell to zsh. It has been tested under Ubuntu.
#
# prezto is a community-driven framework for managing your zsh configuration: https://github.com/sorin-ionescu/prezto
##
# === Parameters
#
#   [*repo*]
#     Set which prezto git repo to download
#     Default: git://github.com/sorin-ionescu/prezto.git
#
# === Examples
#
# class { 'prezto': }
#
# prezto::install { 'username':
#   repo = 'git://github.com/sorin-ionescu/prezto.git'
# }
#
#
define prezto::install ($repo = 'git://github.com/sorin-ionescu/prezto.git') {

  if $name == 'root' { $home = '/root' } else { $home = "/home/${name}" }
  $zprezto = "${home}/.zprezto"
  $runcoms = "${zprezto}/runcoms"


  if(!defined(User[$name])) {
    user {"shell change for ${name}":
      name => $name,
      shell => '/usr/bin/zsh'
    }
  }

  vcsrepo { $zprezto:
    ensure => present,
    provider => git,
    source => $repo,
    revision => 'master',
    require => [
      Package['zsh'],
      Package['git']
    ],
    force => true,
    user => $name
  }

  file { "${home}/.zlogin":
    ensure  => symlink,
    target  => "${runcoms}/zlogin",
    require => Vcsrepo[$zprezto]
  }

  file { "${home}/.zlogout":
    ensure  => symlink,
    target  => "${runcoms}/zlogout",
    require => Vcsrepo[$zprezto]
  }

  file { "${home}/.zpreztorc":
    ensure  => symlink,
    target  => "${runcoms}/zpreztorc",
    require => Vcsrepo[$zprezto]
  }

  file { "${home}/.zprofile":
    ensure  => symlink,
    target  => "${runcoms}/zprofile",
    require => Vcsrepo[$zprezto]
  }

  file { "${home}/.zshenv":
    ensure  => symlink,
    target  => "${runcoms}/zshenv",
    require => Vcsrepo[$zprezto]
  }

  file { "${home}/.zshrc":
    ensure  => symlink,
    target  => "${runcoms}/zshrc",
    require => Vcsrepo[$zprezto]
  }
}
