define netrc(
  $sysuser,
  $user,
  $password,

  $machine = $name,
  $login   = $user,
  $file    = "/home/${sysuser}/.netrc",
) {

  class { 'netrc::setup':
    file => $file,
    user => $user,
  }

  class {'netrc::augeas':
  }

  Augeas {
    lens    => 'Netrc.lns',
    incl    => $file,
    context => "/files${file}",
  }

  augeas {
    "Set ${machine} netrc login for ${sysuser}":
      changes => "set ${machine}/login ${login}",
      onlyif  => "match ${machine}[login='${login}']/login size == 0",
      before  => File[$file];
    "Set ${machine} netrc password for ${sysuser}":
      changes => "set ${machine}/password ${password}",
      onlyif  => "match ${machine}[password='${password}']/password size == 0",
      before  => File[$file];
  }

}
