# alias for the following command: while true;do now=$(date);png=$(ping -c 1 8.8.8.8| grep -o "time=[0-9.]* ms");echo -n $now:; echo ${png};sleep 1;done
alias pingtest="while true; do now=\$(date); png=\$(ping -c 1 8.8.8.8 | grep -o 'time=[0-9.]* ms'); echo -n \$now: ; echo \${png}; sleep 1; done"
# alias for the following command: while true; do now=$(date +"%Y-%m-%d %H:%M:%S"); jitter=$(ping -c 60 8.8.8.8 | tail -1 | awk -F'/' '{print $NF}'); echo -n "$now: jitter: $jitter"; echo;done
alias jittertest="while true; do now=\$(date); jitter=\$(ping -c 60 8.8.8.8 | tail -1 | awk -F'/' '{print \$NF}'); echo -n \"\$now: jitter: \$jitter\"; echo;done"
# alias for the following command: while true;do now=$(date);png=$(networkQuality|tail -4 );echo -n $now:;echo; echo ${png};echo "=============";sleep 10;done
alias speedtest="while true; do now=\$(date); png=\$(networkQuality | tail -4); echo -n \$now:; echo; echo \${png}; echo '============='; sleep 10; done"
# alias for a more detailed ls command 
alias ls="ls -lsa"
# The setopt PROMPT_SUBST command in a .zshrc file enables prompt substitution in the Z shell (zsh). 
# This means that it allows for the evaluation of variables and command substitutions directly within the prompt. 
# So, if your prompt includes variables or commands enclosed in parentheses, they will be evaluated and substituted with their output or value 
# every time the prompt is displayed. This feature enhances the dynamic capabilities of your shell prompt, allowing it to include, for example, 
# the current directory, the current time, or the output of any command you wish to monitor directly in the prompt.
setopt PROMPT_SUBST
# Custom prompt
PROMPT="%B%F{white}#%f %F{red}[%w %D %D{%H:%M:%S}]%f%F{white} %d:%f%b "

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/opt/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/opt/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/opt/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/opt/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

