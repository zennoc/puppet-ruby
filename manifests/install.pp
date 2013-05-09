# = Define: ruby::install
#
# This define runs a bundle install on the defined Gemfile
# whose content may be directly provided.
# The bundle content is provided either with $source or $content arguments.
# If not defined bundle install is executed on the defined path
#
# Automatic execution of bundle install via Puppet is managed by the $autorun
# parameter (default: true).
# Conditional execution of bundle install at subsequent puppet runs is
# defined by the $refreshonly, $creates, $unless $onlyif parameters
# that map the omonimous exec type arguments.
#
# == Parameters:
#
# [*install_path*]
#   String. Required.
#   Defines the directory path where to execute bunde install and
#   eventually create the Gemfile
#
# [*source*]
#   String. Optional. Default: undef. Alternative to content.
#   Source of the Gemfile to install
#   Sample: source => 'puppet:///modules/site/my_app/Gemfile',
#
# [*content*]
#   String. Optional. Default: undef. Alternative to source.
#   Content of the Gemfile to install
#   This parameter is alternative to source.
#   Sample: content => 'template(site/my_app/Gemfile.erb'),
#
# [*parameters*]
#   String. Optional. Default: ''
#   Optional parameters to pass to bundle install when executing it.
#
# [*autorun*]
#   Boolean. Default: true.
#   Define if to automatically execute bundle install when Puppet runs.
#
# [*refreshonly*]
#   Boolen. Optional. Default: true
#   Defines the logic of execution of bundle install when Puppet runs.
#   Maps to the omonymous Exec type argument.
#
# [*creates*]
#   String. Optional. Default: undef
#   Defines the logic of execution of bundle install when Puppet runs.
#   Maps to the omonymous Exec type argument.
#
# [*onlyif*]
#   String. Optional. Default: undef
#   Defines the logic of execution of bundle install when Puppet runs.
#   Maps to the omonymous Exec type argument.
#
# [*unless*]
#   String. Optional. Default: undef
#   Defines the logic of execution of bundle install when Puppet runs.
#   Maps to the omonymous Exec type argument.
#
# [*owner*]
#   Owner of the created Gemfile. Default: root.
#
# [*group*]
#   Group of the created Gemfile. Default: root.
#
# [*mode*]
#   Mode of the created Gemfile. Default: '0644'.
#
# [*ensure*]
#   Default: present.
#
# == Examples
#
# - Minimal setup
# ruby::install { 'my_script':
#   path             => '/opt/my_app',
#   source           => 'puppet:///modules/site/my_app/Bundler',
# }
#
define ruby::install (
  $install_path,
  $source           = undef,
  $content          = undef,
  $parameters       = '',
  $autorun          = true,
  $refreshonly      = true,
  $creates          = undef,
  $onlyif           = undef,
  $unless           = undef,
  $owner            = 'root',
  $group            = 'root',
  $mode             = '0755',
  $path             = '/bin:/sbin:/usr/bin:/usr/sbin',
  $ensure           = 'present' ) {

  include ruby

$file_notify = $autorun ? {
    true => Exec["bundle_install_${name}"],
    default => undef,
  }
  if $content or $source {
    file { "Gemfile_${name}":
      ensure  => $ensure,
      path    => "${install_path}/Gemfile",
      mode    => $mode,
      owner   => $owner,
      group   => $group,
      content => $content,
      source  => $source,
      notify  => $file_notify,
    }
  }

  if $autorun == true {
    exec { "bundle_install_${name}":
      command     => 'bundle install',
      cwd         => $install_path,
      refreshonly => $refreshonly,
      creates     => $creates,
      onlyif      => $onlyif,
      unless      => $unless,
      path        => $path,
    }
  }

}
