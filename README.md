## Purpose
This script will pause for a length of seconds randomly selected between `minSleep` and `maxSleep`, it will then connect to a random host and run the `downCommand`. After this it will pause again for a randomly selected number of seconds between `minSleep` and `maxSleep` and then run the `upCommand`.

## Configuration
Edit the script and set the 6 variables how you want them at the top:
- minSleep: The minimum amount of time to pause
- maxSleep: The maximum amount of time to pause
- user: The user to SSH in as (this requires a key in your ssh-agent to authenticate with)
- downCommand: The command to execute to disrupt your service (prefix with sudo if required)
- upCommand: The command to execute to resume your service (prefix with sudo if required)

