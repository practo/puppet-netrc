define netrc(
  $user,
  $password,

  $machine = $name,
  $login   = $user,
  $file    = "/home/${user}/.netrc",
) {

  augeas { "Add ${machine} netrc entry":
    lens    => 'Netrc',
    incl    => $file,
    context => "/files${file}",
    changes => [
      "set *[machine = '${machine}']/machine ${machine}",
      "set *[machine = '${machine}']/login ${login}",
      "set *[machine = '${machine}']/password ${password}",
    ],
  }

}
