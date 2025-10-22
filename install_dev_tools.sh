
# CONFIG

# Tested on:
# Distributor ID: Debian
# Description:    Debian GNU/Linux 12 (bookworm)
# Release:        12
# Codename:       bookworm

TOOLS_TO_INSTALL=("docker" "docker-compose" "python3.11" "python3.11-venv")
PYTHON_TOOLS=("Django")
PYTHON_VENV_PATH="/opt/python/project-env"
LOG_FILE="/var/log/setup_dev_tools.log"
# LOG FUNCTIONS

log() {
   local level=$1
   local text=$2
   RED='' GREEN='' YELLOW='' BLUE='' RESET=''
    if [[ -t 1 ]]; then
        RED='\033[0;31m'
        GREEN='\033[0;32m'
        YELLOW='\033[1;33m' 
        BLUE='\033[0;34m'
        RESET='\033[0m'
    fi


    case "$level" in
        "INFO")
            color="${GREEN}" ;;
        "WARNING")
            color="${YELLOW}" ;;
        "ERROR")
            color="${RED}" ;;
        "DEBUG")
            color="${BLUE}" ;;
        *)
            color="${RESET}" ;;
    esac
    
    timestamp="$(date '+%Y-%m-%d %H:%M:%S')"
    echo -e "[$timestamp] | ${color}[$level]${RESET} | $text"
    echo "[$timestamp] | $level | $text" >>"$LOG_FILE"

}

log_info() {
    log "INFO" "$1"
}

log_warning() {
    log "WARNING" "$1"
}

log_error() {
    log "ERROR" "$1"
}

log_debug() {
    log "DEBUG" "$1"
}

# MAIN FUNCTIONS

is_installed() {
    local tool_name=$1
    package=$(dpkg -l | grep $tool_name)
    if [ -n "$package" ]; then
        return 0
    else
        return 1
    fi
}


# MAIN SCRIPT

if [ ! -f "$LOG_FILE" ]; then
    touch "$LOG_FILE"
fi

log_info "Script started"
log_info "Installing tools: ${TOOLS_TO_INSTALL[*]}"

for tool in "${TOOLS_TO_INSTALL[@]}"; do
    if is_installed "$tool"; then
        log_info "$tool is already installed."
    else
        log_warning "Installing $tool..."
        apt install  -y "$tool"
        if [ $? -eq 0 ]; then
            log_info "$tool installed successfully."
        else
            log_error "Failed to install $tool."
            exit 1
        fi
    fi
done

if [ ! -f "$PYTHON_VENV_PATH/bin/python" ]; then
    log_info "Creating python venv: $PYTHON_VENV_PATH"
    mkdir -p "$PYTHON_VENV_PATH"
    python3 -m venv "$PYTHON_VENV_PATH"
else
    log_info "Python venv already exists: $PYTHON_VENV_PATH"
fi


source "$PYTHON_VENV_PATH/bin/activate"
log_info "Installing python tools: ${PYTHON_TOOLS[*]}"
for tool in "${PYTHON_TOOLS[@]}"; do
    pip3 install "$tool"
    if [ $? -eq 0 ]; then
        log_info "$tool installed successfully."
    else
        log_error "Failed to install $tool."
        exit 1
    fi
done
log_info "Script finished successfully."
exit 0
