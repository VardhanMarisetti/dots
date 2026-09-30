
#!/bin/bash

# Define the icons for 8 stages of the day (3 hours each)
icons=("┃" "┃\n┃" "┃\n┃\n┃" "┃\n┃\n┃\n┃")
# icons=("█" "█\n█" "█\n█\n█" "█\n█\n█\n█")
# icons=("━" "━━" "━━━" "━━━━" "━━━━━" "━━━━━━" "━━━━━━━" "━━━━━━━━")
# icons=("■" "■■" "■■■■" "■■■■■■■" "■■■■■■■■■■■" "■■■■■■■■■■■■■■■■" "■■■■■■■■■■■■■■■■■■■■■■" "■■■■■■■■■■■■■■■■■■■■■■■■■■■■■")
# icons=("■" "■■" "■■■" "■■■■■" "■■■■■■■■" "■■■■■■■■■■■■■" "■■■■■■■■■■■■■■■■■■■■■" "■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■")
# icons=("■■" "■■■" "■■■■" "■■■■■" "■■■■■■" "■■■■■■■" "■■■■■■■■" "■■■■■■■■■" "■■■■■■■■■■" "■■■■■■■■■■■" "■■■■■■■■■■■■" "■■■■■■■■■■■■■" "■■■■■■■■■■■■■■" "■■■■■■■■■■■■■■■" "■■■■■■■■■■■■■■■■" "■■■■■■■■■■■■■■■■■" "■■■■■■■■■■■■■■■■■■" "■■■■■■■■■■■■■■■■■■■" "■■■■■■■■■■■■■■■■■■■■" "■■■■■■■■■■■■■■■■■■■■■" "■■■■■■■■■■■■■■■■■■■■■■" "■■■■■■■■■■■■■■■■■■■■■■■" "■■■■■■■■■■■■■■■■■■■■■■■■" "■■■■■■■■■■■■■■■■■■■■■■■■■")

# Get the current hour in 24-hour format (00-23)
current_hour=$(date +%H)

# Calculate the array index by dividing the current hour by X
# This gives an index from 0 (for 00:00-02:59) to 7 (for 21:00-23:59)
index=$((10#$current_hour / 6))

# Get the corresponding icon
icon=${icons[$index]}

# --- Tooltip Information (Optional but helpful) ---
# Get current time for the tooltip
current_time=$(date +"%H%M")
# Calculate the percentage of the day that has passed
minutes_passed=$((10#$current_hour * 60 + 10#$(date +%M)))
progress_percentage=$((minutes_passed * 100 / 1440))

tooltip="$current_time / $progress_percentage"

# --- JSON Output for Waybar ---
# Print the JSON object with the icon and tooltip
printf '{"text": "%s", "tooltip": "%s", "class": "day-progress"}\n' "$icon" "$tooltip"
