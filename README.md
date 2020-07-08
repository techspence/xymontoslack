# Xymon to Slack
This script sends Xymon alerts to a specified slack channel using the Slack API & Bots feature. The alert contains a short message about which service is down, for how long, the full xymon message and a tag for a specific alert group (described below).

# Details
This script takes 1 parameter (channel name, $channel) and sends Xymon alerts/notifications to the specified slack channel. The reason I went with a Bot over Incoming Webhooks was because I plan to add more functionality to the xymon alerts, such as querying the bot for more information about the alert or acknowledging the alerts.

# Prerequisites
- Slack Workspace
- Slack App with the Bots feature & functionality enabled
- Bot User OAuth Access Token
- curl


# Slack Configuration
**Slack App Information & Bot Access Token**
- The Xymon Bot Access Token can be found by logging into your slack workspace and navigating to:
	- https://api.slack.com/
- Then click Your Apps in the top right corner
- Click the appropriate app for your Workspace
- From here you will find information relevant to your app
- To view the Bot Access Token, click on OAuth & Permissions under the Features section
	- _Note: The BOT Use OAuth Access Token is a considered a secret key and should not be placed in public code repositories or client-side code like JavaScript._

**Security & Scope**
- Make sure your app has the following permissions in **Scopes**:
	- chat:write
	- chat:write:customize
	- users:write
- For additional security I recommend configuring the **Restrict API Token Usage** to your WAN IP

# Slack Emojis
In this script I use several emojis not native to slack. I made my own emojis for my use cases. Feel free to make your own & be creative! To add custom emojis in slack go to your Slack Workspace and go to **Settings & administration** > **Customize [workspace name]** > **Add Custom Emoji**

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

# Disabling Xymon Alerts
**Why would you want to disable alerts?**
Well, maybe you are running windows updates, and you don’t want the alert spam to bother those who are subscribed to xymon alerts.

**To disable alerts**

1.	Launch a web browser and navigate to Xymon
2.	Go to Administration -> Enable/disable
3.	On the right side under Select what to disable, under the Hosts column, select the hosts you want to disable alerts for
	- Note: you can select all by using Ctrl + a
4.	Then on the Tests column, select the specific alert type or select ALL
5.	Then check the radio box next to Disable for ---
6.	Enter how long you want to disable alerts for
	- You can pick minutes, hours, days or weeks from the dropdown
7.	You can then use the default Disable now or you can schedule the disabling of alerts
8.	Then click Apply

**To enable alerts**
1.	Launch a web browser and navigate to Xymon
2.	Go to Administration -> Enable/disable
3.	You will see all the hosts you have disabled alerts for on the left-hand side
4.	Under All hosts select all the hosts
5.	click All
6.	Click Enable


# Resources
- http://xymon.sourceforge.net/xymon/help/xymon-alerts.html
- https://tryshift.com/blog/apps-hub/slack-text-formats-bold-quote-more/
- https://api.slack.com/methods/chat.postMessage/test
- https://get.slack.help/hc/en-us/articles/202288908-Format-your-messages
- https://www.linuxquestions.org/questions/programming-9/bash-simple-math-division-question-632776/
- https://stackoverflow.com/questions/42068/how-do-i-handle-newlines-in-json
- https://stackoverflow.com/questions/11931857/urlencode-with-curl-in-bash-with-newlines
- https://stackoverflow.com/questions/17029902/using-curl-post-with-variables-defined-in-bash-script-functions
