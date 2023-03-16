#!/bin/bash


# "Best of des regles" prises sur ces projets : 
# https://github.com/koconder/ostemper/blob/master/ostemper.sh
# https://github.com/ayethatsright/MacOS-Hardening-Script/blob/master/hardening_script.sh

# Pour Hardening et optimisation

######################################################################################################################################

# Confirming if the iCloud login prompt is turned off

echo "[i] Confirming that iCloud login prompt is turned off:"

icloudoff=$(defaults read /System/Library/User\ Template/English.lproj/Library/Preferences/com.apple.SetupAssistant DidSeeCloudSetup)
icloudoffcorrect="true"

if [ "$icloudoff" == "$icloudoffcorrect" ]; then
        echo "[YES] iCloud login is turned off"
else 
	echo "[WARNING] iCloud login is NOT turned off"
	exit 1;
fi

defaults read /System/Library/User\ Template/Enlish.lproj/Library/Preferences/com.apple.SetupAssistant DidSeeCloudSetup >> ./results.txt

sleep 1

######################################################################################################################################
#THIS SECTION TURNS OFF THE ICLOUD LOGIN PROMPT

echo "[I] Turning off iCloud login prompt"
defaults write /System/Library/User\ Template/English.lproj/Library/Preferences/com.apple.SetupAssistant DidSeeCloudSetup -bool TRUE
defaults write /System/Library/User\ Template/English/lproj/Library/Preferences/com.apple.SetupAssistant GestureMovieSeen none
defaults write /System/Library/User\ Template/English/lproj/Library/Preferences/com.apple.SetupAssistant LastSeenCloudProductVersion "10.12"
sleep 1

######################################################################################################################################
#THIS SECTION DISABLES THE INFRARED RECIEVER

echo "[I] Disabling infrared receiver"
defaults write com.apple.driver.AppleIRController DeviceEnabled -bool FALSE
sleep 1
######################################################################################################################################
#THIS SECTION ENABLED AUTOMATIC UPDATES

echo "[I] Enabling Scheduled updates"
softwareupdate --schedule on
defaults write /Library/Preferences/com.apple.SoftwareUpdate.plist AutomaticCheckEnabled -bool true
defaults write /Library/Preferences/com.apple.SoftwareUpdate.plist AutomaticDownload -bool true
defaults write /Library/Preferences/com.apple.commerce.plist AutoUpdateRestartRequired -bool true
defaults write /Library/Preferences/com.apple.commerce.plist AutoUpdate -bool true
sleep 1
######################################################################################################################################
#THIS SECTION TURNS OFF PASSWORD HINTS

echo "[I] Disabling password hints on the lock screen"
defaults write com.apple.loginwindow RetriesUntilHint -int 0
sleep 1
######################################################################################################################################
#THIS SECTION SETS THE SCREENLOCK TIMEOUT

echo "[I] Enabling password-protected screen lock after 5 minutes"
systemsetup -setdisplaysleep 5
defaults write com.apple.screensaver askForPassword -int 1
defaults write com.apple.screensaver askForPasswordDelay -int 0
sleep 1
######################################################################################################################################
#THIS SECTION SETS THE FIREWALL

echo "[I] Enabling Firewall"
/usr/libexec/ApplicationFirewall/socketfilterfw --setloggingmode on
/usr/libexec/ApplicationFirewall/socketfilterfw --setallowsigned on
/usr/libexec/ApplicationFirewall/socketfilterfw --setglobalstate on
sleep 1
######################################################################################################################################
#THIS SECTION SETS THE FIRMWARE PASSWORD

echo "[I] Setting the firmware password"
firmwarepasswd -setpasswd
sleep 1
######################################################################################################################################
csrutil status
sleep 2
######################################################################################################################################
#THIS SECTION ENABLES GATEKEEPER
spctl --master-enable
echo "[I] Gatekeeper is now enabled"
sleep 2
######################################################################################################################################
#THIS SECTION STOPS THE SENDING OF DIAGNOSTIC INFO TO APPLE

echo "[I] Stopping this machine from sending diagnostic info to Apple"
defaults write /Library/Application\ Support/CrashReporter/DiagnosticMessagesHistory.plist AutoSubmit -bool FALSE
sleep 2
######################################################################################################################################
#THIS SECTION RESTRICTS SUDO TO A SINGLE COMMAND

echo "[I] Restricting sudo authentication to a single command"
sed -i.bk 's/^Defaults[[:blank:]]timestamp_timeout.*$//' /etc/sudoers; echo "Defaults timestamp_timeout=0">>/etc/sudoers; rm /etc/sudoers.bk
sleep 2
######################################################################################################################################
#THIS SECTION REMOVES THE LIST OF USERS FROM THE LOGIN SCREEN

echo "[I] Removing the list of users from the login screen"
defaults write /Library/Preferences/com.apple.loginwindow SHOWFULLNAME -int 1
sleep 2
######################################################################################################################################

#THIS SECTION REMOVES THE ADMIN ACCOUNT FROM THE FILEVAULT LOGIN SCREEN

echo "[I] Removing the local administrator account from the FileVault login screen"
fdesetup remove -user administrator
sleep 2
######################################################################################################################################
#THIS SECTION DISABLES SIRI

echo "[I] Disabling Siri"
defaults write ~/Library/Preferences/com.apple.assistant.support.plist "Assistant Enabled" -int 0; killall -TERM Siri; killall -TERM cfpre$
sleep 2
######################################################################################################################################
#THIS SECTION TURNS ON FILE EXTENSIONS

echo "[I] Turning on file extensions which are hidden by default"
defaults write ~/Library/Preferences/.GlobalPreferences.plist AppleShowAllExtensions -bool TRUE; killall -HUP Finder; killall -HUP cfprefsd
sleep 2
######################################################################################################################################

#THIS SECTION PREVENTS OTHER APPLICATIONS FROM INTERCEPTING TEXT TYPED IN TO TERMINAL

echo "[I] Enabling secure Terminal keyboard to prevent other applications from intercepting anything typed in to terminal"
defaults write ~/Library/Preferences/com.apple.Terminal.plist SecureKeyboardEntry -int 1

#THIS SECTION PREVENTS DOWNLOADED SIGNED SOFTWARE FROM RECIEVING INCOMING CONNECTIONS

echo "[I] Preventing signed downloads from recieving incoming connections"
/usr/libexec/ApplicationFirewall/socketfilterfw --setallowsignedapp off
sleep 2

#THIS SECTION ENABLES PFSENSE AND CONFIGURES SOME ITEMS

echo "[I] Enabling pfsense and configuring secure options"
pfctl -e 2> /dev/null; cp /System/Library/LaunchDaemons/com.apple.pfctl.plist /Library/LaunchDaemons/sam.pfctl.plist; /usr/libexec/PlistBuddy -c "Add :ProgramArguments:1 string -e" /Library/LaunchDaemons/sam.pfctl.plist; /usr/libexec/PlistBuddy -c "Set:Label sam.pfctl" /Library/LaunchDaemons/sam.pfctl.plist; launchctl enable system/sam.pfctl; launchctl bootstrap system /Library/LaunchDaemons/sam.pfctl.plist; echo 'anchor "sam_pf_anchors"'>>/etc/pf.conf; echo 'load anchor "sam_pf_anchors" from "/etc/pf.anchors/sam_pf_anchors"'>>/etc/pf.conf
sleep 2

#THIS SECTION CONFIGURES THE FIREWALL TO BLOCK INCOMING APPLE FILE SERVER

echo "[I] Configuring the FW to block incoming Apple file server requests"
echo "#apple file service pf firewall rule">> /etc/pf.anchors/sam_pf_anchors; echo "block in proto tcp to any port { 548 }">> /etc/pf.anchors/sam_pf_anchors; pfctl -f /etc/pf.conf
sleep 2



######################################################################################################################################
#FW
######################################################################################################################################

#THIS SECTION CONFIGURES THE FIREWALL TO BLOCK BONJOUR PACKETS
echo "[I] Configuring the FW to block Bonjour packets"
echo "#bonjour pf firewall rule">> /etc/pf.anchors/sam_pf_anchors; echo "block proto udp to any port 1900">> /etc/pf.anchors/sam_pf_anchors; pfctl -f /etc/pf.conf
sleep 2
#THIS SECTION CONFIGURES THE FW TO BLOCK FINGER PACKETS - GIGGITY
echo "[I] Configuring the FW to block finger packets"
echo "#finger pf firewall rule">> /etc/pf.anchors/sam_pf_anchors; echo "block proto tcp to any port 79">> /etc/pf.anchors/sam_pf_anchors; pfctl -f /etc/pf.conf
sleep 2
#THIS SECTION CONFIGURES THE FW TO BLOCK FTP
echo "[I] Configuring the FW to block FTP traffic"
echo "#FTP pf firewall rule">> /etc/pf.anchors/sam_pf_anchors; echo "block in proto { tcp udp } to any port { 20 21 }">> /etc/pf.anchors/sam_pf_anchors; pfctl -f /etc/pf.conf
sleep 2
#THIS SECTION CONFIGURES THE FW TO BLOCK HTTP
echo "[I] Configuring the FW to block incoming HTTP"
echo "#http pf firewall rule">> /etc/pf.anchors/sam_pf_anchors; echo "block in proto { tcp udp } to any port 80">> /etc/pf.anchors/sam_pf_anchors; pfctl -f /etc/pf.conf
sleep 2
#THIS SECTION CONFIGURES THE FW TO BLOCK ICMP
echo "[I] Configuring the FW to block icmp packets"
echo "#icmp pf firewall rule">> /etc/pf.anchors/sam_pf_anchors; echo "block in proto icmp">> /etc/pf.anchors/sam_pf_anchors; pfctl -f /etc/pf.conf
sleep 2
#THIS SECTION CONFIGURES THE FW TO BLOCK IMAP
echo "[I] Configuring the FW to block IMAP packets"
echo "#imap pf firewall rule">> /etc/pf.anchors/sam_pf_anchors; echo "block in proto tcp to any port 143">> /etc/pf.anchors/sam_pf_anchors; pfctl -f /etc/pf.conf
sleep 2
#THIS SECTION CONFIGURES THE FW TO BLOCK IMAPS
echo "[I] Configuring the FW to block IMAPS packets"
echo "#imaps pf firewall rule">> /etc/pf.anchors/sam_pf_anchors; echo "block in proto tcp to any port 993">> /etc/pf.anchors/sam_pf_anchors; pfctl -f /etc/pf.conf
sleep 2
#THIS SECTION CONFIGURES THE FW TO BLOCK iTUNES SHARING PACKETS
echo "[I] Configuring the FW to block iTunes sharing packets"
echo "#iTunes sharing pf firewall rule">> /etc/pf.anchors/sam_pf_anchors; echo "block proto tcp to any port 3689">> /etc/pf.anchors/sam_pf_anchors; pfctl -f /etc/pf.conf
sleep 2
#THIS SECTION CONFIGURES THE FW TO BLOCK mDNSResponder packets
echo "[I] Configuring the FW to block mDNSResponder packets"
echo "#mDNSResponder pf firewall rule">> /etc/pf.anchors/sam_pf_anchors; echo "block proto udp to any port 5353">> /etc/pf.anchors/sam_pf_anchors; pfctl -f /etc/pf.conf
sleep 2
#THIS SECTION CONFIGURES THE FW TO BLOCK NFS PACKET
echo "[I] Configuring the FW to block NFS packets"
echo "#nfs pf firewall rule">> /etc/pf.anchors/sam_pf_anchors; echo "block proto tcp to any port 2049">> /etc/pf.anchors/sam_pf_anchors; pfctl -f /etc/pf.conf
sleep 2
#THIS SECTION CONFIGURES THE FW TO BLOCK OPTICAL DRIVE SHARING PACKETS
echo "[I] Configuring the FW to block Optical Drive Sharing packets"
echo "#optical drive sharing pf firewall rule">> /etc/pf.anchors/sam_pf_anchors; echo "block proto tcp to any port 49152">> /etc/pf.anchors/sam_pf_anchors; pfctl -f /etc/pf.conf
sleep 2
#THIS SECTION CONFIGURES THE FW TO BLOCK POP3 PACKETS
echo "[I] Configuring the FW to block POP3 packets"
echo "#pop3 pf firewall rule">> /etc/pf.anchors/sam_pf_anchors; echo "block in proto tcp to any port 110">> /etc/pf.anchors/sam_pf_anchors; pfctl -f /etc/pf.conf
sleep 2
#THIS SECTION CONFIGURES THE FW TO BLOCK POP3S PACKETS
echo "[I] Configuring the FW to block Optical Drive Sharing packets"
echo "#pop3s pf firewall rule">> /etc/pf.anchors/sam_pf_anchors; echo "block in proto tcp to any port 995">> /etc/pf.anchors/sam_pf_anchors; pfctl -f /etc/pf.conf
sleep 2
#THIS SECTION CONFIGURES THE FW TO BLOCK PRINTER SHARING PACKETS
echo "[I] Configuring the FW to block Printer Sharing packets"
echo "#printer sharing pf firewall rule">> /etc/pf.anchors/sam_pf_anchors; echo "block in proto tcp to any port 631">> /etc/pf.anchors/sam_pf_anchors; pfctl -f /etc/pf.conf
sleep 2
#THIS SECTION CONFIGURES THE FW TO BLOCK REMOTE APPLE EVENTS PACKETS
echo "[I] Configuring the FW to block Remote Apple Events packets"
echo "#remote apple events pf firewall rule">> /etc/pf.anchors/sam_pf_anchors; echo "block in  proto tcp to any port 3031">> /etc/pf.anchors/sam_pf_anchors; pfctl -f /etc/pf.conf
sleep 2
#THIS SECTION CONFIGURES THE FW TO BLOCK SCREEN SHARING PACKETS
echo "[I] Configuring the FW to block Screen Sharing packets"
echo "#screen sharing pf firewall rule">> /etc/pf.anchors/sam_pf_anchors; echo "block in proto tcp to any port 5900">> /etc/pf.anchors/sam_pf_anchors; pfctl -f /etc/pf.conf
sleep 2
#THIS SECTION CONFIGURES THE FW TO BLOCK SMB PACKETS
echo "[I] Configuring the FW to block SMB packets"
echo "#smb pf firewall rule">> /etc/pf.anchors/sam_pf_anchors; echo "block proto tcp to any port { 139 445 }">> /etc/pf.anchors/sam_pf_anchors; pfctl -f /etc/pf.conf
echo "block proto udp to any port { 137 138 }">> /etc/pf.anchors/sam_pf_anchors; pfctl -f /etc/pf.conf
sleep 2
#THIS SECTION CONFIGURES THE FW TO BLOCK SMTP PACKETS
echo "[I] Configuring the FW to block smtp packets"
echo "#smtp pf firewall rule">> /etc/pf.anchors/sam_pf_anchors; echo "block in proto tcp to any port 25">> /etc/pf.anchors/sam_pf_anchors; pfctl -f /etc/pf.conf
sleep 2
#THIS SECTION CONFIGURES THE FW TO BLOCK SSH PACKETS
echo "[I] Configuring the FW to block SSH packets"
echo "#ssh pf firewall rule">> /etc/pf.anchors/sam_pf_anchors; echo "block in proto { tcp udp } to any port 22">> /etc/pf.anchors/sam_pf_anchors; pfctl -f /etc/pf.conf
sleep 2
#THIS SECTION CONFIGURES THE FW TO BLOCK TELNET PACKETS
echo "[I] Configuring the FW to block telnet"
echo "#telnet pf firewall rule">> /etc/pf.anchors/sam_pf_anchors; echo "block in proto { tcp udp } to any port 23">> /etc/pf.anchors/sam_pf_anchors; pfctl -f /etc/pf.conf
sleep 2
#THIS SECTION CONFIGURES THE FW TO BLOCK TFTP PACKETS
echo "[I] Configuring the FW to block tftp packets"
echo "#tftp pf firewall rule">> /etc/pf.anchors/sam_pf_anchors; echo "block proto { tcp udp } to any port 69">> /etc/pf.anchors/sam_pf_anchors; pfctl -f /etc/pf.conf
sleep 2
#THIS SECTION CONFIGURES THE FW TO BLOCK UUCP PACKETS
echo "[I] Configuring the FW to block uucp packets"
echo "#uucp pf firewall rule">> /etc/pf.anchors/sam_pf_anchors; echo "block proto tcp to any port 540">> /etc/pf.anchors/sam_pf_anchors; pfctl -f /etc/pf.conf
sleep 2
#THIS SECTION TURNS THE PF FIREWALL ON
echo "[I] Turning on the PF firewall"
/usr/libexec/ApplicationFirewall/socketfilterfw --setglobalstate on
sleep 2
######################################################################################################################################


#THIS SECTION PREVENTS ANY ACTION WHEN INSERTING A BLANK CD
echo "[I] Preventing any actions when a blank CD is inserted"
defaults write ~/Library/Preferences/com.apple.digihub.plist com.apple.digihub.blank.cd.appeared -dict action -int 1; killall -HUP SystemUIServer; killall -HUP cfprefsd
sleep 2
#THIS SECTION PREVENTS ANY ACTION WHEN INSERTING A BLANK DVD
echo "[I] Preventing any actions when a blank DVD is inserted"
defaults write ~/Library/Preferences/com.apple.digihub.plist com.apple.digihub.blank.dvd.appeared -dict action -int 1; killall -HUP SystemUIServer; killall -HUP cfprefsd
sleep 2
#THIS SECTION PREVENTS ANY ACTION WHEN INSERTING A MUSIC CD
echo "[I] Preventing any actions when a music CD is inserted"
defaults write ~/Library/Preferences/com.apple.digihub.plist com.apple.digihub.cd.music.appeared -dict action -int 1; killall -HUP SystemUIServer; killall -HUP cfprefsd
sleep 2
#THIS SECTION PREVENTS ANY ACTION WHEN INSERTING A PICTURE CD
echo "[I] Preventing any actions when a picture CD is inserted"
defaults write ~/Library/Preferences/com.apple.digihub.plist com.apple.digihub.cd.picture.appeared -dict action -int 1; killall -HUP SystemUIServer; killall -HUP cfprefsd
sleep 2
#THIS SECTION PREVENTS ANY ACTION WHEN INSERTING A VIDEO DVD
echo "[I] Preventing any actions when a DVD containing video is inserted"
defaults write ~/Library/Preferences/com.apple.digihub.plist com.apple.digihub.dvd.video.appeared -dict action -int 1; killall -HUP SystemUIServer; killall -HUP cfprefsd
sleep 2

#THIS SECTION DISABLES THE FILE SHARING DAEMON
echo "[I] Disabling the filesharing daemon"
launchctl disable system/com.apple.smbd; launchctl bootout system/com.apple.smbd; launchctl disable system/com.apple.AppleFileServer; launchctl bootout system/com.apple.AppleFileServer
sleep 2


#THIS SECTION PREVENTS THE COMPUTER FROM BROADCASTING BONJOUR SERVICE ADVERTS
echo "[I] Preventing the computer from broadcasting Bonjour service advertisements"
defaults write /Library/Preferences/com.apple.mDNSResponder.plist NoMulticastAdvertisements -bool true
sleep 2
#THIS SECTION DISABLES NFS SERVER DAEMON
echo "[I] Disabling the NFS server daemon"
launchctl disable system/com.apple.nfsd; launchctl bootout system/com.apple.nfsd; launchctl disable system/com.apple.lockd; launchctl bootout system/com.apple.lockd; launchctl disable system/com.apple.statd.notify; launchctl bootout system/com.apple.statd.notify
sleep 2
#THIS SECTION DISABLES THE PUBLIC KEY AUTHENTICATION MECHANISM
echo "[I] Disabling the public key authentication mechanism for SSH"
sed -i.bak 's/.*PubkeyAuthentication.*/PubkeyAuthentication no/' /etc/ssh/sshd_config
sleep 2
#THIS SECTION PREVENTS ROOT LOGIN VIA SSH
echo "[I] Preventing root login via SSH"
sed -i.bak 's/.*PermitRootLogin.*/PermitRootLogin no/' /etc/ssh/sshd_config
sleep 2

#THIS SECTION LIMITS THE NUMBER OF AUTHENTICATION ATTEMPTS BEFORE DISCONNECTING THE CLIENT
echo "[I] Setting the number of authentication attempts before disconnecting the client to four"
sed -i.bak 's/.*maxAuthTries.*/maxAuthTries 4/' /etc/ssh/sshd_config
sleep 2

#THIS SECTION REBOOTS THE MACHINE SO THE SETTINGS CAN TAKE EFFECT - IT ADDS A KEYPRESS AS A PAUSE BEFORE CONTINUING WITH THE REBOOT
read -r -p "[I] The machine will now reboot to enable the hardening to take effect. Press ENTER to continue..."
sudo reboot
done





echo -e "\t|- [\033[32m+\033[m] System tweaks / Disabled boot up 'ding' sound"
sudo nvram SystemAudioVolume=" " >/dev/null


echo -e "\t|- [\033[32m+\033[m] Security tweaks / Enabling scheduled updates"
softwareupdate --schedule on >/dev/null
defaults write /Library/Preferences/com.apple.SoftwareUpdate.plist AutomaticCheckEnabled -bool true
defaults write /Library/Preferences/com.apple.SoftwareUpdate.plist AutomaticDownload -bool true
defaults write /Library/Preferences/com.apple.commerce.plist AutoUpdateRestartRequired -bool true
defaults write /Library/Preferences/com.apple.commerce.plist AutoUpdate -bool true


echo -e "\t|- [\033[32m+\033[m] Security tweaks / Check for App Updates daily, not just once a week"
defaults write com.apple.SoftwareUpdate ScheduleFrequency -int 1


echo -e "\t|- [\033[32m+\033[m] Security tweaks / Disable IPV6 on Wi-fi and Ethernet adapters"
#TODO: Scan all adapters and replicate
networksetup -setv6off Wi-Fi >/dev/null
networksetup -setv6off Ethernet >/dev/null


echo -e "\t|- [\033[32m+\033[m] Security tweaks / Disable infared"
defaults write /Library/Preferences/com.apple.driver.AppleIRController DeviceEnabled -int 0


echo -e "\t|- [\033[32m+\033[m] Security tweaks / Disable guest login access"
defaults write /Library/Preferences/com.apple.AppleFileServer guestAccess -bool NO
defaults write /Library/Preferences/SystemConfiguration/com.apple.smb.server AllowGuestAccess -bool NO


echo -e "\t|- [\033[32m+\033[m] Security tweaks / Disable SSH access"
launchctl unload -w /System/Library/LaunchDaemons/ssh.plist >/dev/null 2>/dev/null


echo -e "\t|- [\033[32m+\033[m] Security tweaks / Enable gatekeeper"
spctl --master-enable >/dev/null


echo -e "\t|- [\033[32m+\033[m] Security tweaks / Send 'Do Not Track' header in Safari"
defaults write com.apple.safari SendDoNotTrackHTTPHeader -int 1


echo -e "\t|- [\033[32m+\033[m] Security tweaks / Disable potential DNS leaks"
defaults write /Library/Preferences/com.apple.mDNSResponder.plist NoMulticastAdvertisements -bool YES


echo -e "\t|- [\033[32m+\033[m] Security tweaks / Disable Apple remote events"
systemsetup -setremoteappleevents off >/dev/null 2>/dev/null


echo -e "\t|- [\033[32m+\033[m] Security tweaks / Disable Apple remote agent and remove access"
/System/Library/CoreServices/RemoteManagement/ARDAgent.app/Contents/Resources/kickstart -deactivate -configure -access -off >/dev/null 2>/dev/null

echo -e "\t|- [\033[32m+\033[m] Security tweaks / Disable crash reporting"
defaults write com.apple.CrashReporter DialogType none


echo -e "\t|- [\033[32m+\033[m] Security tweaks / New documents disable auto-save to iCloud"
defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false


echo -e "\t\- [\033[32m+\033[m] Security tweaks / Disable search data leaking in safari"
defaults write com.apple.Safari UniversalSearchEnabled -bool false
defaults write com.apple.Safari SuppressSearchSuggestions -bool true
defaults write com.apple.Safari.plist WebsiteSpecificSearchEnabled -bool NO

######################################################################################################################################
######################################################################################################################################
#              ||
#Optimisation  ||
#              \/
######################################################################################################################################
######################################################################################################################################

echo "Disabling all animations."
: 'Disables all finder animations, window animations, the docks launch animation, and changes the animation lengths.'
sudo defaults write com.apple.finder DisableAllAnimations -bool true
sudo defaults write NSGlobalDomain NSAutomaticWindowAnimationsEnabled -bool false
sudo defaults write com.apple.dock launchanim -bool false
sudo defaults write com.apple.dock expose-animation-duration -float 0.1
sudo defaults write NSGlobalDomain NSWindowResizeTime -float 0.001
sudo defaults write com.apple.Dock autohide-delay -float 0
echo "[Complete] Disabled animations."

echo "Disabling the SMB1 protocol."
: 'Disables the extremely old SMB1 protocol.'
sudo defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool TRUE
echo "[Complete] Disabled SMB1."


echo "Disabling extra daemons."
: 'Disables facial recognition in media, telemetry, location services, FTP, java installation on demand, and netbios.'
DAE="com.apple.analyticsd com.apple.amp.mediasharingd com.apple.mediaanalysisd com.apple.mediaremoteagent com.apple.photoanalysisd com.apple.java.InstallOnDemand com.apple.voicememod com.apple.geod com.apple.locate com.apple.locationd com.apple.netbiosd com.apple.recentsd com.apple.suggestd com.apple.ftp-proxy com.apple.spindump com.apple.metadata.mds.spindump com.apple.ReportPanic com.apple.ReportCrash com.apple.ReportCrash.Self com.apple.DiagnosticReportCleanup"
for val in $DAE; do
  sudo launchctl disable system/$val
done
echo "[Complete] Disabled useless services."


echo -e "\t|- [\033[32m+\033[m] System tweaks / Disabled boot up 'ding' sound"
sudo nvram SystemAudioVolume=" " >/dev/null

echo -e "\t|- [\033[32m+\033[m] System tweaks / Stop 'Photos' app from opening automatically"
defaults -currentHost write com.apple.ImageCapture disableHotPlug -bool true

echo -e "\t|- [\033[32m+\033[m] System tweaks / Enable text selection in 'Quick Look'"
defaults write com.apple.finder QLEnableTextSelection -bool true


echo -e "\t|- [\033[32m+\033[m] System tweaks / Enabling snap-to-grid for icons in Finder"
/usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist >/dev/null 2>/dev/null
/usr/libexec/PlistBuddy -c "Set :FK_StandardViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist >/dev/null 2>/dev/null
/usr/libexec/PlistBuddy -c "Set :StandardViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist >/dev/null 2>/dev/null


echo -e "\t|- [\033[32m+\033[m] System tweaks / Close 'Printer' app when printing jobs finish"
defaults write com.apple.print.PrintingPrefs "Quit When Finished" -bool true


echo -e "\t|- [\033[32m+\033[m] System tweaks / Show language menu in the top right corner of the boot screen"
sudo defaults write /Library/Preferences/com.apple.loginwindow showInputMenu -bool true


echo -e "\t|- [\033[32m+\033[m] System tweaks / Hide time machine popups"
defaults write com.apple.TimeMachine DoNotOfferNewDisksForBackup -bool true


echo -e "\t|- [\033[32m+\033[m] Developer tweaks / Show all file extensions"
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

