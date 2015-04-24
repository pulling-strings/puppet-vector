# Setting up pcp for Vector
class vector::pcp(
  $from= undef,
  $port = '44323'
) {

  validate_string($from)

  package{['pcp', 'pcp-webapi']:
    ensure  => present
  }

  include ufw

  ufw::allow { 'pcp webui':
    from => $from,
    port => $port,
    ip   => 'any'
  }

  
  
}
