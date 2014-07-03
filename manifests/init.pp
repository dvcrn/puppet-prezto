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
# class { 'prezto': }
#
# prezto::install { 'username':
#   repo = 'git://github.com/sorin-ionescu/prezto.git'
# }
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
}
