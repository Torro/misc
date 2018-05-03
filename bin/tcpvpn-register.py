#!/usr/bin/python3
# tcpvpn-register.py - a quick and simple tcpvpn.com registration script
# 
# Copyright (c) 2018 Torro
# See the file "copying.txt" included in this
# directory for details about the copyright.

import requests
import random
import string
from bs4 import BeautifulSoup


def gen_random():
    ''' Generate a "cryptographically secure" pseudo-random string of
        12 alphanumeric characters.'''
    return ''.join(random.SystemRandom().choice(
        string.ascii_letters + string.digits) for rangeObject in range(12))


mainUrl = 'https://www.tcpvpn.com'
formUrl = mainUrl + '/create-vpn-account-europe'
parameters = {
              'username': gen_random(),
              'password': gen_random(),
              'create': '',
              'serverid': 'YOUR PREFERRED SERVERID HERE'
             }

if parameters['serverid'].isdigit() and len(parameters['serverid']) == 2:
    pass
else:
    raise ValueError("Parameter 'serverid' must be two digits.")

cookieJar = requests.get(mainUrl).cookies
page = requests.post(formUrl, cookies=cookieJar, data=parameters)
soup = BeautifulSoup(page.text, 'html.parser')

username = soup.find('span', id='copyTarget').text
password = soup.find('span', id='copyTarget2').text

print(username, password, sep='\n')
