define netrc(
  $user,
  $password,

  $machine = $name,
  $login   = $user,
  $file    = "/home/${user}/.netrc",
) {

  Augeas {
    lens    => 'Netrc.lns',
    incl    => $file,
    context => "/files${file}",
  }

  augeas {
    "Set ${machine} netrc login for ${user}":
      changes => "set ${machine}/login ${login}",
      onlyif  => "match ${machine}[login='${login}']/login size == 0",
      before  => File[$file];
    "Set ${machine} netrc password for ${user}":
      changes => "set ${machine}/password ${password}",
      onlyif  => "match ${machine}[password='${password}']/password size == 0",
      before  => File[$file];
  }

  ensure_resource('file', $file, {'mode' => '0600', 'owner' => $user, 'group' => $user})

}
