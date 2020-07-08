#!/bin/bash
#--------------------------------
#         Name:  xymontoslack.sh
#  Description:  This script takes 1 parameter (channel name, $channel) and sends Xymon alerts/notifications to the specified slack channel.
#       Author:  Spencer Alessi
#  Assumptions:  Slack App with the Bots feature & functionality enabled and a Bot User OAuth Access Token
#     Modified:  07/08/2020
#--------------------------------

xymonenv=$(hostname)
hostname=$BBHOSTNAME
level=$BBCOLORLEVEL
msg="\`\`\`$BBALPHAMSG\`\`\`"
svcname=$BBSVCNAME
username="Xymon Alert"
channel="#${RCPT}"


if [[ $xymonenv == "dev"* ]]; then
  iconemoji=":dev:"
elif [[ $xymonenv == "tst"* ]]; then
  iconemoji=":tst:"
elif [[ $xymonenv == "prod"* ]]; then
  iconemoji=":prod:"
else
  username="Xymon Alert"
  iconemoji=":exclamation:"
fi

if [[ $level == "red" ]]; then
  alertemoji=":xymoncritical:"
elif [[ $level == "yellow" ]]; then
  alertemoji=":xymonyellow:"
elif [[ $level == "green" ]]; then
  alertemoji=":xymonok:"
elif [[ $level == "purple" ]]; then
  alertemoji=":xymonnoreport:"
else
  alertemoji=":grey_question:"
  msg="No data!"
fi

postdata()
{
  cat <<EOF
{
  "channel": "$channel",
  "text": "$alertemoji *$hostname: $svcname is $level.* $alertemoji $msg",
  "username": "$username",
  "icon_emoji": "$iconemoji"
}
EOF
}

curl --silent --output /dev/null -X POST -H 'Authorization: Bearer xxxx' \
  -H 'Content-type: application/json' \
  --data "$(postdata)" "https://slack.com/api/chat.postMessage"
