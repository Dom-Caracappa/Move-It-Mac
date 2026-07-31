# Move To…

Move To… is a lightweight Finder Quick Action that adds a native **Move To…** command to the macOS context menu.

Instead of dragging files between Finder windows, simply right-click, choose **Move To…**, select a destination, and your files are moved immediately.

## Features

- Adds a **Move To…** command to the Finder context menu
- Works with both files and folders
- Remembers the last destination folder
- Detects duplicate files and folders before moving
- Prompts to Replace, Skip, or Cancel when duplicates are found
- Optional completion sound
- Implemented entirely in native AppleScript

---

## Repository Layout

```
Move-It-Mac/
├── source/
│   └── Move To.applescript     # AppleScript source code
├── workflow/
│   └── Move To.workflow        # Pre-built Quick Action
├── screenshots/
│   └── ...
├── LICENSE
└── README.md
```

If you simply want to install the utility, use the pre-built workflow.

If you would like to inspect or modify the code, use the AppleScript source.

---

# Installation

There are two ways to install Move To….

## Option 1 — Install the Pre-built Workflow (Recommended)

1. Download **Move To.workflow** from the `workflow` directory or from the latest GitHub Release.
2. Copy the file to:

```
~/Library/Services/
```

3. If Finder is already running, either:
   - Log out and back in, or
   - Restart Finder:

```
Option + Right-click Finder → Relaunch
```

Move To… will now appear in Finder under **Quick Actions**.

---

## Option 2 — Build the Quick Action Yourself

### 1. Open Automator

Launch **Automator** from Applications.

Choose **New Document**.

---

### 2. Create a Quick Action

Select **Quick Action** and click **Choose**.

Configure the workflow:

| Setting | Value |
|---------|-------|
| Workflow receives current | files or folders |
| In | Finder |

---

### 3. Add the AppleScript Action

In the Actions search bar, search for:

```
Run AppleScript
```

Drag **Run AppleScript** into the workflow.

Delete the placeholder code.

Open:

```
source/Move To.applescript
```

from this repository and copy the entire file into the AppleScript editor.

---

### 4. Save

Choose:

```
File → Save…
```

Save the Quick Action as:

```
Move To…
```

Finder will automatically make the action available in its context menu.

---

# Usage

1. Select one or more files or folders in Finder.
2. Right-click the selection.
3. Choose **Quick Actions → Move To…**
4. Select a destination folder.
5. Click **Choose**.

The selected items will be moved immediately.

The destination folder is remembered and will be pre-selected the next time the utility is used.

---

# Duplicate Handling

If a file or folder with the same name already exists in the destination, Move To… displays a confirmation dialog.

You can choose to:

- Replace
- Skip
- Cancel

This helps prevent accidental overwrites while keeping the workflow fast.

---

# Customization

Several options can be changed at the top of the AppleScript.

```applescript
property PLAY_SOUND : true
property SOUND_NAME : "Glass"
```

Set `PLAY_SOUND` to `false` to disable the completion sound.

Any built-in macOS system sound may be used by changing `SOUND_NAME`.

---

# Compatibility

Developed and tested on:

- macOS Sonoma
- macOS Sequoia

Because the utility relies only on Finder, AppleScript, and standard Unix tools, it should remain compatible with future macOS releases.

---

# License

This project is released under the MIT License.

See the `LICENSE` file for details.
