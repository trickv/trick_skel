#!/usr/bin/env bash

# https://chatgpt.com/share/6929038f-4f94-800e-a0f8-452a72508fbb

set -euo pipefail

if [[ $EUID -ne 0 ]]; then
  echo "Run as root (sudo $0)" >&2
  exit 1
fi

OS="$(. /etc/os-release && echo "$ID")"

echo "==> Installing unattended-upgrades..."
apt-get install -y unattended-upgrades

echo "==> Enabling daily unattended upgrades..."
cat >/etc/apt/apt.conf.d/20auto-upgrades <<'EOF'
APT::Periodic::Update-Package-Lists "1";
APT::Periodic::Unattended-Upgrade "1";
EOF

echo "==> Generating unattended-upgrades config for $OS..."

if [[ "$OS" == "ubuntu" ]]; then
  ORIGINS=$(cat <<'EOF'
"${distro_id}:${distro_codename}";
"${distro_id}:${distro_codename}-security";
"${distro_id}:${distro_codename}-updates";
EOF
)
else  # Debian / Raspberry Pi OS
  ORIGINS=$(cat <<'EOF'
"Debian:${distro_codename}";
"Debian:${distro_codename}-security";
"Debian:${distro_codename}-updates";
"RaspberryPi:${distro_codename}";
EOF
)
fi

cat >/etc/apt/apt.conf.d/50unattended-upgrades <<EOF
Unattended-Upgrade::Allowed-Origins {
    $ORIGINS
};

Unattended-Upgrade::Remove-Unused-Dependencies "true";

Unattended-Upgrade::Automatic-Reboot "true";
Unattended-Upgrade::Automatic-Reboot-WithUsers "true";
Unattended-Upgrade::Automatic-Reboot-Time "02:00";
EOF

systemctl enable --now unattended-upgrades.service >/dev/null 2>&1 || true

echo
echo "✔ unattended-upgrades installed + enabled"
echo "✔ nightly updates active"
echo "✔ reboot only when needed + scheduled for 02:00"
echo
echo "Cancel queued reboot anytime with:  sudo shutdown -c"
