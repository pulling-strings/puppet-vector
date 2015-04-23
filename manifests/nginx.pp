# Setting up vector vhost
class vector::nginx {
  include ::nginx

  nginx::resource::vhost { $::hostname:
    ensure   => present,
    www_root => '/opt/vector',
    require  => Class['vector::install']
  }

}
