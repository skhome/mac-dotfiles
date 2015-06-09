# load the definitions from the following defined files:
#    .bash_prompt - common prompt customization
#    .exports     - common environment variables
#    .aliases     - common aliases
#    .functions   - common functions
# put other settings you don’t want to commit into:
#    .extra       - can be used for other settings you don’t want to commit
for file in ~/.{bash_prompt,exports,aliases,functions,extra}
do
	[ -r "$file" ] && source "$file"
done
unset file

# load homeshick and bash-completion
source "${HOME}/.homesick/repos/homeshick/homeshick.sh"
source "${HOME}/.homesick/repos/homeshick/completions/homeshick-completion.bash"

# enable some bash 4 features when possible:

# enter folders without typing cd, e.g. `**/qux` will enter `./foo/bar/baz/qux`
shopt -s autocd 2> /dev/null

# recursive globbing, e.g. `echo **/*.txt`
shopt -s globstar 2> /dev/null

# case-insensitive globbing (used in pathname expansion)
shopt -s nocaseglob

# append to the bash history file, rather than overwriting it
shopt -s histappend

# autocorrect typos in path names when using `cd`
shopt -s cdspell

# add tab completion GIT and for g alias
source "${HOME}/etc/git-completion.bash"
complete -o default -o nospace -F _git g

# add tab completion for SSH hostnames based on ~/.ssh/config, ignoring wildcards
[ -e "${HOME}/.ssh/config" ] && complete -o "default" -o "nospace" -W "$(grep "^Host" ~/.ssh/config | grep -v "[?*]" | cut -d " " -f2 | tr ' ' '\n')" scp sftp ssh
