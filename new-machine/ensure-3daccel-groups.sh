#!/bin/bash
# Ensure the current user is in video/render groups for GPU access,
# then check if 3D acceleration is actually working.

set -euo pipefail

USER_NAME=$(whoami)
CHANGED=0

for group in video render; do
    if id -nG "$USER_NAME" | tr ' ' '\n' | grep -qx "$group"; then
        echo "Already in '$group' group."
    else
        echo "Adding $USER_NAME to '$group' group..."
        sudo usermod -aG "$group" "$USER_NAME"
        CHANGED=1
    fi
done

if [ "$CHANGED" -eq 1 ]; then
    echo ""
    echo "Group membership changed. You must log out and back in for it to take effect."
    echo "Re-run this script after logging back in to verify 3D acceleration."
    exit 0
fi

# Check 3D acceleration status
echo ""
echo "=== 3D Acceleration Check ==="

if ! command -v glxinfo &>/dev/null; then
    echo "glxinfo not found. Install with: sudo apt install mesa-utils"
    exit 1
fi

RENDERER=$(glxinfo 2>/dev/null | grep "OpenGL renderer string:" | sed 's/OpenGL renderer string: //')
DIRECT=$(glxinfo 2>/dev/null | grep "direct rendering:" | awk '{print $NF}')

echo "OpenGL renderer: $RENDERER"
echo "Direct rendering: $DIRECT"

if echo "$RENDERER" | grep -qi 'llvmpipe\|softpipe\|swrast'; then
    echo ""
    echo "WARNING: Using software rendering. GPU acceleration is NOT working."
    echo "Check that /dev/dri/ devices exist and are accessible."
    ls -la /dev/dri/ 2>/dev/null || echo "/dev/dri/ does not exist!"
    exit 1
else
    echo ""
    echo "GPU acceleration is working."
fi
