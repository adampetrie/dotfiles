ulimit -n 4048

git_prompt_vars ()
{
    local ref=$(git symbolic-ref HEAD 2> /dev/null);
    SCM_BRANCH=${ref#refs/heads/};
    echo -e "$SCM_BRANCH"
}

make_color ()
{
    pre_color="\[\033[";
    post_color="m\]";
    echo -e "${pre_color}$1${post_color}"
}

green=$(make_color "0;32")
yellow=$(make_color "0;33")
reset=$(make_color "0;37")

#Git tab completion
if [ -f /usr/local/git/contrib/completion/git-completion.bash ]; then
  . /usr/local/git/contrib/completion/git-completion.bash
fi

#Git aliased to 'g'
alias g='git'
complete -o default -o nospace -F _git git g

# when a process exits with nonzero status,
# show a sad face and the exit code
ps1_status ()
{
    local status=$?;
    if [ $status -ne 0 ]; then
        smiley=":(";
    else
        smiley=":)";
    fi;
    echo -e "$smiley $status"
}

PS1="\u @ \h ${reset}in ${green}\w\n ${reset}| ${yellow}\$(git_prompt_vars) ${reset}| $ "
export PS1

PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting

export PATH=$HOME/.node/bin:$PATH
export PATH=/usr/local/bin:$PATH
export PATH="$PATH:$HOME/npm/bin":$PATH
export PATH=$HOME/Library/Python/2.7/bin:$PATH
