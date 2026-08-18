#!/usr/bin/env bash
# ════════════════════════════════════════════════════════════════════════════
# Umbrella OS — Live User Session Initialization Script
# ════════════════════════════════════════════════════════════════════════════
set -e

USER_NAME="umbrella"
USER_HOME="/home/${USER_NAME}"

# Ensure user home directory exists
if [ ! -d "${USER_HOME}" ]; then
    mkdir -p "${USER_HOME}"
fi

# Populate user home directory with skel templates
if [ -d "/etc/skel" ]; then
    cp -rT /etc/skel "${USER_HOME}"
fi

# Set correct user ownership and permissions
chown -R 1000:1000 "${USER_HOME}" 2>/dev/null || chown -R "${USER_NAME}:${USER_NAME}" "${USER_HOME}" 2>/dev/null || true
chmod 750 "${USER_HOME}"

exit 0
