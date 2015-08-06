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

  package { 'gulp':
    provider => 'npm',
    require  => Class['nodejs']
  }

  vcsrepo { '/opt/vector':
    ensure   => present,
    provider => git,
    source   => 'git://github.com/Netflix/vector.git',
  } -> Exec<||>

  exec{'bower install':
    command => 'bower install --config.interactive=false --allow-root',
    user    => 'root',
    cwd     => '/opt/vector',
    path    => ['/usr/local/node/node-default/bin/','/usr/bin/','/bin/'],
    require => Package['bower']
  }

  file{'/usr/bin/node':
    ensure  => link,
    target  => '/usr/local/node/node-default/bin/node',
    require => Class['nodejs']
  } ->

  exec{'npm install':
    command => 'npm install',
    user    => 'root',
    cwd     => '/opt/vector',
    path    => ['/usr/local/node/node-default/bin/','/usr/bin/','/bin/'],
    require => Package['gulp']
  }

  exec{'build':
    command => 'gulp build',
    user    => 'root',
    cwd     => '/opt/vector',
    path    => ['/usr/local/node/node-default/bin/','/usr/bin/','/bin/'],
    require => [Exec['bower install'], Exec['npm install']]
  }
}
