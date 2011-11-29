import httplib2
import urllib
from BeautifulSoup import BeautifulSoup
import json
import csv

h = httplib2.Http(".cache")
resp, content = h.request("http://wwwhost.cc.utexas.edu/world/univ/alpha/", "GET")
soup = BeautifulSoup(content)

schools = soup.findAll('a', {'class': 'institution'})

i = 0
w = csv.writer(open('colleges.csv', 'wb'))
for s in schools:
    info = {}
    info['url'] = s['href']
    info['name'] = s.text
    info['abbr'] = s['href'].rpartition('.edu')[0].rpartition('.')[2]
    #q = urllib.quote_plus(s.text)
    #print(q)
    #resp, geocode = h.request("http://maps.googleapis.com/maps/api/geocode/json?address={}&sensor=false".format(q), "GET")
    #latlon = json.loads(geocode)['results'][0]['geometry']['location']
    #info['lat'] = latlon['lat']
    #info['lon'] = latlon['lng']
    w.writerow(info.values())
    i += 1
    print(i)

