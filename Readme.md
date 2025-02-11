This script is to check network ip's if the are connected correctly, cheking via ping command.

There is also mail process implemented by "msmtp" mail service below are the installaiton steps to follow.

Command : 
1. apt update
2. apt install msmtp
3. apt install mailx
4. nano ~./msmtprc  "and add below content as per your system"

account default
host smtp.gmail.com
port 587
from AccessPoint IT Support
user testing@gmail.com
password jghg kkdk okdk jfjf
tls on
tls_starttls on
auth on
#tls_trust_file /etc/ssl/certs/ca-certificates.crt
logfile ~/.msmtp.log

5. if we want to run script as a service then create a service for the script name networkdevice.sh
