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
    { "example.com"
      { "login"    = "root" }
      { "password" = "yolo" } }
    { }
    { "example.org"
      { "login"    = "admin" }
      { "password" = "12345" } }
    { }
    { "#" = "this is a comment" }
    { "m"
      { "login"    = "l" }
      { "password" = "p" } }
