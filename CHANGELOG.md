# Changelog

## build 137
* point to SDK 0.15.0-beta

## build 136
* point to SDK 0.14.0-beta

## build 135
* point to SDK 0.13.1-beta

## build 134
* point to SDK 0.13.0-beta.2

## build 133
* point to SDK 0.12.0-beta.7

## build 131
* Auto-shielding release with MoonPay support & switch to using zcashblockexplorer.com

## build 125
* Issue #293 Crash when browsing Wallet History and sync happens

## build 124
* [Enhancement] Remove the need for ZCASH_NETWORK_ENVIRONMENT env var. Use targets instead
* bump to 0.12.0-beta.2
## build 123
* Fix: Issue #286 Force the app to be awake while syncing
## build 122
* Fix: layout problems on shield dialog. added blockheight to wallet breakdown
## build 121
* Fix: Issue #285 Sync does not resume when app has been backgrounded and brought back to foreground
* Minimum target iOS 14
* [New] See Details and Done Buttons for autoshielding
## build 117
* FIX: privacy-leak bug fix [(see link)](https://electriccoin.co/blog/privacy-leak-bug-discovered-in-nighthawk-and-ecc-wallets/)
## build 116
* FIX: Issue #126 Download params instead of bundling them
* Fix Archive being broken
## build 115
* Try to copy parameters from main bundle before entirely removing them
* update CombineUrlSessionDownloader
* Combine sapling downloaded plus tests. had to fix test schemes because they not build because of output files
* add combine downloader tests
* Remove Support for iOS 13 on logging targets
## build 114
* Fix: Navigation Bar does not appear on balance breakdown screen Issue #275
## build 113
 * fix build error on first build on clean repo
 * Fix rebase problem
 * Adopt Zcash SDK 0.12.0-alpha.3
## build 110
* Issue #271 OhMyScreen shown after background tasks fails
## build 109
* Fix Issue #269 - migration error recovery
* Issue #264
* AX Fix
* updated showing dropdown based on store and rcc teams
* Merge pull request #268 from zcash/shield-poc
* update travis.yml
* fix no-logging target compile error

## build 108
* Fix Home Screen layout broken on large fonts
* Add validation errors to compactBlockProcessor
* Fix: Crash on background

## build 107
* Implement wipe #263
## build 106
* The UnScreen is a screen that let's you navigate to a safe place instead of crashing horribly
## build 105
* fix: issue #277 crash when launching
## build 104
* adopt create -> prepare API
* Make Bugsnag Great Again
* Fix: shielding screen acting weird
* Fix: issue #260 FlowError.InvalidEnvironment error when sending
* FIX: differenciate between TAZ and ZEC
## build 102
* Fix #219 Biometrics Locked when user has no biometrics at all
* Use presentationMode to dismiss
* Remove Awesome Menu. fix Crash on launch
## build 101
* don't spin up BG Tasks on simulator
* fix Wallet balance breakdown to highlight first n decimals
* Add target for testnet only
* add handled exception tracking to bugsnag
* add mixpanel events
* Fixed Received funds UI bug on tAddr accesory view. 
* Balance breakdown 


## =build 100
* Balance refactor

## build 99
* fix wrong text, adjust title size, add accessory view for transparent
## build 98
Receive from T Address
## build 97
* Fixed: issue #241 screen says enter shielded when it can accept both


## build 96
* make firstView() a ViewBuilder function
* comment useless preview
* Surface errors to UI
* Fix: error when backgrounding simulator
* Fix: don't display balance when syncing
* Fix Background Task warning when app loses focus but not foreground
* log initialization crash before crashing since appstore does not catch it
* Fix profile screen getting stuck after rescan starts


## build 93
* change quick rescan to be one week of blocks
* [NEW] solicited feedback dialog
* Re scan feature
* Z->T restore

## build 91
* save last used seetings and if user ever shielded
* Erase and rewind #247
* Add file logger (#244)
## build 80
* Issue #239 show last used address when sending
* Issue #234 
* Issue #210
* Issue #197 Wallet History does not show up when app is offline
* wrong top padding on see details screen
* fix memory leak on reset
* Don't show network fee on received transaction
* Transaction Details as no top padding


## build 75
* Wallet History Navigation reset fix
* Decouple Keypad and Home, add ZECCEnvironment as environmentValue
## build 74
* send flow is cancelled when synchronizer finds a new block
* remove constants file from no-logging target
## build 71\
* Fixes Issue #215 - Can't paste into the memo field
* Fixes Issue #213
* fixes Issue #220
* Fixes Issue #216 Touching payment address to copy to clipboard doesn't show confirmation that it worked
* Fixes issue #218 can't copy the memo text, including can't copy the reply-to address
* FIX: phantom seed when upgrading from old wallets
* FIX: Issue #221 tapping Back Up when creating a new wallet takes you back to the first screen
* FIX: Issue #222

## build 66
This build has serious changes and improvements on seed management. TEST upgrades thoroughly


