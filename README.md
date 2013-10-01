# Puppet module: ruby

This is a Puppet module for ruby
It provides only package installation and management

Based on Example42 layouts by Alessandro Franceschi / Lab42

Official site: http://www.example42.com

Official git repository: http://github.com/example42/puppet-ruby

Module development sponsored by [AllOver.IO](http://www.allover.io)

Released under the terms of Apache 2 License.

This module requires the presence of Example42 Puppi module in your modulepath.


## USAGE - Basic management

* Install ruby with default settings

        class { 'ruby': }

* Install a specific version of ruby package

        class { 'ruby':
          version => '1.0.1',
        }

* Install ruby compiling from uptream source. You have to provide a correct version (as available on ftp://ftp.ruby-lang.org/pub/ruby/ ). Note that this will install various prerequite packages and will take some time. Installs ruby to /usr/local/bin

        class { 'ruby':
          version             => '1.9.3-p392',
          compile_from_source => true,
        }


* Remove ruby resources

        class { 'ruby':
          absent => true
        }

* Module dry-run: Do not make any change on *all* the resources provided by the module

        class { 'ruby':
          noops => true
        }

* Automatically include a custom subclass

        class { 'ruby':
          my_class => 'example42::my_ruby',
        }


## TESTING
[![Build Status](https://travis-ci.org/example42/puppet-ruby.png?branch=master)](https://travis-ci.org/example42/puppet-ruby)
