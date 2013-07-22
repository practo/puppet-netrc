module Netrc =
  autoload xfm

  (* Define empty line *)
  let empty  = [ del /\n/ "\n" ]
  let indent = del /[ \t]+/ "  "
  let ws     = del /[ \t]+/ " "
  let eol    = del /\n/ "\n"
  let ws_eol = del /[ \t]*\n/ "\n"
  let val    = store /[^ \t\n]+/

  let comment = [ key "#" . store /[^\n]*/ . eol ]
  let machine = del /machine[ \t]+/ "machine " . key /[^ \t\n\/#]+/ . ws_eol

  let entry (kw:string) = [ indent . key kw . ws . val . ws_eol ]

  (* Define entries *)
  let entries = entry "login"
              | entry "password"

  (* Define record *)
  let record = [ machine . entries* ]

  (* Define lens *)
  let lns = ( record | empty | comment)*

  let filter = incl "/home/*/.netrc"
             . Util.stdexcl

  let xfm = transform lns filter
