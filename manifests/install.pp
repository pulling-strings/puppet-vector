# Clone and run bower
class vector::install {
  class { 'nodejs':
    version      => 'stable',
    make_install => false,
  }

  package { 'bower':
    provider => 'npm',
    require  => Class['nodejs']
  }

  vcsrepo { '/opt/vector':
    ensure   => present,
    provider => git,
    source   => 'git://github.com/Netflix/vector.git',
  }

  exec{'install deps':
    command => 'bower install --config.interactive=false --allow-root',
    user    => 'root',
    cwd     => '/opt/vector',
    path    => ['/usr/local/node/node-default/bin/','/usr/bin/','/bin/'],
    require => [Package['bower'], Vcsrepo['/opt/vector']]
  }

}
