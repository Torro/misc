# Copyright (c) 2020 Torro
# 
# See the file "copying.txt" included in this
# directory for details about the copyright.
import parseopt, uri


const
  Version = "0.1.0"
  Usage = "decurl v" & Version & ", rename files to their sha1sums" & """

Usage: shaname "string" ["string"]...

  -d, --decode			decode url (default)
  -e, --encode			encode url

  -h, --help        shows this help
  -v, --version     shows the version

Copyright (c) 2020 Torro
"""

var
  uris: seq[string] = @[]
  encode: bool = false

proc writeHelp() =
  stdout.write(Usage)
  stdout.flushFile()
  quit(0)

proc writeVersion() =
  stdout.write(Version & "\n")
  stdout.flushFile()
  quit(0)


for kind, key, val in getopt():
  case kind
  of cmdArgument:
    uris.add(key)
  of cmdLongOption, cmdShortOption:
    case key
    of "encode", "e":
      encode = true
    of "help", "h": writeHelp()
    of "version", "v": writeVersion()
  of cmdEnd: assert(false)

if uris.len == 0:
  writeHelp()
else:
  for uri in uris:
    echo ""
    if encode:
      echo encodeUrl(uri)
    else:
      echo decodeUrl(uri, decodePlus = false)
  echo ""
