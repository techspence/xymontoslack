# xymontoslack
Send Xymon alerts to Slack

# Details
This script takes 1 parameter (channel name, $channel) and sends Xymon alerts/notifications to the specified slack channel. The reason I went with a Bot over Incoming Webhooks was because I plan to add more functionality to the xymon alerts, such as querying the bot for more information about the alert or acknowledging the alerts.

# Prerequisites
Slack Channel and App with the Bots feature & functionality enabled and a Bot User OAuth Access Token

# Setup
1. Create a slack channel for your alerts
2. Create a slack app with the bots feature enabled
3. Replace the `xxxx` at the bottom of the script with the Bot User OAuth Access Token
4. Make sure your app has the following permissions in **Scopes**:
	- chat:write
	- chat:write:customize
	- users:write
	
# Recommended Additional Steps
For security I recommend configuring the **Restrict API Token Usage** if possible to your WAN IP

# Sample Xymon Alerts Config
$: /etc/xymon/alerts.cfg
```
## Example alert for testing/debugging
HOST=%.* COLOR=red SERVICE=conn,cpu,disk,http,mem,memory,pagefile,procs,smtp,svcs,ssh,snapshots
        SCRIPT /home/user/xymontoslack.sh alerts REPEAT=2 RECOVERED

## Example "production" alert
HOST=%.* COLOR=red SERVICE=conn,cpu,disk,http,mem,memory,pagefile,procs,smtp,svcs,ssh,snapshots
        SCRIPT /home/user/xymontoslack.sh alerts
```

# Resources
- http://xymon.sourceforge.net/xymon/help/xymon-alerts.html
- https://tryshift.com/blog/apps-hub/slack-text-formats-bold-quote-more/
- https://api.slack.com/methods/chat.postMessage/test
- https://get.slack.help/hc/en-us/articles/202288908-Format-your-messages
- https://www.linuxquestions.org/questions/programming-9/bash-simple-math-division-question-632776/
- https://stackoverflow.com/questions/42068/how-do-i-handle-newlines-in-json
- https://stackoverflow.com/questions/11931857/urlencode-with-curl-in-bash-with-newlines
- https://stackoverflow.com/questions/17029902/using-curl-post-with-variables-defined-in-bash-script-functions
