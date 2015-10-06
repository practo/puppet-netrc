class netrc::augeas { 
  if !defined(File['/usr/share/augeas/lenses/contrib/']) {
    file { /usr/share/augeas/lenses/contrib/:
      ensure  => directory,
      recurse => true,
      purge   => true,
      force   => true,
      mode    => '0644',
      owner   => 'root',
      group   => 'root'
    }
  }
  
  file { "/usr/share/augeas/lenses/contrib/php.aug":
    ensure  => present,
    source  => 'puppet:///modules/netrc/netrc.aug',
    require => File['/usr/share/augeas/lenses/contrib/']
  } 
}
