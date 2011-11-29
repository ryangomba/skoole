import httplib2 as httplib
import urllib
import sys

USERNAME = '86e3fbf7'
PASSWORD = '414092e9'
FROM = '12064532171'
TO = '18457026112'
TEXT = ''

if (len(sys.argv) == 2):
    TEXT = sys.argv[1]
elif (len(sys.argv) == 4):
    FROM = sys.argv[1]
    TO = sys.argv[2]
    TEXT = sys.argv[3]
else:
    print "Need 1 or 3 arguments"
    exit()

url = "http://localhost:3000/sms_in?username={}&password={}&msisdn={}&from=yourmom&to={}&text={}" \
    .format(USERNAME, PASSWORD, FROM, TO, urllib.quote(TEXT))

h = httplib.Http()
resp, content = h.request(url, "GET")

print resp

