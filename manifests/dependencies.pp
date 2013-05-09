# Class: ruby::dependencies
#
# This class installs ruby prerequisites
#
# == Usage
#
# This class is not intended to be used directly.
# It's automatically included by ruby if the parameter
# install_prerequisites is set to true
# Note: This class may contain resources available on the
# Example42 modules set
#
class ruby::dependencies {
  include ruby
  include ruby::rubygems

/*
  if ! defined(Package['rubygems']) {
    package { 'rubygems':
      ensure   => present,
    }
  }

  if ! defined(Package['ruby-devel']) {
    package { 'ruby-devel':
      ensure   => present,
    }
  }
*/
}
