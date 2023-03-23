#!/bin/bash

# "Best of" from these projects : 
# https://github.com/koconder/ostemper/blob/master/ostemper.sh
# https://github.com/ayethatsright/MacOS-Hardening-Script/blob/master/hardening_script.sh
# https://github.com/dotslashlevi/optimac/blob/main/optimac.sh
# https://github.com/sickcodes/osx-optimizer
# https://github.com/AtropineTears/TheMacHardeningScripts/blob/main/MacOsX-Harden.sh
# https://github.com/wakedog/macos_scripts/blob/main/macos_script.sh

# For Hardening and optimisation MacOS Ventura 13.2.1


echo "Please enter your username, it is needed for configurations"
read usernamex
echo "$username"

########################################################
########################################################
#               ||
# HARDENING     ||
#               \/
########################################################
########################################################


########################################################################################################################
# Updates, Patches and additional Security Software
########################################################################################################################

# Enable all Apple-provided software updates
sudo softwareupdate --schedule on

# Enable auto-update
sudo defaults write /Library/Preferences/com.apple.SoftwareUpdate AutomaticCheckEnabled -bool true
sudo defaults write /Library/Preferences/com.apple.SoftwareUpdate AutomaticDownload -bool true

# Enable download new updates when available
sudo defaults write /Library/Preferences/com.apple.SoftwareUpdate ConfigDataInstall -bool true
sudo defaults write /Library/Preferences/com.apple.commerce.plist AutoUpdate -bool true

# Enable install of macOS updates
sudo defaults write /Library/Preferences/com.apple.commerce.plist AutoUpdateRestartRequired -bool true

# Enable install application updates from the App Store
sudo defaults write /Library/Preferences/com.apple.commerce.plist AutoUpdateAppMinorVersion -bool true

# Enable install security responses and system files
sudo defaults write /Library/Preferences/com.apple.SoftwareUpdate CriticalUpdateInstall -bool true
sudo defaults write /Library/Preferences/com.apple.SoftwareUpdate ConfigDataInstall -bool true

# Enable software update deferment for 30 days
sudo defaults write /Library/Preferences/com.apple.SoftwareUpdate.plist DelayInterval -int 30



########################################################################################################################
# System Settings
########################################################################################################################


########################################################
#  SETS THE FIREWALL
########################################################
echo " Enabling Firewall"
/usr/libexec/ApplicationFirewall/socketfilterfw --setloggingmode on
/usr/libexec/ApplicationFirewall/socketfilterfw --setallowsigned on
/usr/libexec/ApplicationFirewall/socketfilterfw --setglobalstate on

########################################################
#  SETS THE STEALTH MODE ON
########################################################
echo " Enabling Stealth mode"
/usr/bin/sudo /usr/libexec/ApplicationFirewall/socketfilterfw --setstealthmode on

########################################################
#DISABLES AIRDROP
########################################################
echo " Disabling Airdrop"
sudo ifconfig awdl0 down 

########################################################
#DISABLES AIRPLAY
########################################################
echo " Disabling Airplay"
defaults write com.apple.controlcenter.plist AirplayRecieverEnabled -bool false

########################################################
#  SETS AUTO DATE AND TIME ZONE
########################################################
echo " Setting auto date and time zone"
/usr/sbin/systemsetup -settimezone France/Paris



########################################################################################################################
# CD Settings
########################################################################################################################



########################################################
#  PREVENTS ANY ACTION WHEN INSERTING A BLANK CD
########################################################
echo " Preventing any actions when a blank CD is inserted"
defaults write ~/Library/Preferences/com.apple.digihub.plist com.apple.digihub.blank.cd.appeared -dict action -int 1; killall -HUP SystemUIServer; killall -HUP cfprefsd

########################################################
#  PREVENTS ANY ACTION WHEN INSERTING A BLANK DVD
########################################################
echo " Preventing any actions when a blank DVD is inserted"
defaults write ~/Library/Preferences/com.apple.digihub.plist com.apple.digihub.blank.dvd.appeared -dict action -int 1; killall -HUP SystemUIServer; killall -HUP cfprefsd

########################################################
#  PREVENTS ANY ACTION WHEN INSERTING A MUSIC CD
########################################################
echo " Preventing any actions when a music CD is inserted"
defaults write ~/Library/Preferences/com.apple.digihub.plist com.apple.digihub.cd.music.appeared -dict action -int 1; killall -HUP SystemUIServer; killall -HUP cfprefsd

########################################################
#  PREVENTS ANY ACTION WHEN INSERTING A PICTURE CD
########################################################
echo " Preventing any actions when a picture CD is inserted"
defaults write ~/Library/Preferences/com.apple.digihub.plist com.apple.digihub.cd.picture.appeared -dict action -int 1; killall -HUP SystemUIServer; killall -HUP cfprefsd

########################################################
#  PREVENTS ANY ACTION WHEN INSERTING A VIDEO DVD
########################################################
echo " Preventing any actions when a DVD containing video is inserted"
defaults write ~/Library/Preferences/com.apple.digihub.plist com.apple.digihub.dvd.video.appeared -dict action -int 1; killall -HUP SystemUIServer; killall -HUP cfprefsd


########################################################################################################################

########################################################################################################################


########################################################
#DISABLES SCREEN SHARING
########################################################
echo " Disabling Screen Sharing"
/usr/bin/sudo /bin/launchctl disable system/com.apple.screensharing

########################################################
#DISABLES FILE SHARING
########################################################
echo " Disabling File Sharing"
/usr/bin/sudo /bin/launchctl disable system/com.apple.smbd

########################################################
#DISABLES PRINTER SHARING
########################################################
echo " Disabling Printer sharing"
/usr/bin/sudo /usr/sbin/cupsctl --no-share-printers

########################################################
#DISABLES REMOTE LOGIN
########################################################
echo " Disabling Remote login"
/usr/bin/sudo /usr/sbin/systemsetup -setremotelogin off

########################################################
#DISABLES REMOTE MANAGEMENT
########################################################
echo " Disabling Remote Management"
/usr/bin/sudo /System/Library/CoreServices/RemoteManagement/ARDAgent.app/Contents/Resources/kickstart -deactivate -stop

########################################################
#  DISABLES APPLE REMOTE EVENTS
########################################################
echo -e " Disable Apple remote events"
/usr/bin/sudo /usr/sbin/systemsetup -setremoteappleevents off

########################################################
#DISABLES INTERNET SHARING
########################################################
echo " Disabling Internet sharing"
usr/bin/sudo /usr/bin/defaults write /Library/Preferences/SystemConfiguration/com.apple.nat NAT -dict Enabled -int 0

########################################################
#DISABLES CONTENT CACHING
########################################################
echo " Disabling Content caching"
/usr/bin/sudo /usr/bin/AssetCacheManagerUtil deactivate

########################################################
#DISABLES MEDIA SHARING
########################################################
echo " Disabling Media sharing"
defaults write com.apple.amp.mediasharingd home-sharing-enabled -int 0

########################################################
#  DISABLES BLUETOOTH
########################################################
#echo " Disabling Blurtooth"
#defaults write com.apple.Bluetooth PrefKeyServicesEnabled -bool false

########################################################
#  ENABLE TIME MACHINE 
########################################################
echo " Enabling time machine"
sudo tmutil enable

########################################################
#  ENABLE TIME MACHINE BACKUPS
########################################################
echo " enabling time machine auto backups"
defaults write /Library/Preferences/com.apple.TimeMachine.plist AutoBackup -bool true

########################################################
#  ENABLE WIFI STATUS IN MENU BAR
########################################################
echo " Enable wifi status in menu bar"
defaults write com.apple.controlcenter.plist WiFi -int 2

########################################################
#  ENABLE BLUETOOTH STATUS IN MENU BAR
########################################################
echo " Enable Bluetooth status in menu bar"
defaults write com.apple.controlcenter.plist Bluetooth -int 18

########################################################
#  DISABLES SIRI
########################################################
echo " Disabling Siri"
defaults write ~/Library/Preferences/com.apple.assistant.support.plist "Assistant Enabled" -int 0; killall -TERM Siri; killall -TERM cfpre$

########################################################
#  ENABLE LOCATION SERVICE
########################################################
echo " Enable location service"
/usr/bin/sudo /bin/launchctl load -w /System/Library/LaunchDaemons/com.apple.locationd.plis

########################################################
#  ENABLE LOCATION SERVICE IN MENU BAR
########################################################
echo " Show location service in menu bar"
defaults write /Library/Preferences/com.apple.locationmenu.plist ShowSystemServices -bool true

########################################################
#  STOP SENDING OF DIAGNOSTIC INFO TO APPLE
########################################################
echo " Stopping this machine from sending diagnostic info to Apple"
defaults write /Library/Application\ Support/CrashReporter/DiagnosticMessagesHistory.plist AutoSubmit -bool FALSE
defaults write com.apple.CrashReporter DialogType none

########################################################
#  ENABLE LIMIT AD TRACKING
########################################################
echo " Enable limited ad tracking"
sudo -u $username /usr/bin/defaults write /Users/$username/Library/Preferences/com.apple.Adlib.plistallowApplePersonalizedAdvertising -bool false

########################################################
#  ENABLE GATEKEEPER
########################################################
spctl --master-enable
echo " Gatekeeper is now enabled"

########################################################
#  ENABLING FILE VAULT AND SETING UP RECOVERY KEY
########################################################
if !(fdesetup status | grep "FileVault is On."); then
    if ConfirmExecution "Do you want to enable FileVault?"; then
        # Set a strong, randomly-generated password for the FileVault recovery key
        recoveryKeyPassword=$(openssl rand -base64 32)
        # Enable FileVault with the recovery key password
        fdesetup enable -recoverykey "$recoveryKeyPassword"
    fi
fi

########################################################
#  SECURE SCREEN SAVER CORNER
########################################################
echo " Secure sceen saver corner are secure"
defaults write com.apple.dock <corner that is set to '6'> -int 0

########################################################
#  DISABLE POWER NAP
########################################################
echo " Disable power nap"
pmset -a powernap 0

########################################################
#  DISABLE POWER NAP
########################################################
echo " Disable Wake for Network Access "
pmset -a womp 0

########################################################
#  ENABLE THE OS IS NOT ACTIVATED WHEN RESUMING FROM SLEEP
########################################################
echo " Ensure the OS is not Activate When Resuming from Sleep "
pmset -a standbydelaylow <value≤900>
pmset -a standbydelayhigh <value≤900>
pmset -a highstandbythreshold <value≥90>
pmset -a destroyfvkeyonstandby 1
pmset -a hibernatemode 25

########################################################
#  ENSURE AN INACTIVITY INTERVAL OF 20MIN OR LESS FROM THE SCREEN SAVER IS ENABLE
########################################################
echo " Ensure an Inactivity Interval of 20 Minutes Or Less for the Screen Saver Is Enabled  "
defaults write com.apple.screensaver idleTime -int <value ≤1200>

########################################################
#  ESURE PASSORD IS REQUIERED
########################################################
echo "Ensure a Password is Required to Wake the Computer From Sleep or Screen Saver Is Enabled "
sysadminctl -screenLock immediate -password <administrator password>

########################################################
#  ENABLE CUSTOM LOGIN SCREEN
########################################################
echo "Enable custom login screen"
defaults write /Library/Preferences/com.apple.loginwindow LoginwindowText "YOUR MESSAGE HERE"

########################################################
#  ENSURE LOGIN WINDOW DISPLAYS AS NAME AND PASS IS ENABLE
########################################################
echo "Ensure Login Window Displays as Name and Password Is Enabled "
defaults write /Library/Preferences/com.apple.loginwindow SHOWFULLNAME -bool true

########################################################
#  TURNS OFF PASSWORD HINTS
########################################################
echo " Disabling password hints on the lock screen"
defaults write com.apple.loginwindow RetriesUntilHint -int 0

########################################################
#  ENSURE USERS ACCOUNTS DO NOT HAVE PASSWORD HINT
########################################################
echo "Ensure Users' Accounts Do Not Have a Password Hint"
dscl . -list /Users hint . -delete /Users/$username hint

########################################################
#  DISABLES GUEST LOGIN ACCESS
########################################################
echo -e " Disable guest login access"
defaults write /Library/Preferences/com.apple.AppleFileServer guestAccess -bool NO
defaults write /Library/Preferences/SystemConfiguration/com.apple.smb.server AllowGuestAccess -bool NO
defaults write /Library/Preferences/com.apple.loginwindow GuestEnabled -bool false

########################################################
#  DISABLES GUEST ACCESS TO SHARE FOLDERS
########################################################
echo -e " Disable guest access to share folders"
sysadminctl -smbGuestAccess off

########################################################
#  DISABLES AUTOMATIC LOGIN
########################################################
echo " Disable automatic login"
defaults delete /Library/Preferences/com.apple.loginwindow autoLoginUser


########################################################################################################################
# Logging and auditing
########################################################################################################################



########################################################
#  ENABLE SECURITY AUDITING
########################################################
echo " enable security auditing"
launchctl load -w /System/Library/LaunchDaemons/com.apple.auditd.plist

########################################################
#  ENABLE SECURITY AUDITING
########################################################
echo "Ensure Access to Audit Records Is Controlled"
chown -R root:wheel /etc/security/audit_control
chmod -R o-rw /etc/security/audit_control
chown -R root:wheel /var/audit/
chmod -R o-rw /var/audit/

########################################################
#  FIREWALL LOGIN ENABLE AND CONFIGURED
########################################################
echo "Firewall Logging Is Enabled you should configure it"
sudo /usr/libexec/ApplicationFirewall/socketfilterfw --setloggingmode on


########################################################################################################################
# Network Configurations
########################################################################################################################


########################################################
#  DISABLE BONJOUR ADVERTISING SERVICES
########################################################
echo " Bonjour Advertising Services Is Disabled "
defaults write /Library/Preferences/com.apple.mDNSResponder.plist NoMulticastAdvertisements -bool true

########################################################
#  DISABLE HTTP SERVER
########################################################
echo " Disable HTTP Server "
launchctl unload -w /System/Library/LaunchDaemons/org.apache.httpd.plist

########################################################
#  DISABLE NFS SERVER
########################################################
echo " Disable NFS Server "
launchctl disable system/com.apple.nfsd


########################################################################################################################
# System Access, Authentication and Authorization
########################################################################################################################


########################################################
#  ENSURE PERSONAL FOLDERS ARE SAFE
########################################################
echo "Ensure personal folders are safe"
sudo /bin/chmod -R og-rwx /Users/$username
#sudo /bin/chmod -R og-rw /Users/<username> si on ne veut pas qu'il soit executable

########################################################
#  ENABLE SIP SYSTEM INTEGRITY PROTECTION
########################################################
echo " Enable SIP "
csrutil enable

########################################################
#  ENABLE AMFI APPLE MOBILE FILE INTEGRITY
########################################################
echo " Enable AMFI "
nvram boot-args=""

########################################################
#  ENABLE SSV SEALED SYSTEM VOLUME
########################################################
echo " Enable Sealed System Volume"
csrutil authenticated-root status
#IF NOT ENABLE THE SYSTEM IS CONSIDERED COMPROMISED AND A CLEAN INSTALL NEED TO BE DONE

########################################################
#  ENABLE APPROPRIATES PERMISSIONS FOR APPS
########################################################
echo " Ensure Appropriate Permissions Are Enabled for System Wide Applications"
sudo IFS=$'\n'
for apps in $( /usr/bin/find /Applications -iname "*\.app" -type d -perm -2
); do
/bin/chmod -R o-w "$apps"
done

########################################################
#  ENSURE NO WORLDS WRITABLES FILES EXIST IN THE SYSTEM FOLDER
########################################################
echo " Ensure No World Writable Files Exist in the System Folder"
sudo IFS=$'\n'
for sysPermissions in $( /usr/bin/find /System/Volumes/Data/System -type d -
perm -2 | /usr/bin/grep -v "Drop Box" ); do
/bin/chmod -R o-w "$sysPermissions"
done

########################################################
#  ENSURE NO WORLDS WRITABLES FILES EXIST IN THE LIBRARY FOLDER
########################################################
echo " Ensure No World Writable Files Exist in the Library Folder"
sudo IFS=$'\n'
for libPermissions in $( /usr/bin/find /System/Volumes/Data/Library -type d -
perm -2 | /usr/bin/grep -v Caches | /usr/bin/grep -v /Preferences/Audio/Data
); do
/bin/chmod -R o-w "$libPermissions"
done

#######################################################
#  ENSURE PASSWORD ACOUNT LMOCKOUT THRESHOLD IS CONFIGURED
########################################################
echo " Ensure Password Account Lockout Threshold Is Configured"
sudo /usr/bin/pwpolicy -n /Local/Default -setglobalpolicy "maxFailedLoginAttempts=5"

#######################################################
#  ENSURE PASSWORD MINIMUM LENGHT IS CONFIGURED
#######################################################
echo " Ensure Password Minimum Length Is Configured"
sudo /usr/bin/pwpolicy -n /Local/Default -setglobalpolicy "minChars=15"

#######################################################
#  ENSURE PASSWORD MUST CONTAIN ALPHBETIC CARACTERE
#######################################################
echo " Ensure Complex Password Must Contain Alphabetic Characters Is Configured"
sudo /usr/bin/pwpolicy -n /Local/Default -setglobalpolicy "requiresAlpha=1"

#######################################################
#  ENSURE PASSWORD MUST CONTAIN NUMERIC CARACTERE
#######################################################
echo " Ensure Complex Password Must Contain Numeric Character Is Configured"
sudo /usr/bin/pwpolicy -n /Local/Default -setglobalpolicy "requiresNumeric=2"

#######################################################
#  ENSURE PASSWORD MUST CONTAIN AT LEAST SPECIAL CARACTERE
#######################################################
echo " Ensure Complex Password Must Contain Special Character Is Configured "
sudo /usr/bin/pwpolicy -n /Local/Default -setglobalpolicy "requiresSymbol=1"

#######################################################
#  ENSURE PASSWORD MUST CONTAIN UPPERCASE AND LOWERCASE CARACTERE
#######################################################
echo " Ensure Complex Password Must Contain Uppercase and Lowercase Characters Is Configured "
sudo /usr/bin/pwpolicy -n /Local/Default -setglobalpolicy "requiresMixedCase=1"

#######################################################
#  ENSURE PASSWORD AGE IS CONFIGURED
#######################################################
echo " Ensure Password Age Is Configured "
sudo /usr/bin/pwpolicy -n /Local/Default -setglobalpolicy "maxMinutesUntilChangePassword=43200"

#######################################################
#  ENSURE PASSWORD HISTORY CONFIGURED
#######################################################
echo " Ensure Password History Is Configured "
sudo /usr/bin/pwpolicy -n /Local/Default -setglobalpolicy "usingHistory=15"

#######################################################
#  DISABLE USER ROOT
#######################################################
echo " Disable user root "
sudo /usr/sbin/dsenableroot -d

#######################################################
#  DISABLE A USER LOGGING INTO ANOTHER USER ACTIV AND/OR LOCKED SESSION
#######################################################
echo " Disable a user logging into another user activ and/or locked session "
sudo /usr/bin/security authorizationdb write system.login.screensaver use-login-window-ui

#######################################################
#  REMOVE GUEST HOME FOLDER
#######################################################
echo " remove guest home folder "
sudo /bin/rm -R /Users/Guest


########################################################################################################################
# APPLICATIONS
########################################################################################################################

########################################################
#  TURNS ON FILE EXTENSIONS
########################################################
echo " Turning on file extensions which are hidden by default"
defaults write ~/Library/Preferences/.GlobalPreferences.plist AppleShowAllExtensions -bool TRUE; killall -HUP Finder; killall -HUP cfprefsd

########################################################
#  DISABLE AUTO OPENING OF SAFE FILES ON SAFARI
########################################################
echo " Disabling auto opening of safe files on safari"
sudo -u $username /usr/bin/defaults write /Users/$username/Library/Containers/com.apple.Safari/Data/Library/Preferences/com.apple.Safari AutoOpenSafeDownloads -bool false

########################################################
#  DELETE HISTORY FILES
########################################################
echo " Deleting history files"
sudo -u  $username /usr/bin/defaults write /Users/ $username/Library/Containers/com.apple.Safari/Data/Library/Preferences/com.apple.Safari HistoryAgeInDaysLimit -int 1
sudo -u  $username /usr/bin/defaults write /Users/ $username/Library/Containers/com.apple.Safari/Data/Library/Preferences/com.apple.Safari HistoryAgeInDaysLimit -int 7
sudo -u  $username /usr/bin/defaults write /Users/ $username/Library/Containers/com.apple.Safari/Data/Library/Preferences/com.apple.Safari HistoryAgeInDaysLimit -int 14
sudo -u  $username /usr/bin/defaults write /Users/ $username/Library/Containers/com.apple.Safari/Data/Library/Preferences/com.apple.Safari HistoryAgeInDaysLimit -int 31
sudo -u  $username /usr/bin/defaults write /Users/ $username/Library/Containers/com.apple.Safari/Data/Library/Preferences/com.apple.Safari HistoryAgeInDaysLimit -int 365
sudo -u  $username /usr/bin/defaults write /Users/ $username/Library/Containers/com.apple.Safari/Data/Library/Preferences/com.apple.Safari HistoryAgeInDaysLimit -int 36500

########################################################
#  SETTING WARNING WHEN VISITING FRAUDULENT WEBSITE
########################################################
echo " Seting warning when visiting frauduelent websie"
sudo -u $username /usr/bin/defaults read /Users/$username/Library/Containers/com.apple.Safari/Data/Library/Preferences/com.apple.Safari WarnAboutFraudulentWebsites

########################################################
#  ENABLE SAFARI TO PREVENT CROSS SITE TRACKING
########################################################
echo " Enables safari to prevent cross site tracking"
/usr/bin/sudo -u $username /usr/bin/defaults write /Users/$username/Library/Containers/com.apple.Safari/Data/Library/Preferences/com.apple.Safari BlockStoragePolicy -int 2
/usr/bin/sudo -u $username /usr/bin/defaults write /Users/$username/Library/Containers/com.apple.Safari/Data/Library/Preferences/com.apple.Safari WebKitPreferences.storageBlockingPolicy -int 1
/usr/bin/sudo -u $username /usr/bin/defaults write /Users/$username/Library/Containers/com.apple.Safari/Data/Library/Preferences/com.apple.Safari WebKitStorageBlockingPolicy -int 1

########################################################
#  MASK IP IN SAFARI SETTINGS
########################################################
echo " Masks IP in safari settings"
sudo -u $username /usr/bin/defaults write /Users/$username/Library/Containers/com.apple.Safari/Data/Library/Preferences/com.apple.Safari WBSPrivacyProxyAvailabilityTraffic -int <130272/130276>

########################################################
#  ENABLE ADVERTISING POLICY RPOTECTION IN SAFARI
########################################################
echo " Enable advertising policy protection in safari"
sudo -u $username /usr/bin/defaults write /Users/$username/Library/Containers/com.apple.Safari/Data/Library/Preferences/com.apple.Safari WebKitPreferences.privateClickMeasurementEnabled -bool true

########################################################
#  ENABLE DISPLAY FULL WEB SITE ADRESS IN SAFARI
########################################################
echo " Displays full web site adress in safari"
sudo -u $username /usr/bin/defaults write /Users/$username/Library/Containers/com.apple.Safari/Data/Library/Preferences/com.apple.Safari ShowFullURLInSmartSearchField -bool true

########################################################
#  ENABLE SECURE KEYBOARD ENTRIES IN TERMINAL
########################################################
echo " Enable secure keyboard entries in Terminal"
sudo -u firstuser /usr/bin/defaults write -app Terminal SecureKeyboardEntry -bool true


########################################################################################################################
# OTHER SETTINGS
########################################################################################################################


########################################################
#DISABLES THE INFRARED RECIEVER
########################################################
echo " Disabling infrared receiver"
defaults write com.apple.driver.AppleIRController DeviceEnabled -bool FALSE

########################################################
#  DISABLES THE FILE SHARING DAEMON
########################################################
echo " Disabling the filesharing daemon"
launchctl disable system/com.apple.smbd; launchctl bootout system/com.apple.smbd; launchctl disable system/com.apple.AppleFileServer; launchctl bootout system/com.apple.AppleFileServer

########################################################
#  DISABLES NFS SERVER DAEMON
########################################################
echo " Disabling the NFS server daemon"
launchctl disable system/com.apple.nfsd; launchctl bootout system/com.apple.nfsd; launchctl disable system/com.apple.lockd; launchctl bootout system/com.apple.lockd; launchctl disable system/com.apple.statd.notify; launchctl bootout system/com.apple.statd.notify

########################################################
#  DISABLES THE PUBLIC KEY AUTHENTICATION MECHANISM
########################################################
echo " Disabling the public key authentication mechanism for SSH"
sed -i.bak 's/.*PubkeyAuthentication.*/PubkeyAuthentication no/' /etc/ssh/sshd_config

########################################################
#  DISABLES IPV6 ON WIFI AND ETHERNET
########################################################
echo -e " Disable IPV6 on Wi-fi and Ethernet adapters"
#TODO: Scan all adapters and replicate
networksetup -setv6off Wi-Fi >/dev/null
networksetup -setv6off Ethernet >/dev/null

########################################################
#  DISABLES SSH ACCESS
########################################################
echo -e " Disable SSH access"
launchctl unload -w /System/Library/LaunchDaemons/ssh.plist >/dev/null 2>/dev/null

########################################################
#  DISABLES POTENTIAL DNS LEAK
########################################################
echo -e " Disable potential DNS leaks"
defaults write /Library/Preferences/com.apple.mDNSResponder.plist NoMulticastAdvertisements -bool YES

########################################################
#  DISABLES APPLE REMOTE AGENT AND REMOVE ACCESS
########################################################
echo -e " Disable Apple remote agent and remove access"
/System/Library/CoreServices/RemoteManagement/ARDAgent.app/Contents/Resources/kickstart -deactivate -configure -access -off >/dev/null 2>/dev/null

########################################################
#  DISABLES AUTO SAVE TO ICLOUD FOR NEW DOCUMENTS
########################################################
echo -e " New documents disable auto-save to iCloud"
defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false

########################################################
#  DISABLES SEARCH DATA LEAKING IN SAFARI
########################################################
echo -e "\t\- [\033[32m+\033[m] Security tweaks / Disable search data leaking in safari"
defaults write com.apple.Safari UniversalSearchEnabled -bool false
defaults write com.apple.Safari SuppressSearchSuggestions -bool true
defaults write com.apple.Safari.plist WebsiteSpecificSearchEnabled -bool NO

########################################################
#  DISABLES CAPTIVE PORTALS
########################################################
echo " Disabling captive portals"
defaults write /Library/Preferences/SystemConfiguration/com.apple.captive.control Active -bool false

########################################################
#  PREVENTS OTHER APPLICATIONS FROM INTERCEPTING TEXT TYPED IN TO TERMINAL
########################################################
echo " Enabling secure Terminal keyboard to prevent other applications from intercepting anything typed in to terminal"
defaults write ~/Library/Preferences/com.apple.Terminal.plist SecureKeyboardEntry -int 1

########################################################
#  PREVENTS DOWNLOADED SIGNED SOFTWARE FROM RECIEVING INCOMING CONNECTIONS
########################################################
echo " Preventing signed downloads from recieving incoming connections"
/usr/libexec/ApplicationFirewall/socketfilterfw --setallowsignedapp off

########################################################
#  PREVENTS THE COMPUTER FROM BROADCASTING BONJOUR SERVICE ADVERTS
########################################################
echo " Preventing the computer from broadcasting Bonjour service advertisements"
defaults write /Library/Preferences/com.apple.mDNSResponder.plist NoMulticastAdvertisements -bool true

########################################################
#  PREVENTS ROOT LOGIN VIA SSH
########################################################
echo " Preventing root login via SSH"
sed -i.bak 's/.*PermitRootLogin.*/PermitRootLogin no/' /etc/ssh/sshd_config

########################################################
#  SETS THE SCREENLOCK TIMEOUT
########################################################
echo " Enabling password-protected screen lock after 5 minutes"
systemsetup -setdisplaysleep 5
defaults write com.apple.screensaver askForPassword -int 1
defaults write com.apple.screensaver askForPasswordDelay -int 0

########################################################
#  SETS THE FIRMWARE PASSWORD
########################################################
echo " Setting the firmware password"
firmwarepasswd -setpasswd

########################################################
#  REMOVE THE LIST OF USERS FROM THE LOGIN SCREEN
########################################################
echo " Removing the list of users from the login screen"
defaults write /Library/Preferences/com.apple.loginwindow SHOWFULLNAME -int 1

########################################################
#  REMOVE HARMFULL SOFTWARES
########################################################

if ConfirmExecution "Do you want to scan for and remove harmful software?"; then
    # Use Malwarebytes to scan for and remove harmful software
    sudo /Library/Application\ Support/Malwarebytes/MBAM/mbam
fi

########################################################
#  PROHIBITS MAC OS FROM CREATING TEMPORARY FILES ON REMOTE VOLUMES
########################################################
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true

########################################################
#  TURNS OFF THE ICLOUD LOGIN PROMPT
########################################################
echo " Turning off iCloud login prompt"
defaults write /System/Library/User\ Template/English.lproj/Library/Preferences/com.apple.SetupAssistant DidSeeCloudSetup -bool TRUE
defaults write /System/Library/User\ Template/English/lproj/Library/Preferences/com.apple.SetupAssistant GestureMovieSeen none
defaults write /System/Library/User\ Template/English/lproj/Library/Preferences/com.apple.SetupAssistant LastSeenCloudProductVersion "10.12"

########################################################
#  CHECK APP UPDATES EVERY DAY INSTEAD OF ONCE A WEEK
########################################################
echo -e " Check for App Updates daily, not just once a week"
defaults write com.apple.SoftwareUpdate ScheduleFrequency -int 1

########################################################
#  RESTRICT SUDO TO A SINGLE COMMAND
########################################################
echo " Restricting sudo authentication to a single command"
sed -i.bk 's/^Defaults[[:blank:]]timestamp_timeout.*$//' /etc/sudoers; echo "Defaults timestamp_timeout=0">>/etc/sudoers; rm /etc/sudoers.bk

########################################################
#  LIMITS THE NUMBER OF AUTHENTICATION ATTEMPTS BEFORE DISCONNECTING THE CLIENT
########################################################
echo " Setting the number of authentication attempts before disconnecting the client to four"
sed -i.bak 's/.*maxAuthTries.*/maxAuthTries 4/' /etc/ssh/sshd_config

########################################################
#  SEND DO NOT TRACK HEADRE IN SAFARI
########################################################
echo " Send 'Do Not Track' header in Safari"
defaults write com.apple.safari SendDoNotTrackHTTPHeader -int 1

########################################################
#  REMOVE THE ADMIN ACCOUNT FROM THE FILEVAULT LOGIN SCREEN
########################################################
echo " Removing the local administrator account from the FileVault login screen"
fdesetup remove -user administrator



########################################################
########################################################
#               ||
# FIREWALL CONF ||
#               \/
########################################################
########################################################

#  ENABLES PFSENSE AND CONFIGURES SOME ITEMS
echo " Enabling pfsense and configuring secure options"
pfctl -e 2> /dev/null; cp /System/Library/LaunchDaemons/com.apple.pfctl.plist /Library/LaunchDaemons/sam.pfctl.plist; /usr/libexec/PlistBuddy -c "Add :ProgramArguments:1 string -e" /Library/LaunchDaemons/sam.pfctl.plist; /usr/libexec/PlistBuddy -c "Set:Label sam.pfctl" /Library/LaunchDaemons/sam.pfctl.plist; launchctl enable system/sam.pfctl; launchctl bootstrap system /Library/LaunchDaemons/sam.pfctl.plist; echo 'anchor "sam_pf_anchors"'>>/etc/pf.conf; echo 'load anchor "sam_pf_anchors" from "/etc/pf.anchors/sam_pf_anchors"'>>/etc/pf.conf

#  CONFIGURES THE FIREWALL TO BLOCK INCOMING APPLE FILE SERVER
echo " Configuring the FW to block incoming Apple file server requests"
echo "#apple file service pf firewall rule">> /etc/pf.anchors/sam_pf_anchors; echo "block in proto tcp to any port { 548 }">> /etc/pf.anchors/sam_pf_anchors; pfctl -f /etc/pf.conf

#  CONFIGURES THE FIREWALL TO BLOCK BONJOUR PACKETS
echo " Configuring the FW to block Bonjour packets"
echo "#bonjour pf firewall rule">> /etc/pf.anchors/sam_pf_anchors; echo "block proto udp to any port 1900">> /etc/pf.anchors/sam_pf_anchors; pfctl -f /etc/pf.conf

#  CONFIGURES THE FW TO BLOCK FINGER PACKETS - GIGGITY
echo " Configuring the FW to block finger packets"
echo "#finger pf firewall rule">> /etc/pf.anchors/sam_pf_anchors; echo "block proto tcp to any port 79">> /etc/pf.anchors/sam_pf_anchors; pfctl -f /etc/pf.conf

#  CONFIGURES THE FW TO BLOCK FTP
echo " Configuring the FW to block FTP traffic"
echo "#FTP pf firewall rule">> /etc/pf.anchors/sam_pf_anchors; echo "block in proto { tcp udp } to any port { 20 21 }">> /etc/pf.anchors/sam_pf_anchors; pfctl -f /etc/pf.conf

#  CONFIGURES THE FW TO BLOCK HTTP
echo " Configuring the FW to block incoming HTTP"
echo "#http pf firewall rule">> /etc/pf.anchors/sam_pf_anchors; echo "block in proto { tcp udp } to any port 80">> /etc/pf.anchors/sam_pf_anchors; pfctl -f /etc/pf.conf

#  CONFIGURES THE FW TO BLOCK ICMP
echo " Configuring the FW to block icmp packets"
echo "#icmp pf firewall rule">> /etc/pf.anchors/sam_pf_anchors; echo "block in proto icmp">> /etc/pf.anchors/sam_pf_anchors; pfctl -f /etc/pf.conf

#  CONFIGURES THE FW TO BLOCK IMAP
echo " Configuring the FW to block IMAP packets"
echo "#imap pf firewall rule">> /etc/pf.anchors/sam_pf_anchors; echo "block in proto tcp to any port 143">> /etc/pf.anchors/sam_pf_anchors; pfctl -f /etc/pf.conf

#  CONFIGURES THE FW TO BLOCK IMAPS
echo " Configuring the FW to block IMAPS packets"
echo "#imaps pf firewall rule">> /etc/pf.anchors/sam_pf_anchors; echo "block in proto tcp to any port 993">> /etc/pf.anchors/sam_pf_anchors; pfctl -f /etc/pf.conf

#  CONFIGURES THE FW TO BLOCK iTUNES SHARING PACKETS
echo " Configuring the FW to block iTunes sharing packets"
echo "#iTunes sharing pf firewall rule">> /etc/pf.anchors/sam_pf_anchors; echo "block proto tcp to any port 3689">> /etc/pf.anchors/sam_pf_anchors; pfctl -f /etc/pf.conf

#  CONFIGURES THE FW TO BLOCK mDNSResponder packets
echo " Configuring the FW to block mDNSResponder packets"
echo "#mDNSResponder pf firewall rule">> /etc/pf.anchors/sam_pf_anchors; echo "block proto udp to any port 5353">> /etc/pf.anchors/sam_pf_anchors; pfctl -f /etc/pf.conf

#  CONFIGURES THE FW TO BLOCK NFS PACKET
echo " Configuring the FW to block NFS packets"
echo "#nfs pf firewall rule">> /etc/pf.anchors/sam_pf_anchors; echo "block proto tcp to any port 2049">> /etc/pf.anchors/sam_pf_anchors; pfctl -f /etc/pf.conf

#  CONFIGURES THE FW TO BLOCK OPTICAL DRIVE SHARING PACKETS
echo " Configuring the FW to block Optical Drive Sharing packets"
echo "#optical drive sharing pf firewall rule">> /etc/pf.anchors/sam_pf_anchors; echo "block proto tcp to any port 49152">> /etc/pf.anchors/sam_pf_anchors; pfctl -f /etc/pf.conf

#  CONFIGURES THE FW TO BLOCK POP3 PACKETS
echo " Configuring the FW to block POP3 packets"
echo "#pop3 pf firewall rule">> /etc/pf.anchors/sam_pf_anchors; echo "block in proto tcp to any port 110">> /etc/pf.anchors/sam_pf_anchors; pfctl -f /etc/pf.conf

#  CONFIGURES THE FW TO BLOCK POP3S PACKETS
echo " Configuring the FW to block Optical Drive Sharing packets"
echo "#pop3s pf firewall rule">> /etc/pf.anchors/sam_pf_anchors; echo "block in proto tcp to any port 995">> /etc/pf.anchors/sam_pf_anchors; pfctl -f /etc/pf.conf

#  CONFIGURES THE FW TO BLOCK PRINTER SHARING PACKETS
echo " Configuring the FW to block Printer Sharing packets"
echo "#printer sharing pf firewall rule">> /etc/pf.anchors/sam_pf_anchors; echo "block in proto tcp to any port 631">> /etc/pf.anchors/sam_pf_anchors; pfctl -f /etc/pf.conf

#  CONFIGURES THE FW TO BLOCK REMOTE APPLE EVENTS PACKETS
echo " Configuring the FW to block Remote Apple Events packets"
echo "#remote apple events pf firewall rule">> /etc/pf.anchors/sam_pf_anchors; echo "block in  proto tcp to any port 3031">> /etc/pf.anchors/sam_pf_anchors; pfctl -f /etc/pf.conf

#  CONFIGURES THE FW TO BLOCK SCREEN SHARING PACKETS
echo " Configuring the FW to block Screen Sharing packets"
echo "#screen sharing pf firewall rule">> /etc/pf.anchors/sam_pf_anchors; echo "block in proto tcp to any port 5900">> /etc/pf.anchors/sam_pf_anchors; pfctl -f /etc/pf.conf

#  CONFIGURES THE FW TO BLOCK SMB PACKETS
echo " Configuring the FW to block SMB packets"
echo "#smb pf firewall rule">> /etc/pf.anchors/sam_pf_anchors; echo "block proto tcp to any port { 139 445 }">> /etc/pf.anchors/sam_pf_anchors; pfctl -f /etc/pf.conf
echo "block proto udp to any port { 137 138 }">> /etc/pf.anchors/sam_pf_anchors; pfctl -f /etc/pf.conf

#  CONFIGURES THE FW TO BLOCK SMTP PACKETS
echo " Configuring the FW to block smtp packets"
echo "#smtp pf firewall rule">> /etc/pf.anchors/sam_pf_anchors; echo "block in proto tcp to any port 25">> /etc/pf.anchors/sam_pf_anchors; pfctl -f /etc/pf.conf

#  CONFIGURES THE FW TO BLOCK SSH PACKETS
echo " Configuring the FW to block SSH packets"
echo "#ssh pf firewall rule">> /etc/pf.anchors/sam_pf_anchors; echo "block in proto { tcp udp } to any port 22">> /etc/pf.anchors/sam_pf_anchors; pfctl -f /etc/pf.conf

#  CONFIGURES THE FW TO BLOCK TELNET PACKETS
echo " Configuring the FW to block telnet"
echo "#telnet pf firewall rule">> /etc/pf.anchors/sam_pf_anchors; echo "block in proto { tcp udp } to any port 23">> /etc/pf.anchors/sam_pf_anchors; pfctl -f /etc/pf.conf

#  CONFIGURES THE FW TO BLOCK TFTP PACKETS
echo " Configuring the FW to block tftp packets"
echo "#tftp pf firewall rule">> /etc/pf.anchors/sam_pf_anchors; echo "block proto { tcp udp } to any port 69">> /etc/pf.anchors/sam_pf_anchors; pfctl -f /etc/pf.conf

#  CONFIGURES THE FW TO BLOCK UUCP PACKETS
echo " Configuring the FW to block uucp packets"
echo "#uucp pf firewall rule">> /etc/pf.anchors/sam_pf_anchors; echo "block proto tcp to any port 540">> /etc/pf.anchors/sam_pf_anchors; pfctl -f /etc/pf.conf

#  TURNS THE PF FIREWALL ON
echo " Turning on the PF firewall"
/usr/libexec/ApplicationFirewall/socketfilterfw --setglobalstate on

########################################################



########################################################
########################################################
#               ||
# OPTIMISATION  ||
#               \/
########################################################
########################################################


########################################################
#  DISABLE DING SOUND
########################################################
echo -e " Disabled boot up 'ding' sound"
sudo nvram SystemAudioVolume=" " >/dev/null

########################################################
#  DISABLE ALL ANIMATIONS
########################################################
echo " Disabling all animations."
: 'Disables all finder animations, window animations, the docks launch animation, and changes the animation lengths.'
sudo defaults write com.apple.finder DisableAllAnimations -bool true
sudo defaults write NSGlobalDomain NSAutomaticWindowAnimationsEnabled -bool false
sudo defaults write com.apple.dock launchanim -bool false
sudo defaults write com.apple.dock expose-animation-duration -float 0.1
sudo defaults write NSGlobalDomain NSWindowResizeTime -float 0.001
sudo defaults write com.apple.Dock autohide-delay -float 0
echo "[Complete] Disabled animations."

########################################################
#  DISABLE SMB1 PROTOCOL
########################################################
echo " Disabling the SMB1 protocol."
: 'Disables the extremely old SMB1 protocol.'
sudo defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool TRUE
echo "[Complete] Disabled SMB1."

########################################################
#  DISABLE EXTRA DAEMON
########################################################
echo " Disabling extra daemons."
: 'Disables facial recognition in media, telemetry, location services, FTP, java installation on demand, and netbios.'
DAE="com.apple.analyticsd com.apple.amp.mediasharingd com.apple.mediaanalysisd com.apple.mediaremoteagent com.apple.photoanalysisd com.apple.java.InstallOnDemand com.apple.voicememod com.apple.geod com.apple.locate com.apple.locationd com.apple.netbiosd com.apple.recentsd com.apple.suggestd com.apple.ftp-proxy com.apple.spindump com.apple.metadata.mds.spindump com.apple.ReportPanic com.apple.ReportCrash com.apple.ReportCrash.Self com.apple.DiagnosticReportCleanup"
for val in $DAE; do
  sudo launchctl disable system/$val
done
echo "[Complete] Disabled useless services."

########################################################
#  STOP AUTO OPEN FROM PHOTO APP
########################################################
echo -e " Stop 'Photos' app from opening automatically"
defaults -currentHost write com.apple.ImageCapture disableHotPlug -bool true

########################################################
#  ENABLE TEXT SELECTION IN QUICK LOOK
########################################################
echo -e " Enable text selection in 'Quick Look'"
defaults write com.apple.finder QLEnableTextSelection -bool true

########################################################
#  ENABLE SNAP-TO-GRID IN FINDER
########################################################
echo -e " Enabling snap-to-grid for icons in Finder"
/usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist >/dev/null 2>/dev/null
/usr/libexec/PlistBuddy -c "Set :FK_StandardViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist >/dev/null 2>/dev/null
/usr/libexec/PlistBuddy -c "Set :StandardViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist >/dev/null 2>/dev/null

########################################################
#  CLOSE PRINTER WHEN PRINTING IS FINISH
########################################################
echo -e " Close 'Printer' app when printing jobs finish"
defaults write com.apple.print.PrintingPrefs "Quit When Finished" -bool true

########################################################
#  SHOW LANGUAGE MENU IN TOP RIGHT CORNER OF THE BOOT SCREEN
########################################################
echo -e " Show language menu in the top right corner of the boot screen"
sudo defaults write /Library/Preferences/com.apple.loginwindow showInputMenu -bool true

########################################################
#  HIDE MACHINE POPUPS
########################################################
echo -e " Hide time machine popups"
defaults write com.apple.TimeMachine DoNotOfferNewDisksForBackup -bool true


########################################################
#  DISABLE HEAVY LOGIN SCREEN WALLPAPER
########################################################
echo " Disable Heavy login screen wallpaper"
sudo defaults write /Library/Preferences/com.apple.loginwindow DesktopPicture ""

########################################################
#  REDUCE MOTION AND TRANSPARENCY
########################################################
echo " Reduce Motion & Transparency"
defaults write com.apple.Accessibility DifferentiateWithoutColor -int 1
defaults write com.apple.Accessibility ReduceMotionEnabled -int 1
defaults write com.apple.universalaccess reduceMotion -int 1
defaults write com.apple.universalaccess reduceTransparency -int 1
defaults write com.apple.Accessibility ReduceMotionEnabled -int 1



#  REBOOTS THE MACHINE SO THE SETTINGS CAN TAKE EFFECT - IT ADDS A KEYPRESS AS A PAUSE BEFORE CONTINUING WITH THE REBOOT

read -r -p " The machine will now reboot to enable the hardening to take effect. Press ENTER to continue..."
sudo reboot
done

