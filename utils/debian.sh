#!/usr/bin/env bash
os_arch() {
  printf $(dpkg --print-architecture)
}

os_codename() {
  printf $(awk -F'=' '/^VERSION_CODENAME=/{ print $NF }' /etc/os-release)
}

os_version() {
  printf $(awk -F'=' '/^VERSION_ID=/{ print $NF }' /etc/os-release)
}

pkg_update() {
  apt-get update -y && apt-get upgrade -y >$__OUTPUT
}

pkg_upgrade() {
   apt-get dist-upgrade -y >$__OUTPUT
}

pkg_add() {
  DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends $@ >$__OUTPUT
}

pkg_del() {
  apt-get remove --purge -y $@ >$__OUTPUT
}

pkg_clean() {
  apt-get -y -qq autoremove >$__OUTPUT
  apt-get clean >$__OUTPUT
}

svc_add() {
  systemctl daemon-reload >$__OUTPUT
  systemctl stop $@ &>$__OUTPUT
  sleep 2
  systemctl enable --now $@ >$__OUTPUT
}

svc_start() {
  systemctl start $@ >$__OUTPUT
}

svc_stop() {
  systemctl stop $@ >$__OUTPUT
}