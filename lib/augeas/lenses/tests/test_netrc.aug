module Test_netrc =
  let conf ="machine example.com
  login root
  password yolo

machine example.org
  login admin
  password 12345

#this is a comment
machine m
  login l
  password p
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
    { }
    { "3"
      { "#" = "this is a comment" } }
    { "4"
      { "machine"  = "m" }
      { "login"    = "l" }
      { "password" = "p" } }
