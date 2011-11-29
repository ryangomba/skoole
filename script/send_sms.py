import httplib2 as httplib
import urllib
import sys

USERNAME = '86e3fbf7'
PASSWORD = '414092e9'
FROM = '12064532171'
TO = '18457026112'
TEXT = ''
HOST = 'http://localhost:3000'

if (len(sys.argv) == 2):
    TEXT = sys.argv[1]
elif (len(sys.argv) == 5):
    if int(sys.argv[1]) == 1: HOST = 'http://skoole.com'
    FROM = str(sys.argv[2])
    TO = str(sys.argv[3])
    TEXT = str(sys.argv[4])
else:
    print "Need 1 or 3 arguments"
    exit()

url = "{}/sms_in?username={}&password={}&msisdn={}&from=yourmom&to={}&text={}" \
    .format(HOST, USERNAME, PASSWORD, FROM, TO, urllib.quote(TEXT))

h = httplib.Http()
resp, content = h.request(url, "GET")

print resp

