# coding=UTF-8

import requests
import sys
import time
from selenium import webdriver

def send_request(line):
    try:
        uline = unicode(line.decode("utf8"))
        url = 'https://maps.googleapis.com/maps/api/geocode/json'
        params = {'sensor': 'false', 'address': uline}
        r = requests.get(url, params=params)
        results = r.json()['results']
        location = results[0]['geometry']['location']
        return (line + ',' + str(location['lat']) + ',' + str(location['lng']))
    except :
        return (line + ',NA,NA')

def main():
    fin = open(sys.argv[1], 'r')
    fout = open(sys.argv[1]+'.txt', 'w')
    line_counter = 0
    for line in fin :
        line = line[:-1]
        output = send_request(line)
        print(output)
        fout.write(output+'\n')
        if line_counter >= 50:
            line_counter = 0
            time.sleep(1)
    fin.close()
    fout.close()

if __name__ == "__main__":
    main()


'''
import requests
url = 'https://maps.googleapis.com/maps/api/geocode/json'
#params = {'sensor': 'false', 'address': '350 5th Ave, New York, NY 10118'}
params = {'sensor': 'false', 'address': u"台北市士林區基河路128號"}
#params = {'sensor': 'false', 'address': 'Mountain View, CA'}
r = requests.get(url, params=params)
results = r.json()['results']
location = results[0]['geometry']['location']
print (location['lat'], location['lng'])

'''
