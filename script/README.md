# python script/send_sms.py

DEV/PROD | FROM | TO | MESSAGE
1 12064532948 12067927926 'hey ryan'
(0 is localhost, 1 is skoole.com)

# ./script/reset

FOR LOCAL BOX ONLY
* clears the database
* recreates the database
* re-runs all migrations
* populates sms numbers

# ./script/reset-heroku

DANGEROUS!!!!!!!
* clears the production database
* re-runs all migrations
* restarts the production env

# ./script/test

USUALLY NOT NEEDED
* clears the test database
* resets the test env

# /automation folder

CAN IGNORE RIGHT NOW
* gets a list of university names/URLs
