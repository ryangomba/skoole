import httplib2
import urllib
import time

h = httplib2.Http(".cache")
callback_url = "http://dev.skoole.com:1337/pop"
localhost = "http://localhost:3000"

def poll():
    try:
        resp, content = h.request(callback_url, "GET")
        return resp, content
    except:
        print("Couldn't connect to {}".format(callback_url))
        print("Trying again in 5 seconds...")
        time.sleep(5)
        return poll()

def ping(url, headers, body):
    try:
        h.request(url, "POST", headers=headers, body=body)
        return True
    except:
        print("Couldn't connect to {}".format(callback_url))
        print("Trying again in 5 seconds...")
        time.sleep(5)
        return ping(url, headers, body)

def go():
    resp, content = poll()
    if content:
        print(content)
        url = "{}/twilio/sms".format(localhost)
        headers = {'Content-type': 'application/x-www-form-urlencoded'}
        body = content
        ping(url, headers, body)

print('Polling for callbacks...')
while(1):
    go()
    time.sleep(1)

