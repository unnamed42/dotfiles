# *{{ zinit initialization
  if [[ ${(%):-%N} == /etc/zsh* ]]; then
    ZIROOT=/etc/zsh/zinit
  else
    ZIROOT=~/.zinit
  fi

  # download zinit if not installed
  if [[ ! -d $ZIROOT || ! -d $ZIROOT/bin ]]; then
    mkdir -p $ZIROOT
    git clone https://github.com/zdharma/zinit.git $ZIROOT/bin --depth=1
  fi

  # zinit plugins
  typeset -A ZINIT=(
    HOME_DIR $ZIROOT
    BIN_DIR  $ZIROOT/bin
  )

  source $ZIROOT/bin/zinit.zsh

  # ZDOTDIR ?= HOME
  : "${ZDOTDIR="$HOME"}"
# *}}

# *{{ utility functions
  function __exists() {
    (( ${+commands[$1]} )) && return 0
    return 1
  }
# *}}

# *{{ custom fuctions and aliases
  function cd() {
    if (( ${#argv} == 1 )) && [[ -f ${1} ]]; then
      [[ ! -e ${1:h} ]] && return 1
      print "Correcting ${1} to ${1:h}"
      builtin cd ${1:h}
    else
      builtin cd "$@"
    fi
  }

  function mkcd() {
    if (( ARGC != 1 )); then
      echo "usage: mkcd <new-directory>"
      return 1
    fi
    if [[ ! -d "$1" ]]; then
      mkdir -p "$1"
    fi
    builtin cd "$1"
  }

  # aliases for package managers
  if __exists pacman; then
    alias psin="sudo pacman -S --needed"
    alias pss="pacman -Ss"
    alias pi='pacman -Si'
    alias po='pacman -Qo'
    alias pq='pacman -Qi'
    alias pl='pacman -Ql'
    alias pqs='pacman -Qs'
    alias prus="sudo pacman -Rsscun"
    alias pu="sudo pacman -U "
    alias pc="yes | sudo pacman -Sc"
    function poc() {
      pacman -Qo $(which $1)
    }
  elif __exists dpkg && __exists apt; then
    alias psin="sudo apt install"
    alias pss="apt search"
    alias pi="apt show"
    alias po="dpkg -S"
    alias pq="apt show"
    alias pl="dpkg -L"
    function pqs() {
      apt list --installed "*$1*"
    }
    alias prus="sudo apt-get remove --autoremove"
    alias pu="sudo dpkg -i"
    alias pc="sudo apt clean && sudo apt autoclean"
    alias up="sudo apt update && sudo apt upgrade"
  fi
  if __exists pikaur; then
    alias up='pikaur -Syu'
    alias ys="pikaur -S --needed"
    alias yss="pikaur -Ss"
  fi

  if __exists hexo; then
    alias hcgs="hexo clean && hexo g && hexo s"
  fi

  if __exists systemctl; then
    alias start="sudo systemctl start"
    alias stop="sudo systemctl stop"
    alias restart="sudo systemctl restart"
    alias reload="sudo systemctl reload-or-restart"
    alias status="systemctl status"
  fi

  if __exists git; then
    function gcom() {
      if ! git add -A; then return $?; fi
      if [ -z "$1" ]; then
        if ! git commit; then return $?; fi
      else
        git commit -m "$1"
      fi
    }
    function gpush() {
      if [ $# -ne 0 ]; then
        gcom $1
      fi
      git push
    }
    alias gbr="git branch"
    alias gbd="git branch -D"
    alias gco="git checkout"
    alias gcb="git checkout -b"
  fi

  function clearwine() {
    local LOCAL_DIR=~/.local/share

    rm -f $LOCAL_DIR/applications/wine-extension*.desktop
    rm -f $LOCAL_DIR/icons/hicolor/*/*/application-x-wine-extension*
    rm -f $LOCAL_DIR/applications/mimeinfo.cache
    rm -f $LOCAL_DIR/mime/packages/x-wine*
    rm -f $LOCAL_DIR/mime/application/x-wine-extension*

    update-desktop-database $LOCAL_DIR/applications
    update-mime-database $LOCAL_DIR/mime/
  }
# *}}

# *{{ autoload
  autoload -U add-zsh-hook
# *}}

# *{{ ls colors
  __exists  dircolors && eval $( dircolors -b)
  __exists gdircolors && eval $(gdircolors -b)

  # colors in ls and less
  export LESS_TERMCAP_mb=$'\E[01;31m'
  export LESS_TERMCAP_md=$'\E[01;31m'
  export LESS_TERMCAP_me=$'\E[0m'
  export LESS_TERMCAP_se=$'\E[0m'
  export LESS_TERMCAP_so=$'\E[01;44;33m'
  export LESS_TERMCAP_ue=$'\E[0m'
  export LESS_TERMCAP_us=$'\E[01;32m'
# *}}

# *{{ set ls and grep
  typeset -ga ls_options
  typeset -ga grep_options

  # Colors on GNU ls(1)
  if ls --color=auto / >/dev/null 2>&1; then
    ls_options+=( --color=auto )
  # Colors on FreeBSD and OSX ls(1)
  elif ls -G / >/dev/null 2>&1; then
    ls_options+=( -G )
  fi

  # Natural sorting order on GNU ls(1)
  # OSX and IllumOS have a -v option that is not natural sorting
  if ls --version |& grep -q 'GNU' >/dev/null 2>&1 && ls -v / >/dev/null 2>&1; then
    ls_options+=( -v )
  fi

  # Color on GNU and FreeBSD grep(1)
  if grep --color=auto -q "a" <<< "a" >/dev/null 2>&1; then
    grep_options+=( --color=auto )
  fi

  # do we have GNU ls with color-support?
  if [[ "$TERM" != dumb ]]; then
    #a1# List files with colors (\kbd{ls \ldots})
    alias ls="command ls ${ls_options:+${ls_options[*]}}"
    #a1# List all files, with colors (\kbd{ls -la \ldots})
    alias la="command ls -la ${ls_options:+${ls_options[*]}}"
    #a1# List files with long colored list, without dotfiles (\kbd{ls -l \ldots})
    alias ll="command ls -l ${ls_options:+${ls_options[*]}}"
    #a1# List files with long colored list, human readable sizes (\kbd{ls -hAl \ldots})
    alias lh="command ls -hAl ${ls_options:+${ls_options[*]}}"
    #a1# List files with long colored list, append qualifier to filenames (\kbd{ls -l \ldots})\\&\quad(\kbd{/} for directories, \kbd{@} for symlinks ...)
    alias l="command ls -l ${ls_options:+${ls_options[*]}}"
  else
    alias la='command ls -la'
    alias ll='command ls -l'
    alias lh='command ls -hAl'
    alias l='command ls -l'
  fi

  # use colors when GNU grep with color-support
  if (( $#grep_options > 0 )); then
    o=${grep_options:+"${grep_options[*]}"}
    #a2# Execute \kbd{grep -{}-color=auto}
    alias grep='grep '$o
    alias egrep='egrep '$o
    unset o
  fi
# *}}

# *{{ setopt
  setopt auto_cd              # execute cd when command not executable
  setopt interactive_comments # allow comments in interative shell
  setopt octal_zeroes         # interpret 0-leading numbers as octal
  setopt no_prompt_cr         # print \r before output
  setopt list_packed          # completion menu adaptive size
  # setopt no_always_to_end   # move cursor to end if full completion is inserted
  setopt long_list_jobs       # display PID for process status
  setopt complete_in_word     # complete not just at the end
  setopt hash_list_all        # hash before all commands
  setopt c_bases              # output number in C format
  setopt no_sh_word_split     # zsh style word split
  setopt no_glob_dots         # do not match dots, useful for dotfiles
  setopt numeric_glob_sort    # sort number pattern numerically rather than lexicographically
  setopt prompt_subst         # expansions in prompts
  setopt notify               # report background jobs immediately
  setopt no_beep              # disable beep
  # setopt zle                # use zle
  setopt correct              # correct spelling of commands
  setopt bad_pattern          # error if pattern is badly formed
  setopt unset                # do not error when unset parameter is used
  setopt no_hup               # do not send SIGHUP to background process, i.e. kill them when quitting shell

  ## history
  HISTSIZE=100000
  SAVEHIST=$HISTSIZE
  HISTFILE="$ZDOTDIR/.zsh_history"
  setopt append_history         # append history instead of replacing
  setopt hist_ignore_all_dups   # ignore duplication command history list
  setopt hist_ignore_space      # ignore commands that start with a space
  setopt hist_verify            # don't execute command from history directly but edit it first
  setopt inc_append_history     # incrementally append to history as soon as command is executed
  setopt share_history          # share history between simultaneously running shells
  setopt extended_history       # record timestamp in history
  # setopt no_hist_no_functions # do not add functions to history

  ## dirstrack and pushd
  setopt auto_pushd             # make cd push the old directory onto the directory stack.
  setopt pushd_ignore_dups      # don't push the same dir twice.
  DIRSTACKSIZE=20               # Max number of items on dirstack
  DIRSTACKFILE="$ZDOTDIR/.zdirs"

  function write_dirstack() {
    (( $DIRSTACKSIZE <= 0 )) && return
    [[ -z $DIRSTACKFILE ]] && return

    # Array with unique values
    typeset -aU dedup
    dedup=( $PWD "${dirstack[@]}" )

    print -l $dedup >! $DIRSTACKFILE
  }

  add-zsh-hook chpwd write_dirstack

  if [[ -f ${DIRSTACKFILE} ]]; then
    # Read dirstack from file and filter out all non-existing directories
    # (f): split at newline
    # ${^...}: set RC_EXPAND_PARAM. ${^var} becomes {$var[1],$var[2],...}
    # (/N): / to filter directories. N for NULL_GLOB to silently ignore nonexisting dirs
    dirstack=( ${^${(f)"$(< $DIRSTACKFILE)"}}(/N) )

    # Populate `cd -` behavior after startup
    [[ -d $dirstack[1] ]] && cd -q $dirstack[1] && cd -q $OLDPWD
  fi
# *}}

# *{{ modules
  zmodload -i zsh/complist
  zmodload -i zsh/terminfo
# *}}

# *{{ completion
  # allow one error for every three characters typed in approximate completer
  zstyle ':completion:*:approximate:'    max-errors 'reply=( $((($#PREFIX+$#SUFFIX)/3 )) numeric )'

  # don't complete backup files as executables
  zstyle ':completion:*:complete:-command-::commands' ignored-patterns '(aptitude-*|*\~)'

  # start menu completion only if it could find no unambiguous initial string
  zstyle ':completion:*:correct:*'       insert-unambiguous true
  zstyle ':completion:*:corrections'     format $'%{\e[0;31m%}%d (errors: %e)%{\e[0m%}'
  zstyle ':completion:*:correct:*'       original true

  # activate color-completion
  zstyle ':completion:*:default'         list-colors ${(s.:.)LS_COLORS}

  # format on completion
  zstyle ':completion:*:descriptions'    format $'%{\e[0;31m%}completing %B%d%b%{\e[0m%}'

  # automatically complete 'cd -<tab>' and 'cd -<ctrl-d>' with menu
  # zstyle ':completion:*:*:cd:*:directory-stack' menu yes select

  # insert all expansions for expand completer
  zstyle ':completion:*:expand:*'        tag-order all-expansions
  zstyle ':completion:*:history-words'   list false

  # activate menu
  zstyle ':completion:*:history-words'   menu yes

  # ignore duplicate entries
  zstyle ':completion:*:history-words'   remove-all-dups yes
  zstyle ':completion:*:history-words'   stop yes

  # match uppercase from lowercase
  zstyle ':completion:*'                 matcher-list 'm:{a-z}={A-Z}'

  # separate matches into groups
  zstyle ':completion:*:matches'         group 'yes'
  zstyle ':completion:*'                 group-name ''

  zstyle ':completion:*'                 menu select

  zstyle ':completion:*:messages'        format '%d'
  zstyle ':completion:*:options'         auto-description '%d'

  # describe options in full
  zstyle ':completion:*:options'         description 'yes'

  # on processes completion complete all user processes
  zstyle ':completion:*:processes'       command 'ps -au$USER'

  # offer indexes before parameters in subscripts
  zstyle ':completion:*:*:-subscript-:*' tag-order indexes parameters

  # provide verbose completion information
  zstyle ':completion:*'                 verbose true

  # recent (as of Dec 2007) zsh versions are able to provide descriptions
  # for commands (read: 1st word in the line) that it will list for the user
  # to choose from. The following disables that, because it's not exactly fast.
  zstyle ':completion:*:-command-:*:'    verbose false

  # set format for warnings
  zstyle ':completion:*:warnings'        format $'%{\e[0;31m%}No matches for:%{\e[0m%} %d'

  # define files to ignore for zcompile
  zstyle ':completion:*:*:zcompile:*'    ignored-patterns '(*~|*.zwc)'
  zstyle ':completion:correct:'          prompt 'correct to: %e'

  # Ignore completion functions for commands you don't have:
  zstyle ':completion::(^approximate*):*:functions' ignored-patterns '_*'

  # Provide more processes in completion of programs like killall:
  zstyle ':completion:*:processes-names' command 'ps c -u ${USER} -o command | uniq'

  # complete manual by their section
  zstyle ':completion:*:manuals'    separate-sections true
  zstyle ':completion:*:manuals.*'  insert-sections   true
  zstyle ':completion:*:man:*'      menu yes select

  # Search path for sudo completion
  zstyle ':completion:*:sudo:*' command-path /usr/local/sbin \
                         /usr/local/bin  \
                         /usr/sbin       \
                         /usr/bin        \
                         /sbin           \
                         /bin            \
                         /usr/X11R6/bin

  # provide .. as a completion
  zstyle ':completion:*' special-dirs ..

  # run rehash on completion so new installed program are found automatically:
  function _force_rehash() {
    (( CURRENT == 1 )) && rehash
    return 1
  }

  # correction
  # setopt correct
  zstyle -e ':completion:*' completer '
    if [[ $_last_try != "$HISTNO$BUFFER$CURSOR" ]] ; then
      _last_try="$HISTNO$BUFFER$CURSOR"
      reply=(_complete _match _ignored _prefix _files)
    else
      if [[ $words[1] == (rm|mv) ]] ; then
        reply=(_complete _files)
      else
        reply=(_oldlist _expand _force_rehash _complete _ignored _correct _approximate _files)
      fi
    fi'

  # command for process lists, the local web server details and host completion
  zstyle ':completion:*:urls' local 'www' '/var/www/' 'public_html'

  # Some functions, like _apt and _dpkg, are very slow. We can use a cache in
  # order to speed things up
  zstyle ':completion:*' use-cache  yes
  zstyle ':completion:*' cache-path "$COMPDUMPCACHEDIR"

  [[ -r ~/.ssh/config ]] && _ssh_config_hosts=(${${(s: :)${(ps:\t:)${${(@M)${(f)"$(<$HOME/.ssh/config)"}:#Host *}#Host }}}:#*[*?]*}) || _ssh_config_hosts=()
  [[ -r ~/.ssh/known_hosts ]] && _ssh_hosts=(${${${${(f)"$(<$HOME/.ssh/known_hosts)"}:#[\|]*}%%\ *}%%,*}) || _ssh_hosts=()
  [[ -r /etc/hosts ]] && : ${(A)_etc_hosts:=${(s: :)${(ps:\t:)${${(f)~~"$(</etc/hosts)"}%%\#*}##[:blank:]#[^[:blank:]]#}}} || _etc_hosts=()
  hosts=(
    $(hostname)
    "$_ssh_config_hosts[@]"
    "$_ssh_hosts[@]"
    "$_etc_hosts[@]"
    localhost
  )
  zstyle ':completion:*:hosts' hosts $hosts
# *}}

# *{{ ZLE widgets
  # edit current command with $EDITOR
  autoload -Uz edit-command-line
  zle -N edit-command-line

  function slash-backward-kill-word () {
    local WORDCHARS="${WORDCHARS:s@/@}"
    # zle backward-word
    zle backward-kill-word
  }
  zle -N slash-backward-kill-word
# *}}

# *{{ window title
  # adjust title of xterm compatible terminal
  # see http://www.faqs.org/docs/Linux-mini/Xterm-Title.html
  case $TERM in
    (xterm*|rxvt*)
      function _set_title() {
        printf '%s' $'\e]0;'
        printf '%s' "$*"
        printf '%s' $'\a'
      }

      function _reset_title() {
        _set_title ${(%):-"%n@%m: %~"}
      }

      function _set_command_title() {
        _set_title "${(%):-"%n@%m:"}" "$1"
      }

      add-zsh-hook precmd _reset_title
      add-zsh-hook preexec _set_command_title
      ;;
  esac
# *}}

# *{{ key bindings
  # vi-mode
  bindkey -v

  # cross-platform keycodes
  typeset -A keycodes=(
    up   ${terminfo[kcuu1]}
    down ${terminfo[kcud1]}
    del  ${terminfo[kdch1]}
    home ${terminfo[khome]}
    end  ${terminfo[kend]}
  )
  # platform dependent keycodes
  if [[ $OSTYPE == darwin* ]]; then
    keycodes+=(
      up   '^[[A'
      down '^[[B'
      home '^[[H'
      end  '^[[F'
    )
  fi

  # ctrl+left, ctrl+right to wo to next word
  # alt+left, alt+right to wo to next word
  bindkey '^[[1;5D' backward-word
  bindkey '^[[1;5C' forward-word
  bindkey '^[[1;3D' backward-word
  bindkey '^[[1;3C' forward-word

  # allow backspace, alt+backspace, ctrl+backspace, ctrl+w for char and word deletion
  # These escape sequences are different depending on your terminal
  bindkey '^?'               backward-delete-char
  bindkey "${keycodes[del]}" delete-char
  bindkey '\e^?'             slash-backward-kill-word
  bindkey '^H'               slash-backward-kill-word
  bindkey '^w'               slash-backward-kill-word

  # Home/End to line beginning/end
  bindkey "${keycodes[home]}" beginning-of-line
  bindkey "${keycodes[end]}"  end-of-line

  # assign key bindings after zsh-history-substring-search loaded
  function __bind_history_keys() {
    bindkey "${keycodes[up]}"   history-substring-search-up
    bindkey "${keycodes[down]}" history-substring-search-down
  }
# *}}

# *{{ zinit plugins
  zinit wait"0" lucid for \
    arzzen/calc.plugin.zsh \
    atinit"ZINIT[COMPINIT_OPTS]=-C; zicompinit" \
      zdharma/fast-syntax-highlighting \
    blockf as"completion" \
      gradle/gradle-completion \
    blockf \
      voronkovich/gitignore.plugin.zsh \
    blockf atinit"zicompinit; zicdreplay" \
      zsh-users/zsh-completions

  zinit wait"!0b" lucid for \
    atinit'zstyle ":history-search-multi-word" page-size "7"' \
      zdharma/history-search-multi-word \
    atload"__bind_history_keys; export HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND=none" \
      zsh-users/zsh-history-substring-search \
    atload"!_zsh_autosuggest_start" \
      zsh-users/zsh-autosuggestions

  zinit lucid for \
    compile"(pure|async).zsh" pick"async.zsh" src"pure.zsh" \
      sindresorhus/pure
# *}}

# autosuggestions async mode
ZSH_AUTOSUGGEST_USE_ASYNC=1
# pure inline prompt
prompt_newline="%666v"
# show error code
PROMPT="%(?..%F{red} %?) $PROMPT"

# vim:ft=zsh:foldmethod=marker:foldmarker=*{{,*}}
