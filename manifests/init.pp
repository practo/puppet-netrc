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
    "Add ${machine} netrc entry for ${user}":
      changes => [
        "ins ${machine} after *[last()]",
        "set ${machine}/login ${login}",
        "set ${machine}/password ${password}",
      ],
      onlyif => "match ${machine} size == 0";
    "Update ${machine} netrc entry for ${user}":
      changes => [
        "set ${machine}/login ${login}",
        "set ${machine}/password ${password}",
      ],
      onlyif => "match ${machine} size == 1";
  }

}
