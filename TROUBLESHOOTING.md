# Troubleshooting

## No network environment....
if you see this message when building:
```No network environment. Set ZCASH_NETWORK_ENVIRONMENT to MAINNET or TESTNET```
make sure your dev environment has this variable set before the build starts. *DO NOT CHANGE IT DURING THE BUILD PROCESS*.

If the variable was properly set *after* you've seen this message, you will need to either a) set it manually on the pod's target or b) doing a clean pod install and subsequent build.

#### a) setting the flag manually
1. on your workspace, select the Pods project
2. on the Targets pane, select ZcashLightClientKit
3. go to build settings
4. scroll down to see ZCASH_NETWORK_ENVIRONMENT and complete with TESTNET or MAINNET