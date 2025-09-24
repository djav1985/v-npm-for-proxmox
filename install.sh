#!/usr/bin/env sh
export EPS_BASE_URL=${EPS_BASE_URL:-https://raw.githubusercontent.com/djav1985/v-npm-for-proxmox/main}
export EPS_CT_INSTALL=false

CLR_RD="\033[0;31m"
CLR_RDB="\033[1;31m"
CLR_CYB="\033[1;36m"
CLR="\033[m"

log_error () {
  printf "${CLR_RDB}✘ ${CLR_RD}$1${CLR}\n"
  exit 1
}

while [ "$#" -gt 0 ]; do
  case $1 in
    --app) 
      EPS_APP_NAME="$2"
      shift;;
    --cleanup)
      EPS_CLEANUP=true
      ;;
    *)
      log_error "Unrecognized option: ${CLR_CYB}$1${CLR}";;
  esac
  shift
done

SUPPORTED_APP="nginx-proxy-manager"
EPS_APP_NAME=${EPS_APP_NAME:-$SUPPORTED_APP}
export EPS_CLEANUP=${EPS_CLEANUP:-false}

if [ "$EPS_APP_NAME" != "$SUPPORTED_APP" ]; then
  log_error "Unsupported application: ${CLR_CYB}$EPS_APP_NAME${CLR}"
fi

EPS_APP_REMOTE_PATH="$EPS_BASE_URL/app"
export EPS_APP_CONFIG=$(wget --no-cache -qO- "$EPS_APP_REMOTE_PATH"/config.sh)
if [ $? -gt 0 ]; then
  log_error "No config found at ${CLR_CYB}$EPS_APP_REMOTE_PATH${CLR}"
fi

EPS_APP_INSTALL=$(wget --no-cache -qO- "$EPS_APP_REMOTE_PATH"/install.sh)
if [ $? -gt 0 ]; then
  log_error "No install script found at ${CLR_CYB}$EPS_APP_REMOTE_PATH${CLR}"
fi

export EPS_OS_NAME=$(uname)
export EPS_OS_DISTRO=$(awk -F'=' '/^ID=/{ print $NF }' /etc/os-release)

if [ "$EPS_OS_NAME" != "Linux" ]; then
  log_error "OS not supported: ${CLR_CYB}$EPS_OS_NAME${CLR}"
fi

if [ "$EPS_OS_DISTRO" != "debian" ]; then
  log_error "Only Debian is supported: ${CLR_CYB}$EPS_OS_DISTRO${CLR}"
fi

export EPS_UTILS_COMMON=$(wget --no-cache -qO- "$EPS_BASE_URL"/app/common.sh)
export EPS_UTILS_DISTRO=$(wget --no-cache -qO- "$EPS_BASE_URL"/app/debian.sh)
bash -c "$EPS_APP_INSTALL"
