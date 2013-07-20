module Netrc =
  autoload xfm

  (* Define empty line *)
  let empty  = [ del /\n/ "\n" ]
  let indent = del /[ \t]+/ "  "
  let ws     = del /[ \t]+/ " "
  let ows    = del /[ \t]*/ ""
  let eol    = del /[ \t]*\n/ "\n"
  let val    = store /[^ \t\n]+/

  let machine = [ key "machine" . ws . val . eol]

  let entry (kw:string) = [ indent . key kw . ws . val . eol ]

  (* Define entries *)
  let attributes = entry "login"
                 | entry "password"

  let entries = machine . attributes+

  (* Define record *)
  let record = [ seq "record" . entries ]

  (* Define lens *)
  let lns = ( record | empty)*

  let filter = incl (Sys.getenv("HOME") . "/.netrc")
             . Util.stdexcl

  let xfm = transform lns filter
