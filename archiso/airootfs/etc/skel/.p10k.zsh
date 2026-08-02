# Powerlevel10k theme configuration for Umbrella OS — Red Queen Theme
# File: ~/.p10k.zsh

'builtin' 'local' '-a' 'p10k_config_opts'
'builtin' 'zstyle' ':Powerlevel10k:*' 'number-of-lines' '1'

# Temporarily set options for p10k setup
'builtin' 'setopt' 'no_aliases'

() {
  emulate -L ZSH -o extended_glob

  # Unset all configuration options.
  unset -m '(POWERLEVEL9K_*|DEFAULT_USER)'

  # Zsh >= 5.1 is required.
  [[ $ZSH_VERSION == (5.<1->*|<6->.*) ]] || return

  # Left prompt elements
  typeset -g POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(
    os_icon                 # OS identifier icon (Arch Linux logo)
    dir                     # current directory
    vcs                     # git status
    prompt_char             # prompt symbol (❯)
  )

  # Right prompt elements
  typeset -g POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(
    status                  # exit code of last command
    command_execution_time  # duration of last command
    background_jobs         # presence of background jobs
    virtualenv              # python virtual environment
    java_version            # active Java version
    time                    # current time
  )

  # Visual styling & colors — Red Queen Theme Palette
  typeset -g POWERLEVEL9K_MODE='nerdfont-v2'
  typeset -g POWERLEVEL9K_ICON_PADDING=none
  typeset -g POWERLEVEL9K_BACKGROUND=none

  # OS Icon settings
  typeset -g POWERLEVEL9K_OS_ICON_FOREGROUND='160' # Crimson Red

  # Directory styling
  typeset -g POWERLEVEL9K_DIR_BACKGROUND='none'
  typeset -g POWERLEVEL9K_DIR_FOREGROUND='255' # White text
  typeset -g POWERLEVEL9K_DIR_SHORTENED_FOREGROUND='244'
  typeset -g POWERLEVEL9K_DIR_ANCHOR_FOREGROUND='196' # Bright Crimson
  typeset -g POWERLEVEL9K_DIR_MAX_LENGTH=40

  # Git VCS styling
  typeset -g POWERLEVEL9K_VCS_CLEAN_FOREGROUND='76'   # Green when clean
  typeset -g POWERLEVEL9K_VCS_MODIFIED_FOREGROUND='208' # Orange when modified
  typeset -g POWERLEVEL9K_VCS_UNTRACKED_FOREGROUND='196' # Crimson when untracked

  # Prompt symbol styling
  typeset -g POWERLEVEL9K_PROMPT_CHAR_OK_VIINS_FOREGROUND='196' # Red Queen Crimson
  typeset -g POWERLEVEL9K_PROMPT_CHAR_ERROR_VIINS_FOREGROUND='160'
  typeset -g POWERLEVEL9K_PROMPT_CHAR_OK_VICMD_FOREGROUND='220'
  typeset -g POWERLEVEL9K_PROMPT_CHAR_ERROR_VICMD_FOREGROUND='160'

  # Status & time
  typeset -g POWERLEVEL9K_STATUS_ERROR_FOREGROUND='196'
  typeset -g POWERLEVEL9K_COMMAND_EXECUTION_TIME_FOREGROUND='244'
  typeset -g POWERLEVEL9K_TIME_FOREGROUND='242'
  typeset -g POWERLEVEL9K_TIME_FORMAT='%D{%H:%M:%S}'

  # Instant prompt configuration
  typeset -g POWERLEVEL9K_INSTANT_PROMPT=quiet
  typeset -g POWERLEVEL9K_TRANSIENT_PROMPT=off
  typeset -g POWERLEVEL9K_DISABLE_CONFIGURATION_WIZARD=true
}

# Restore Zsh options
(( ${#p10k_config_opts} )) && 'builtin' 'setopt' "${p10k_config_opts[@]}"
'builtin' 'unset' 'p10k_config_opts'
