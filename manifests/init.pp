# = Class: ruby
#
# This is the main ruby class
#
#
# == Parameters
#
# [*dependencies_class*]
#   The name of the class that installs dependencies and prerequisite
#   resources needed by this module.
#   Default is $ruby::dependencies which uses Example42 modules.
#   Set to '' to not install any dependency (you must provide what's
#   defined in graylog2/manifests/dependencies.pp in some way).
#   Set directy the name of a custom class to manage there the dependencies
#
# [*provider*]
#   The Puppet provider to use to install bundle package
#   Default: gem
#   Set to undef to leave Puppet decide
#
# [*my_class*]
#   Name of a custom class to autoload to manage module's customizations
#   If defined, ruby class will automatically "include $my_class"
#   Can be defined also by the (top scope) variable $ruby_myclass
#
# [*version*]
#   The package version, used in the ensure parameter of package type.
#   Default: present. Can be 'latest' or a specific version number.
#   Note that if the argument absent (see below) is set to true, the
#   package is removed, whatever the value of version parameter.
#
# [*absent*]
#   Set to 'true' to remove package(s) installed by module
#   Can be defined also by the (top scope) variable $ruby_absent
#
# [*noops*]
#   Set noop metaparameter to true for all the resources managed by the module.
#   Basically you can run a dryrun for this specific module if you set
#   this to true. Default: false
#
# Default class params - As defined in ruby::params.
# Note that these variables are mostly defined and used in the module itself,
# overriding the default values might not affected all the involved components.
# Set and override them only if you know what you're doing.
# Note also that you can't override/set them via top scope variables.
#
# [*package*]
#   The name of ruby package
#
# == Examples
#
# You can use this class in 2 ways:
# - Set variables (at top scope level on in a ENC) and "include ruby"
# - Call ruby as a parametrized class
#
# See README for details.
#
#
class ruby (
  $dependencies_class  = params_lookup( 'dependencies_class' ),
  $provider            = params_lookup( 'provider' ),
  $my_class            = params_lookup( 'my_class' ),
  $version             = params_lookup( 'version' ),
  $absent              = params_lookup( 'absent' ),
  $noops               = params_lookup( 'noops' ),
  $package             = params_lookup( 'package' )
  ) inherits ruby::params {

  $bool_absent=any2bool($absent)
  $bool_noops=any2bool($noops)

  ### Definition of some variables used in the module
  $manage_package = $ruby::bool_absent ? {
    true  => 'absent',
    false => $ruby::version,
  }

  ### Managed resources
  if $ruby::dependencies_class != '' {
    include $ruby::dependencies_class
  }

  if ! defined(Package[$ruby::package]) {
    package { $ruby::package:
      ensure   => $ruby::manage_package,
      provider => $ruby::provider,
      noop     => $ruby::bool_noops,
    }
  }

  ### Include custom class if $my_class is set
  if $ruby::my_class {
    include $ruby::my_class
  }

}
