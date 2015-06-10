# add ~/bin to the $PATH
export PATH="$HOME/bin":$PATH

# load the definitions from the following defined files:
#    .bash_prompt - common prompt customization
#    .exports     - common environment variables
#    .aliases     - common aliases
#    .functions   - common functions
# put other settings you don’t want to commit into:
#    .path        - can be used to customize the $PATH ad is loaded before all others
#    .extra       - can be used for other settings you don’t want to commit
for file in ~/.{path,bash_prompt,exports,aliases,functions,extra}
do
	[ -r "$file" ] && source "$file"
done
unset file

# load homeshick and homeshick bash-completion
source "${HOME}/.homesick/repos/homeshick/homeshick.sh"
source "${HOME}/.homesick/repos/homeshick/completions/homeshick-completion.bash"

# enable some bash 4 features when possible:

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

# Add tab completion for `defaults read|write NSGlobalDomain`
# You could just use `-g` instead, but I like being explicit
complete -W "NSGlobalDomain" defaults;

# Add `killall` tab completion for common apps
complete -o "nospace" -W "Contacts Calendar Dock Finder Mail Safari iTunes SystemUIServer Terminal Twitter" killall;

