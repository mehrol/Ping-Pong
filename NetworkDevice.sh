#!/bin/bash

IP1="192.168.*.*"
IP2="192.168.*.*"

EMAILS=("test@gmail.com" "test1@gmail.com")

# Function to send email for a specific IP
send_email() {
  local ip=$1
  SUBJECT="AccessPoint Failure Alert for $ip"
  BODY="Hi IT Team,

The **accesspoint device** for ip $ip is not working.

Please restart the device or check if the cables are properly plugged in.


This is a system-generated email. Please don't reply to this.


Thanks & Regards,
WittyBrains Access-Points"


  for EMAIL in "${EMAILS[@]}"; do
    echo -e "Subject:$SUBJECT\n$BODY" | msmtp --account=default "$EMAIL"
  done
}

# Variables to count consecutive failed pings for each IP
failure_count_ip1=0
failure_count_ip2=0

# Infinite loop to ping both IPs continuously
while true; do
  # Ping IP1 (192.168.*.*) and check if it fails
  ping -c 1 $IP1 &> /dev/null
  if [ $? -ne 0 ]; then
    failure_count_ip1=$((failure_count_ip1 + 1))
  else
    failure_count_ip1=0
  fi

  ping -c 1 $IP2 &> /dev/null
  if [ $? -ne 0 ]; then
    failure_count_ip2=$((failure_count_ip2 + 1))
  else
    failure_count_ip2=0
  fi

  if [ $failure_count_ip1 -ge 8 ]; then
    send_email $IP1
    failure_count_ip1=0
  fi

  if [ $failure_count_ip2 -ge 8 ]; then
    send_email $IP2
    failure_count_ip2=0
  fi

  # Sleep for 1 second before the next ping attempt
  sleep 1
done
