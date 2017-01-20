#Color codes
clr0='\[\e[0;30m\]'
clr1='\[\e[0;31m\]'
clr2='\[\e[0;32m\]'
clr3='\[\e[0;33m\]'
clr4='\[\e[0;34m\]'
clr5='\[\e[0;35m\]'
clr6='\[\e[0;36m\]'
clr7='\[\e[0;37m\]'
clrx='\[\e[0m\]'

#Ports for dev API servers
export FORMS_API_PORT="3000"
export REQUESTS_API_PORT="3001"
export DRUGS_API_PORT="3002"
export CONSUMERS_API_PORT="3003"
export PRESCRIBERS_API_PORT="3004"
export CONSUMERS_GUI_PORT="3005"
export FILE_UPLOADS_API_PORT="3006"
export DASHBOARD_PORT="3007"
export EPA_GATEWAY_PORT="3008"
export EHR_ENGINE_PORT="3009"
export POLLY_PORT="3013"
export BOXEN_REDIS_IP="192.168.33.10"

#Custom command prompt
export PS1="\n(${clr3}\w${clrx})[${clr6}\u${clrx}]=> "
export PS2="=> "

#Vim forever
export EDITOR="vim"

# disable caps
setxkbmap -option caps:none

#Autocomplete for git
if [ -f ~/.git-completion.bash ]; then
  . ~/.git-completion.bash
fi

#CMM: rails c
railsc ()
{
  if [ -z "$1" ]; then
    bundle exec rails c
    return
  fi
  export APP_ID="t$1"
  export DB_CMM="cmm2_testing_t${1:0:1}"
  bundle exec rails c testing
}

#Exit with style
:q ()
{
  exit
}

#Hop up to specified directory
hop ()
{
  if [ -z "$1" ]; then
    return
  fi
  local target=$1
  cd "${PWD/\/$target\/*//$target}"
}
#Autocomplete for hop()
_hop ()
{
  local cur=${COMP_WORDS[COMP_CWORD]}
  local d=${PWD//\//\ }
  COMPREPLY=( $( compgen -W "$d" -- "$cur" ) )
}
complete -F _hop hop

#Display the contents of a directory in color.
alias ls='ls -G'

#Display the contents of a directory when switching to it.
#function cd()
#{
#  builtin cd "$*" && ls
#}

#Include RVM stuff.
source ~/.rvm/scripts/rvm

#Magical directory navigation
tp ()
{
  if [ ! -d ~/.tp/ ]; then
    mkdir -p ~/.tp
  fi

  if [ -z "$1" ]; then
    cd
    return
  fi  

  if [ $1 == '-h' ]; then
    echo "tp          go to home directory"
    echo "tp -h       displays this help message"
    echo "tp ++       adds the current folder as a portal"
    echo "tp --       removes the current folder from the portals list"
    echo "tp -x       purges all portals, clearing the portals list"
    echo "tp -l       lists all portals"
    echo "tp -        go to previous directory"
    echo "tp target   teleport to the target*"
    echo " "
    echo "* tp checks if a target portal exists. If a target portal"
    echo "  does not exist, tp searches the current directory for"
    echo "  targets. If no targets exist in the current directory,"
    echo "  tp searches for targets up the directory stack."
    return
  fi
  
  if [ $1 == '++' ]; then
    echo "${PWD}" > ~/.tp/${PWD##*/}
    echo "Portal added: ${PWD##*/}"
    return
  fi  

  if [ $1 == "--" ]; then
    if [ -f ~/.tp/${PWD##*/} ]; then
      rm ~/.tp/${PWD##*/}
      echo "Portal removed: ${PWD##*/}"
    fi
    return
  fi

  if [ $1 == "-x" ]; then
    rm -rf ~/.tp/
    echo "All portals purged! <:E"
    return
  fi

  if [ $1 == "-l" ]; then
    echo "Known portals:"
    ls ~/.tp/
    return
  fi

  if [ $1 == '-' ]; then
    cd -
    return
  fi
  
  if [ -f ~/.tp/$1 ]; then
    cd `cat ~/.tp/$1`
    return
  fi

  if [ -d $1 ]; then
    cd $1
    return
  fi

  hop $1
  return
}
#Autocomplete for tp()
_tp ()
{
  local cur=${COMP_WORDS[COMP_CWORD]}
  local tptargets=`ls ~/.tp/`
  local hoptargets=${PWD//\//\ }
  local cdtargets=`find ${cur}* -maxdepth 0 -type d 2>/dev/null`
  local cdtargets=${cdtargets//\ /\\\ }
  local cdtargets="${cdtargets//$'\n'/\/$'\n'}/"
  local d=`echo -e "${tptargets}\n${hoptargets}"`
  COMPREPLY=( $( compgen -W "$d" -- "$cur" ) )
}
complete -o plusdirs -F _tp tp 


babyfile ()
{
  find -type f -print0 | xargs -r0 stat -c %y\ %n | sort -r | head -n 1 | awk 'NF>1{print $NF}'
}

export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting


# BEGIN Ruboto setup
source ~/.rubotorc
# END Ruboto setup


### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"
