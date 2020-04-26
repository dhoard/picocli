#!/usr/bin/env bash
#
# picocompletion-demo-help Bash Completion
# =======================
#
# Bash completion support for the `picocompletion-demo-help` command,
# generated by [picocli](http://picocli.info/) version 4.2.1-SNAPSHOT.
#
# Installation
# ------------
#
# 1. Source all completion scripts in your .bash_profile
#
#   cd $YOUR_APP_HOME/bin
#   for f in $(find . -name "*_completion"); do line=". $(pwd)/$f"; grep "$line" ~/.bash_profile || echo "$line" >> ~/.bash_profile; done
#
# 2. Open a new bash console, and type `picocompletion-demo-help [TAB][TAB]`
#
# 1a. Alternatively, if you have [bash-completion](https://github.com/scop/bash-completion) installed:
#     Place this file in a `bash-completion.d` folder:
#
#   * /etc/bash-completion.d
#   * /usr/local/etc/bash-completion.d
#   * ~/bash-completion.d
#
# Documentation
# -------------
# The script is called by bash whenever [TAB] or [TAB][TAB] is pressed after
# 'picocompletion-demo-help (..)'. By reading entered command line parameters,
# it determines possible bash completions and writes them to the COMPREPLY variable.
# Bash then completes the user input if only one entry is listed in the variable or
# shows the options if more than one is listed in COMPREPLY.
#
# References
# ----------
# [1] http://stackoverflow.com/a/12495480/1440785
# [2] http://tiswww.case.edu/php/chet/bash/FAQ
# [3] https://www.gnu.org/software/bash/manual/html_node/The-Shopt-Builtin.html
# [4] http://zsh.sourceforge.net/Doc/Release/Options.html#index-COMPLETE_005fALIASES
# [5] https://stackoverflow.com/questions/17042057/bash-check-element-in-array-for-elements-in-another-array/17042655#17042655
# [6] https://www.gnu.org/software/bash/manual/html_node/Programmable-Completion.html#Programmable-Completion
# [7] https://stackoverflow.com/questions/3249432/can-a-bash-tab-completion-script-be-used-in-zsh/27853970#27853970
#

if [ -n "$BASH_VERSION" ]; then
  # Enable programmable completion facilities when using bash (see [3])
  shopt -s progcomp
elif [ -n "$ZSH_VERSION" ]; then
  # Make alias a distinct command for completion purposes when using zsh (see [4])
  setopt COMPLETE_ALIASES
  alias compopt=complete

  # Enable bash completion in zsh (see [7])
  autoload -U +X compinit && compinit
  autoload -U +X bashcompinit && bashcompinit
fi

# CompWordsContainsArray takes an array and then checks
# if all elements of this array are in the global COMP_WORDS array.
#
# Returns zero (no error) if all elements of the array are in the COMP_WORDS array,
# otherwise returns 1 (error).
function CompWordsContainsArray() {
  declare -a localArray
  localArray=("$@")
  local findme
  for findme in "${localArray[@]}"; do
    if ElementNotInCompWords "$findme"; then return 1; fi
  done
  return 0
}
function ElementNotInCompWords() {
  local findme="$1"
  local element
  for element in "${COMP_WORDS[@]}"; do
    if [[ "$findme" = "$element" ]]; then return 1; fi
  done
  return 0
}

# The `currentPositionalIndex` function calculates the index of the current positional parameter.
#
# currentPositionalIndex takes three parameters:
# the command name,
# a space-separated string with the names of options that take a parameter, and
# a space-separated string with the names of boolean options (that don't take any params).
# When done, this function echos the current positional index to std_out.
#
# Example usage:
# local currIndex=$(currentPositionalIndex "mysubcommand" "$ARG_OPTS" "$FLAG_OPTS")
function currentPositionalIndex() {
  local commandName="$1"
  local optionsWithArgs="$2"
  local booleanOptions="$3"
  local previousWord
  local result=0

  for i in $(seq $((COMP_CWORD - 1)) -1 0); do
    previousWord=${COMP_WORDS[i]}
    if [ "${previousWord}" = "$commandName" ]; then
      break
    fi
    if [[ "${optionsWithArgs}" =~ ${previousWord} ]]; then
      ((result-=2)) # Arg option and its value not counted as positional param
    elif [[ "${booleanOptions}" =~ ${previousWord} ]]; then
      ((result-=1)) # Flag option itself not counted as positional param
    fi
    ((result++))
  done
  echo "$result"
}

# Bash completion entry point function.
# _complete_picocompletion-demo-help finds which commands and subcommands have been specified
# on the command line and delegates to the appropriate function
# to generate possible options and subcommands for the last specified subcommand.
function _complete_picocompletion-demo-help() {
  local cmds0=(sub1)
  local cmds1=(sub2)
  local cmds2=(help)
  local cmds3=(sub2 subsub1)
  local cmds4=(sub2 subsub2)
  local cmds5=(sub2 subsub3)

  if CompWordsContainsArray "${cmds5[@]}"; then _picocli_picocompletion-demo-help_sub2_subsub3; return $?; fi
  if CompWordsContainsArray "${cmds4[@]}"; then _picocli_picocompletion-demo-help_sub2_subsub2; return $?; fi
  if CompWordsContainsArray "${cmds3[@]}"; then _picocli_picocompletion-demo-help_sub2_subsub1; return $?; fi
  if CompWordsContainsArray "${cmds2[@]}"; then _picocli_picocompletion-demo-help_help; return $?; fi
  if CompWordsContainsArray "${cmds1[@]}"; then _picocli_picocompletion-demo-help_sub2; return $?; fi
  if CompWordsContainsArray "${cmds0[@]}"; then _picocli_picocompletion-demo-help_sub1; return $?; fi

  # No subcommands were specified; generate completions for the top-level command.
  _picocli_picocompletion-demo-help; return $?;
}

# Generates completions for the options and subcommands of the `picocompletion-demo-help` command.
function _picocli_picocompletion-demo-help() {
  # Get completion data
  local curr_word=${COMP_WORDS[COMP_CWORD]}

  local commands="sub1 sub2 help"
  local flag_opts="-V --version -h --help"
  local arg_opts=""

  if [[ "${curr_word}" == -* ]]; then
    COMPREPLY=( $(compgen -W "${flag_opts} ${arg_opts}" -- "${curr_word}") )
  else
    local positionals=""
    COMPREPLY=( $(compgen -W "${commands} ${positionals}" -- "${curr_word}") )
  fi
}

# Generates completions for the options and subcommands of the `sub1` subcommand.
function _picocli_picocompletion-demo-help_sub1() {
  # Get completion data
  local curr_word=${COMP_WORDS[COMP_CWORD]}
  local prev_word=${COMP_WORDS[COMP_CWORD-1]}

  local commands=""
  local flag_opts=""
  local arg_opts="--num --str --candidates"
  local str2_option_args="aaa bbb ccc" # --candidates values

  compopt +o default

  case ${prev_word} in
    --num)
      return
      ;;
    --str)
      return
      ;;
    --candidates)
      COMPREPLY=( $( compgen -W "${str2_option_args}" -- "${curr_word}" ) )
      return $?
      ;;
  esac

  if [[ "${curr_word}" == -* ]]; then
    COMPREPLY=( $(compgen -W "${flag_opts} ${arg_opts}" -- "${curr_word}") )
  else
    local positionals=""
    COMPREPLY=( $(compgen -W "${commands} ${positionals}" -- "${curr_word}") )
  fi
}

# Generates completions for the options and subcommands of the `sub2` subcommand.
function _picocli_picocompletion-demo-help_sub2() {
  # Get completion data
  local curr_word=${COMP_WORDS[COMP_CWORD]}
  local prev_word=${COMP_WORDS[COMP_CWORD-1]}

  local commands="subsub1 subsub2 subsub3"
  local flag_opts=""
  local arg_opts="--num2 --directory -d"

  compopt +o default

  case ${prev_word} in
    --num2)
      return
      ;;
    --directory|-d)
      compopt -o filenames
      COMPREPLY=( $( compgen -f -- "${curr_word}" ) ) # files
      return $?
      ;;
  esac
  local possibilities_pos_param_args="Aaa Bbb Ccc" # 0-0 values

  if [[ "${curr_word}" == -* ]]; then
    COMPREPLY=( $(compgen -W "${flag_opts} ${arg_opts}" -- "${curr_word}") )
  else
    local positionals=""
    local currIndex
    currIndex=$(currentPositionalIndex "sub2" "${arg_opts}" "${flag_opts}")
    if (( currIndex >= 0 && currIndex <= 0 )); then
      positionals=$( compgen -W "$possibilities_pos_param_args" -- "${curr_word}" )
    fi
    COMPREPLY=( $(compgen -W "${commands} ${positionals}" -- "${curr_word}") )
  fi
}

# Generates completions for the options and subcommands of the `help` subcommand.
function _picocli_picocompletion-demo-help_help() {
  # Get completion data
  local curr_word=${COMP_WORDS[COMP_CWORD]}

  local commands="sub1 sub2"
  local flag_opts="-h --help"
  local arg_opts=""

  if [[ "${curr_word}" == -* ]]; then
    COMPREPLY=( $(compgen -W "${flag_opts} ${arg_opts}" -- "${curr_word}") )
  else
    local positionals=""
    COMPREPLY=( $(compgen -W "${commands} ${positionals}" -- "${curr_word}") )
  fi
}

# Generates completions for the options and subcommands of the `subsub1` subcommand.
function _picocli_picocompletion-demo-help_sub2_subsub1() {
  # Get completion data
  local curr_word=${COMP_WORDS[COMP_CWORD]}
  local prev_word=${COMP_WORDS[COMP_CWORD-1]}

  local commands=""
  local flag_opts=""
  local arg_opts="-h --host"

  compopt +o default

  case ${prev_word} in
    -h|--host)
      compopt -o filenames
      COMPREPLY=( $( compgen -A hostname -- "${curr_word}" ) )
      return $?
      ;;
  esac

  if [[ "${curr_word}" == -* ]]; then
    COMPREPLY=( $(compgen -W "${flag_opts} ${arg_opts}" -- "${curr_word}") )
  else
    local positionals=""
    COMPREPLY=( $(compgen -W "${commands} ${positionals}" -- "${curr_word}") )
  fi
}

# Generates completions for the options and subcommands of the `subsub2` subcommand.
function _picocli_picocompletion-demo-help_sub2_subsub2() {
  # Get completion data
  local curr_word=${COMP_WORDS[COMP_CWORD]}
  local prev_word=${COMP_WORDS[COMP_CWORD-1]}

  local commands=""
  local flag_opts=""
  local arg_opts="-u --timeUnit -t --timeout"
  local timeUnit_option_args="NANOSECONDS MICROSECONDS MILLISECONDS SECONDS MINUTES HOURS DAYS" # --timeUnit values

  compopt +o default

  case ${prev_word} in
    -u|--timeUnit)
      COMPREPLY=( $( compgen -W "${timeUnit_option_args}" -- "${curr_word}" ) )
      return $?
      ;;
    -t|--timeout)
      return
      ;;
  esac
  local str2_pos_param_args="aaa bbb ccc" # 0-0 values

  if [[ "${curr_word}" == -* ]]; then
    COMPREPLY=( $(compgen -W "${flag_opts} ${arg_opts}" -- "${curr_word}") )
  else
    local positionals=""
    local currIndex
    currIndex=$(currentPositionalIndex "subsub2" "${arg_opts}" "${flag_opts}")
    if (( currIndex >= 0 && currIndex <= 0 )); then
      positionals=$( compgen -W "$str2_pos_param_args" -- "${curr_word}" )
    fi
    COMPREPLY=( $(compgen -W "${commands} ${positionals}" -- "${curr_word}") )
  fi
}

# Generates completions for the options and subcommands of the `subsub3` subcommand.
function _picocli_picocompletion-demo-help_sub2_subsub3() {
  # Get completion data
  local curr_word=${COMP_WORDS[COMP_CWORD]}

  local commands=""
  local flag_opts=""
  local arg_opts=""
  local cands_pos_param_args="aaa bbb ccc" # 0-0 values

  if [[ "${curr_word}" == -* ]]; then
    COMPREPLY=( $(compgen -W "${flag_opts} ${arg_opts}" -- "${curr_word}") )
  else
    local positionals=""
    local currIndex
    currIndex=$(currentPositionalIndex "subsub3" "${arg_opts}" "${flag_opts}")
    if (( currIndex >= 0 && currIndex <= 0 )); then
      positionals=$( compgen -W "$cands_pos_param_args" -- "${curr_word}" )
    elif (( currIndex >= 1 && currIndex <= 2 )); then
      compopt -o filenames
      positionals=$( compgen -f -- "${curr_word}" ) # files
    elif (( currIndex >= 3 && currIndex <= 2147483647 )); then
      compopt -o filenames
      positionals=$( compgen -A hostname -- "${curr_word}" )
    fi
    COMPREPLY=( $(compgen -W "${commands} ${positionals}" -- "${curr_word}") )
  fi
}

# Define a completion specification (a compspec) for the
# `picocompletion-demo-help`, `picocompletion-demo-help.sh`, and `picocompletion-demo-help.bash` commands.
# Uses the bash `complete` builtin (see [6]) to specify that shell function
# `_complete_picocompletion-demo-help` is responsible for generating possible completions for the
# current word on the command line.
# The `-o default` option means that if the function generated no matches, the
# default Bash completions and the Readline default filename completions are performed.
complete -F _complete_picocompletion-demo-help -o default picocompletion-demo-help picocompletion-demo-help.sh picocompletion-demo-help.bash
