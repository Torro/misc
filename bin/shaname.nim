# Nim Shaname Utility
# Copyright (c) 2018 Torro
# 
# See the file "copying.txt" included in this
# directory for details about the copyright.

import parseopt, strutils, algorithm, sha1, os

const
  Version = "0.1.0"
  Usage = "shaname v" & Version & ", rename files to their sha1sums" & """


Usage: shaname FILE [FILE]...

  -h, --help        shows this help
  -v, --version     shows the version

Copyright (c) 2018 Torro
"""

var
  filenames: seq[string] = @[]
  extension: string
  newfilename: string

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
    filenames.add(key)
  of cmdLongOption, cmdShortOption:
    case key
    of "help", "h": writeHelp()
    of "version", "v": writeVersion()
  of cmdEnd: assert(false)
if filenames.len == 0:
  writeHelp()
else:
  for filename in filenames:
    extension = split(filename, '.').reversed()[0]
    newfilename = $(secureHashFile(filename)) & "." & extension

    moveFile(filename, newfilename)
