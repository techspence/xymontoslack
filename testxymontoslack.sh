# To run this test script, paste in the Xymon Bot Oath Access Token replacing the xxxx
# Then save and at the command line run > ./testxymontoslack.sh
# The message: This is a test. should appear in the alerts channel

postdata()
{
  cat <<EOF
{
  "channel": "#alerts",
  "text": "This is a test.",
  "username": "TEST",
}
EOF
}

# Enable verbose output for debugging
curl --show-error --fail -X POST -H 'Authorization: Bearer xxxx' \
  -H 'Content-type: application/json' \
  --data "$(postdata)" "https://slack.com/api/chat.postMessage
  