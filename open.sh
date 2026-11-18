#!/bin/bash

# 1. Check if a folder argument was provided (defaults to current folder ".")
DIR="${1:-.}"

# 2. Verify main.typ exists in that directory
if [[ ! -f "$DIR/main.typ" ]]; then
    echo "Error: '$DIR/main.typ' not found."
    exit 1
fi

# 3. Compile once first so main.pdf definitely exists before Zathura opens
typst compile "$DIR/main.typ" "$DIR/main.pdf" || exit 1

# 4. Start typst watch in the background and save its Process ID (PID)
typst watch "$DIR/main.typ" "$DIR/main.pdf" &
WATCH_PID=$!

# 5. Automatically kill typst watch when this script exits (i.e., when you close Zathura)
trap "kill $WATCH_PID 2>/dev/null" EXIT

# 6. Open Zathura in the foreground (script waits here until you close the window)
zathura "$DIR/main.pdf"
