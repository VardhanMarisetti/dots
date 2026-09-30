#!/usr/bin/env bash

# ========= CONFIG =========
SPACER=" "   # Change this to "" or "  " or " " to adjust spacing
STATE_FILE="/tmp/waybar_center_mode"  # remembers which mode you're on
# ==========================

# Initialize state file if missing
if [ ! -f "$STATE_FILE" ]; then
    echo 0 > "$STATE_FILE"
fi

mode=$(cat "$STATE_FILE")

# --- Helpers ---
blocks=(▁ ▂ ▃ ▄ ▅ ▆ ▇ █)

# Day Timeline: 8 bars for 24h (3h each)
day_timeline() {
    hour=$(date +%H)
    minute=$(date +%M)
    chunk=$((hour / 3))  # which 3h block
    progress=$(( (hour % 3) * 60 + minute ))
    level=$(( progress * 8 / 180 )) # fill level 0–7

    out=()
    for i in $(seq 0 7); do
        if [ $i -lt $chunk ]; then
            out+=(${blocks[7]})
        elif [ $i -eq $chunk ]; then
            out+=(${blocks[$level]})
        else
            out+=(${blocks[0]})
        fi
    done
    echo "${out[*]}" | sed "s/ /$SPACER/g"
}

# Binary Time: 8 bits (hour+minute)
binary_time() {
    hour=$(date +%H)
    min=$(date +%M)
    val=$((hour * 60 + min))  # compress to single number
    out=()
    for i in {7..0}; do
        bit=$(( (val >> i) & 1 ))
        if [ $bit -eq 1 ]; then
            out+=(${blocks[$((RANDOM % 8))]})
        else
            out+=(${blocks[0]})
        fi
    done
    echo "${out[*]}" | sed "s/ /$SPACER/g"
}

# Moon Phase (8 segments)
moon_phase() {
    # Simple approximation
    phase=$(python3 - <<'EOF'
import math, datetime
now = datetime.datetime.utcnow()
# algorithm approx
lp = 2551443  # length of lunar cycle in seconds
new_moon = datetime.datetime(2000, 1, 6, 18, 14)
seconds = (now - new_moon).total_seconds()
phase = (seconds % lp) / lp
print(int(round(phase * 7)))
EOF
)
    out=()
    for i in $(seq 0 7); do
        if [ $i -eq $phase ]; then
            out+=(${blocks[7]})
        elif [ $i -lt $phase ]; then
            out+=(${blocks[$((7 - (phase - i)))]})
        else
            out+=(${blocks[0]})
        fi
    done
    echo "${out[*]}" | sed "s/ /$SPACER/g"
}

# --- Output based on mode ---
case $mode in
    0) day_timeline ;;
    1) binary_time ;;
    2) moon_phase ;;
esac
