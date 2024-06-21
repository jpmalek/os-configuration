# alias for the following command: while true;do now=$(date);png=$(ping -c 1 google.com|tr '\n' ' '|sed -e 's/\-\-.*//g');echo -n $now:; echo ${png};sleep 1;done
alias pingtest="while true; do now=\$(date); png=\$(ping -c 1 google.com | tr '\n' ' ' | sed -e 's/--.*//g'); echo -n \$now: ; echo \${png}; sleep 1; done"
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

