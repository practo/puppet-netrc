class netrc::setup(
  $user,
  $file,
) {

  file { $file:
    mode  => '0600',
    owner => $user,
    group => $user,
  }

}
