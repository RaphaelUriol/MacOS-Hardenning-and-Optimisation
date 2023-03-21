# MacOS-Hardenning-and-Optimisation

> __Note__

This is a All in One script made for MacOs Ventura 13.2.1, that offers a selection of configurations for Hardening your Mac, and optimizing it by disabling and configuring diferent features. The configurations are all base on CIS [Apple_macOS_13.0_Ventura_Benchmark_v1.0.0](https://downloads.cisecurity.org/#/) Feel free to comment on the parts you are not interested in. 

Many configurations and settings need to be running in sudo.

#### Legend :
Manually done : You need to do it manually following the CIS benchmark  
Included      : the script contain the code to do it automatically but it was not relevant for my use so it is commented  
Not included  : It can be done automatically but I couldn't do it, or you need to do it for each user

## Hardening (Organised according to CIS Benchmark)

### Updates, Patches and additional Security Software

- [x] Enable automatic updates (apps and system)

### System Settings

- [ ] Disables ICloud Sync (not included)
- [x] Sets the firewall
- [x] Sets Stealth mode ON
- [x] Disables Airdrop
- [x] Disables Airplay
- [x] Set auto date and time zone

#### CD Settings

- [x] Prevents any action when inserting a blank cd  
- [x] Prevents any action when inserting a blank dvd  
- [x] Prevents any action when inserting a music cd  
- [x] Prevents any action when inserting a picture cd  
- [x] Prevents any action when inserting a video dvd  

- [x] Disables Screen Sharing  
- [x] Disables File Sharing  
- [x] Disables Printer Sharing  
- [x] Disables Remote Login  
- [x] Disables Remote Management  
- [x] Disables apple remote events  
- [x] Disables Internet Sharing  
- [x] Disables Content Catching  
- [x] Disables Media Sharing  
- [ ] Disables Bluetooth (included)  
- [ ] Make sure computeru name doesn't contain IP or organisational protected informations (manually done)  
- [x] Enable time machine  
- [x] Enable time machine auto backups  
- [x] Enable wifi status in menu bar  
- [x] Enable Bluetooth status in menu bar  
- [x] Disables siri  
- [x] Enable location service  
- [x] Show location service in menu bar  
- [ ] Audit location service access (manually done)  
- [x] Stop sending of diagnostic info to apple  
- [ ] Ensure Limit Ad Tracking Is Enabled (not included)  
- [x] Enable gatekeeper  
- [x] Enbles Filevault and set up a recovery key  
- [ ] Audit Lockdown mode (manually done)  
- [ ] Ensure an Administrator Password Is Required to Access System-Wide Preferences (manually done)  
- [x] Ensure Screen Saver Corners Are Secure   
- [ ] Audit Universal Control Settings (manually done)  
- [x] Ensure Power Nap Is Disabled   
- [x] Disables Wake for Network Access   
- [x] Ensure the OS is not Activate When Resuming from Sleep  
- [x] Ensure an Inactivity Interval of 20 Minutes Or Less for the Screen Saver Is Enabled   
- [x] Ensure a Password is Required to Wake the Computer From Sleep or Screen Saver Is Enabled   
- [x] Enable custom login screen  
- [x] Ensure Login Window Displays as Name and Password Is Enabled   
- [x] Turns off password hints  
- [ ] Ensure Users' Accounts Do Not Have a Password Hint (included)  
- [ ] Audit Touch ID and Wallet & Apple Pay Settings (manually done)  
- [x] Disables guest login access  
- [x] Ensure Guest Access to Shared Folders Is Disabled  
- [x] Disable automatic login  
- [ ] Audit Passwords System Preference Setting (manually done)  
- [ ] Audit Notification & Focus Settings (manually done)  


### Logging and auditing





- [x] Disables the infrared reciever
- [x] Disables the file sharing daemon
- [x] Disables nfs server daemon
- [x] Disables the public key authentication mechanism
- [x] Disables ipv6 on wifi and ethernet
- [x] Disables ssh access
- [x] Disables potential dns leak
- [x] Disables apple remote agent and remove access
- [x] Disables auto save to icloud for new documents
- [x] Disables search data leaking in safari
- [x] Disables siri
- [x] Disables Captive Portal
- [x] Prevents other applications from intercepting text typed in to terminal
- [x] Prevents downloaded signed software from recieving incoming connections
- [x] Prevents the computer from broadcasting bonjour service adverts
- [x] Prevents root login via ssh
- [x] Sets the screenlock timeout
- [x] Sets the firmware password
- [x] Remove the list of users from the login screen
- [x] Remove harmfull softawres
- [x] Prohibits MAC OS X from creating temporary files on remote volumes
- [x] Turns off the icloud login prompt
- [x] Turns on file extensions
- [x] Check app updates every day insteade of once a week
- [x] Restrict sudo to a single command
- [x] Limits the number of authentication attempts before disconnecting the client
- [x] Send do not track headre in safari
- [x] Remove the admin account from the filevault login screen


## Firewall conf 

- [x] Enables pfsense and configures some items
- [x] Configures the firewall to block incoming apple file server
- [x] Configures the firewall to block bonjour packets
- [x] Configures the fw to block finger packets – giggity
- [x] Configures the fw to block ftp
- [x] Configures the fw to block http
- [x] Configures the fw to block icmp
- [x] Configures the fw to block imap
- [x] Configures the fw to block imaps
- [x] Configures the fw to block itunes sharing packets
- [x] Configures the fw to block mdnsresponder packets
- [x] Configures the fw to block nfs packet
- [x] Configures the fw to block optical drive sharing packets
- [x] Configures the fw to block pop3 packets
- [x] Configures the fw to block pop3s packets
- [x] Configures the fw to block printer sharing packets
- [x] Configures the fw to block remote apple events packets
- [x] Configures the fw to block screen sharing packets
- [x] Configures the fw to block smb packets
- [x] Configures the fw to block smtp packets
- [x] Configures the fw to block ssh packets
- [x] Configures the fw to block telnet packets
- [x] Configures the fw to block tftp packets
- [x] Configures the fw to block uucp packets
- [x] Turns the pf firewall on


## Optimisation

- [x] Disable ding sound
- [x] Disable all animations
- [x] Disable smb1 protocol
- [x] Disable extra daemon
- [x] Stop auto open from photo app
- [x] Enable text selection in quick look
- [x] Enable snap-to-grid in finder
- [x] Close printer when printing is finish
- [x] Show language menu in top right corner of the boot screen
- [x] Hide machine popups
- [x] Reduce Motion & Transparency
- [x] Disable Heavy login screen wallpaper


> __Warning__ 

This script does not guarantee to secure your Mac, it executes a non-exhaustive list of configurations that can significantly enhance the security of your machine. Other settings may be necessary in your particular case, and you are not immune to human error

## Sources :

- [@koconder/ostemper](https://github.com/koconder/ostemper)
- [@ayethatsright/MacOS-Hardening-Script](https://github.com/ayethatsright/MacOS-Hardening-Script)
- [@dotslashlevi/optimac](https://github.com/dotslashlevi/optimac)
- [@sickcodes/osx-optimizer](https://github.com/sickcodes/osx-optimizer)
- [@AtropineTears/TheMacHardeningScripts](https://github.com/AtropineTears/TheMacHardeningScripts)
- [@wakedog/macos_scripts](https://github.com/wakedog/macos_scripts)
