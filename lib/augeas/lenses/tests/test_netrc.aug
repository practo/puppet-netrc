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
    { "node"
      { "machine"  = "example.com" }
      { "login"    = "root" }
      { "password" = "yolo" } }
    { }
    { "node"
      { "machine"  = "example.org" }
      { "login"    = "admin" }
      { "password" = "12345" } }
    { }
    { "node"
      { "#" = "this is a comment" } }
    { "node"
      { "machine"  = "m" }
      { "login"    = "l" }
      { "password" = "p" } }
