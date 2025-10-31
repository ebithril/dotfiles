#!/bin/bash

# Use quickshell IPC or similar mechanism
# For now, we'll use a different approach - send a key event back
# Or we can use the gear button toggle

# Since quickshell doesn't have easy IPC, let's just trigger the gear button
# by sending a click to it programmatically would be complex

# Alternative: Use hyprland to focus and send keys
# This is a workaround - ideally quickshell would have IPC

# For now, let's just document that ALT+D should be removed
# and users should use the gear button

echo "Control center toggle via keyboard shortcut is not yet implemented."
echo "Please use the gear button in the bar to toggle the control center."
