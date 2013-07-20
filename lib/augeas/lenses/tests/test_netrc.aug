module Test_netrc =
  let conf ="machine example.com
  login root
  password yolo

machine example.org
  login admin
  password 12345
"

  test Netrc.lns get conf =
    { "1"
      { "machine"  = "example.com" }
      { "login"    = "root" }
      { "password" = "yolo" } }
    { }
    { "2"
      { "machine"  = "example.org" }
      { "login"    = "admin" }
      { "password" = "12345" } }
