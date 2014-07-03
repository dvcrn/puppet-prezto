# == Class: prezto
#
# This is the prezto module. It installs prezto for a user and changes
# their shell to zsh. It has been tested under Ubuntu.
#
# prezto is a community-driven framework for managing your zsh configuration: https://github.com/sorin-ionescu/prezto
#
# === Parameters
#
#   [*git_repo*]
#     Set which prezto git repo to download
#     Default: git://github.com/sorin-ionescu/prezto.git
#
# === Examples
#
# class { 'prezto':
#   repo => 'git://github.com/sorin-ionescu/prezto.git'
# }
# prezto::install { 'username': }
#
#
class prezto ($repo = 'git://github.com/sorin-ionescu/prezto.git') {

  if(!defined(Package['git'])) {
    package { 'git':
      ensure => present,
    }
  }

  if(!defined(Package['zsh'])) {
    package { 'zsh':
      ensure => present
    }
  }

  user { ['zprezto']:
      ensure => 'present',
      home => "/home/zprezto",
      managehome => true,
      password => '!',
  }

  vcsrepo { "/home/zprezto/checkout":
    ensure => present,
    provider => git,
    source => $repo,
    revision => 'master',
    require => [
      Package['zsh'],
      Package['git'],
      File['/home/zprezto/.ssh']
    ],
    force => true,
    user => 'zprezto'
  }

}
