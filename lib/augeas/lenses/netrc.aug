module Netrc =
  autoload xfm

  (* Define empty line *)
  let empty  = [ del /\n/ "\n" ]
  let indent = del /[ \t]+/ "  "
  let ws     = del /[ \t]+/ " "
  let ows    = del /[ \t]*/ ""
  let eol    = del /\n/ "\n"
  let ws_eol = del /[ \t]*\n/ "\n"
  let val    = store /[^ \t\n]+/

  let comment = [ key "#" . store /[^\n]*/ . eol ]

  let machine = [ key "machine" . ws . val . ws_eol]

  let entry (kw:string) = [ indent . key kw . ws . val . ws_eol ]

  (* Define entries *)
  let attributes = entry "login"
                 | entry "password"

  let section = machine . attributes+

  let entries = section
              | comment

  (* Define record *)
  let record = [ seq "record" . entries ]

  (* Define lens *)
  let lns = ( record | empty)*

  let filter = incl "/home/*/.netrc"
             . Util.stdexcl

  let xfm = transform lns filter
