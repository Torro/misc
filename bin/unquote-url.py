#!/usr/bin/python3
# unquote-url.py - decode percent encoded strings
#
# Copyright (c) 2018 Torro
# See the file "copying.txt" included in this
# directory for details about the copyright.
import sys
import urllib.parse

usagestring = ('Usage: ' + sys.argv[0] + ' STRING1 [STRING2]...'"\n\n"
               'STRING: A percent-encoded string to unquote, e.g.'
               "'https%3a%2f%2fexample%2Ecom' 'ocf%3A%2F%2Fex%3Aam%3Apl%2Fe'"
               "...\n")

if len(sys.argv) < 2 or '%' not in sys.argv[1]:
    print(usagestring)
else:
    for string in sys.argv[1:]:
        print(urllib.parse.unquote(string))
