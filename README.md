# MacOS-Hardenning-and-Optimisation

Script to Harden and Optimise MasOs Ventura 13.2.1
-------------------------------


Hardening
-------------------------------
Disabling native Apple settings

- [x] Disables the infrared reciever
- [x] Disables guest login access
- [x] Disables the file sharing daemon
- [x] Disables nfs server daemon
- [x] Disables the public key authentication mechanism
- [x] Disables ipv6 on wifi and ethernet
- [x] Disables ssh access
- [x] Disables potential dns leak
- [x] Disables apple remote events
- [x] Disables apple remote agent and remove access
- [x] Disables auto save to icloud for new documents
- [x] Disables search data leaking in safari
- [x] Disables siri
- [x] Disables Captive Portal

Global Hardening

- [x] Prevents other applications from intercepting text typed in to terminal
- [x] Prevents downloaded signed software from recieving incoming connections
- [x] Prevents the computer from broadcasting bonjour service adverts
- [x] Prevents root login via ssh
- [x] Sets the screenlock timeout
- [x] Sets the firewall
- [x] Sets the firmware password
- [x] Remove the list of users from the login screen
- [x] Remove harmfull softawres
- [x] Prohibits MAC OS X from creating temporary files on remote volumes
- [x] Turns off the icloud login prompt
- [x] Turns off password hints
- [x] Turns on file extensions
- [x] Enable automatic updates
- [x] Enable gatekeeper
- [x] Check app updates every day insteade of once a week
- [x] Stop sending of diagnostic info to apple
- [x] Restrict sudo to a single command
- [x] Limits the number of authentication attempts before disconnecting the client
- [x] Send do not track headre in safari

CD Settings

- [x] Prevents any action when inserting a blank cd
- [x] Prevents any action when inserting a blank dvd
- [x] Prevents any action when inserting a music cd
- [x] Prevents any action when inserting a picture cd
- [x] Prevents any action when inserting a video dvd

FileVault

- [x] Enebles Filevault and set up a recovery key
- [x] Remove the admin account from the filevault login screen


Firewall conf 
-------------------------------

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


Optimisation
-------------------------------

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

