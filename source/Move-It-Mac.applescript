(*
-------------------------------------------------------
Move To…
Finder Quick Action

Version: 2.0
Author: Dom Caracappa
License: MIT

Moves selected Finder items to a destination chosen
by the user.

Features
---------
• Remembers last destination
• Duplicate detection
• Replace / Skip / Cancel
• Friendly notifications

Compatible:
macOS Sonoma+
-------------------------------------------------------
*)
property version : "2.0.0"
property PLAY_SOUND : true
property SOUND_NAME : "Glass"
on run {input, parameters}
	
	--------------------------------------------------
	-- Preferences
	--------------------------------------------------
	
	set prefsFile to POSIX path of (path to library folder from user domain) & "Preferences/com.moveto.lastfolder"
	
	--------------------------------------------------
	-- Validate Selection
	--------------------------------------------------
	
	if input is {} then
		display alert "Move To…" message "No files or folders were selected."
		return input
	end if
	
	--------------------------------------------------
	-- Load Last Destination
	--------------------------------------------------
	
	set defaultLocation to (path to home folder)
	
	try
		set lastPath to do shell script "/bin/cat " & quoted form of prefsFile
		
		try
			do shell script "test -d " & quoted form of lastPath
			set defaultLocation to POSIX file lastPath
		end try
	end try
	
	--------------------------------------------------
	-- Choose Destination
	--------------------------------------------------
	
	set destinationFolder to ¬
		choose folder with prompt ¬
			"Move selected items to:" default location defaultLocation
	
	set destPath to POSIX path of destinationFolder
	
	--------------------------------------------------
	-- Save Destination
	--------------------------------------------------
	
	do shell script "/bin/mkdir -p " & quoted form of (POSIX path of (path to library folder from user domain) & "Preferences")
	
	do shell script "/bin/echo " & quoted form of destPath & " > " & quoted form of prefsFile
	
	--------------------------------------------------
	-- Move Items
	--------------------------------------------------
	
	set movedCount to 0
	set skippedCount to 0
	
	repeat with anItem in input
		
		set sourcePath to POSIX path of (anItem as alias)
		
		tell application "System Events"
			set itemName to name of disk item sourcePath
		end tell
		
		set destinationItem to destPath & itemName
		
		set existsAlready to false
		
		try
			do shell script "test -e " & quoted form of destinationItem
			set existsAlready to true
		end try
		
		if existsAlready then
			set dialogMessage to "A file or folder named:" & return & return & ¬
				"“" & itemName & "”" & return & return & ¬
				"already exists in:" & return & return & ¬
				destPath & return & return & ¬
				"What would you like to do?"
			
			set userChoice to button returned of (display dialog dialogMessage ¬
				buttons {"Skip", "Replace", "Cancel"} ¬
				default button ¬
				"Skip" with title "Duplicate Item")
			
			if userChoice is "Cancel" then
				return input
				
			else if userChoice is "Skip" then
				set skippedCount to skippedCount + 1
				
			else if userChoice is "Replace" then
				do shell script "/bin/rm -rf " & quoted form of destinationItem
				do shell script "/bin/mv " & quoted form of sourcePath & " " & quoted form of destPath
				set movedCount to movedCount + 1
			end if
			
		else
			
			do shell script "/bin/mv " & quoted form of sourcePath & " " & quoted form of destPath
			set movedCount to movedCount + 1
			
		end if
		
	end repeat
	
	--------------------------------------------------
	-- Completion Notification
	--------------------------------------------------
	
	if PLAY_SOUND then
		try
			do shell script "afplay /System/Library/Sounds/" & SOUND_NAME & ".aiff"
		end try
	end if
	return input
end run
