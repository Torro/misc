#!/usr/bin/python3
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
