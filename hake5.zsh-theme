# Color shortcuts
RED=$fg_no_bold[red]
YELLOW=$fg_no_bold[yellow]
GREEN=$fg_no_bold[green]
WHITE=$fg_no_bold[white]
BLUE=$fg_no_bold[blue]
CYAN=$fg_no_bold[cyan]
MAGENTA=$fg_no_bold[magenta]
RED_BOLD=$fg_bold[red]
YELLOW_BOLD=$fg_bold[yellow]
GREEN_BOLD=$fg_bold[green]
WHITE_BOLD=$fg_bold[white]
BLUE_BOLD=$fg_bold[blue]
CYAN_BOLD=$fg_bold[cyan]
MAGENTA_BOLD=$fg_bold[magenta]
RESET_COLOR=$reset_color


# Git prompt
GIT_PROMPT_PREFIX="["
GIT_PROMPT_SUFFIX="]"
GIT_PROMPT_INFIX="|"

GIT_PROMPT_COLOR1="$MAGENTA_BOLD"
GIT_PROMPT_COLOR2="$WHITE"

GIT_PROMPT_SHORT_PREFIX="["
GIT_PROMPT_SHORT_SUFFIX="]"
GIT_PROMPT_SHORT_COLOR="$WHITE"

# Format for git_prompt_info()
ZSH_THEME_GIT_PROMPT_PREFIX=""
ZSH_THEME_GIT_PROMPT_SUFFIX=""

# Format for parse_git_dirty()
ZSH_THEME_GIT_PROMPT_DIRTY="%{$RED_BOLD%}✗%{$RESET_COLOR%}"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$GREEN_BOLD%}✔%{$RESET_COLOR%}"

# Format for git_prompt_ahead()
ZSH_THEME_GIT_PROMPT_AHEAD="%{$RED_BOLD%}!%{$RESET_COLOR%}"

# Format for git_prompt_status()
ZSH_THEME_GIT_PROMPT_ADDED="%{$GREEN_BOLD%}+%{$RESET_COLOR%}"
ZSH_THEME_GIT_PROMPT_MODIFIED="%{$YELLOW_BOLD%}♻%{$RESET_COLOR%}"
ZSH_THEME_GIT_PROMPT_DELETED="%{$RED_BOLD%}×%{$RESET_COLOR%}"
ZSH_THEME_GIT_PROMPT_RENAMED="%{$CYAN_BOLD%}→%{$RESET_COLOR%}"
ZSH_THEME_GIT_PROMPT_UNMERGED="%{$MAGENTA_BOLD%}=%{$RESET_COLOR%}"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$BLUE_BOLD%}…%{$RESET_COLOR%}"

# Format for git_prompt_long_sha() and git_prompt_short_sha()
ZSH_THEME_GIT_PROMPT_SHA_BEFORE="%{$GIT_PROMPT_COLOR1%}"
ZSH_THEME_GIT_PROMPT_SHA_AFTER="%{$RESET_COLOR%}"

function prompt_git_f() {
	local PREFIX="%{$GIT_PROMPT_COLOR2%}${GIT_PROMPT_PREFIX}%{$RESET_COLOR%}"
	local SUFFIX="%{$GIT_PROMPT_COLOR2%}${GIT_PROMPT_SUFFIX}%{$RESET_COLOR%}"
	local SEP="%{$GIT_PROMPT_COLOR2%}${GIT_PROMPT_INFIX}%{$RESET_COLOR%}"


	if [ -d .git ] || git rev-parse --git-dir > /dev/null 2>&1; then
		echo "─${PREFIX}%{$GIT_PROMPT_COLOR1%}git:%{$GIT_PROMPT_COLOR1%}$(current_branch)$(parse_git_dirty)${SEP}$(git_prompt_status)${SEP}$(git_prompt_short_sha)${SUFFIX}"
	fi
}
function prompt_git_short_f() {
	if [ -d .git ] || git rev-parse --git-dir > /dev/null 2>&1; then
		echo "%{$GIT_PROMPT_SHORT_COLOR%}${GIT_PROMPT_SHORT_PREFIX}$(parse_git_dirty)%{$GIT_PROMPT_SHORT_COLOR%}${GIT_PROMPT_SHORT_SUFFIX}%{$RESET_COLOR%}─"
	fi
}

local prompt_git='$(prompt_git_f)'
local prompt_git_short='$(prompt_git_short_f)'


# Ruby prompt
RUBY_PROMPT_PREFIX="["
RUBY_PROMPT_SUFFIX="]"
RUBY_PROMPT_COLOR_DISABLED="$YELLOW"
RUBY_PROMPT_COLOR_ENABLED="$YELLOW_BOLD"
RUBY_PROMPT_COLOR_BRACES="$WHITE"

function prompt_ruby_f() {
	local rvm_info=''
	if which rvm-prompt &> /dev/null; then
		rvm_info=$(rvm-prompt i v g)
	elif which rbenv &> /dev/null; then
		rvm_info=$(rbenv version | sed -e "s/ (set.*$//")

	fi

	if [[ $rvm_info == *@* ]]; then
		echo "%{$RUBY_PROMPT_COLOR_BRACES%}${RUBY_PROMPT_PREFIX}%{$RUBY_PROMPT_COLOR_ENABLED%}${rvm_info}%{$RUBY_PROMPT_COLOR_BRACES%}${RUBY_PROMPT_SUFFIX}%{$RESET_COLOR%} "
	else
		echo "%{$RUBY_PROMPT_COLOR_BRACES%}${RUBY_PROMPT_PREFIX}%{$RUBY_PROMPT_COLOR_DISABLED%}${rvm_info}%{$RUBY_PROMPT_COLOR_BRACES%}${RUBY_PROMPT_SUFFIX}%{$RESET_COLOR%} "
	fi
}
local prompt_ruby='$(prompt_ruby_f)'


# Python prompt
PYTHON_PROMPT_PREFIX="["
PYTHON_PROMPT_SUFFIX="]"
PYTHON_PROMPT_COLOR_DISABLED="$YELLOW"
PYTHON_PROMPT_COLOR_ENABLED="$YELLOW_BOLD"
PYTHON_PROMPT_COLOR_BRACES="$WHITE"

function prompt_py_f() {
	local python_info=''
	if which python &> /dev/null; then
		python_info="$(python_version_info)$(virtualenv_prompt_info)"
	fi

	if [[ $python_info == *@* ]]; then
		echo "%{$PYTHON_PROMPT_COLOR_BRACES%}${RUBY_PROMPT_PREFIX}%{$PYTHON_PROMPT_COLOR_ENABLED%}${python_info}%{$PYTHON_PROMPT_COLOR_BRACES%}${RUBY_PROMPT_SUFFIX}%{$RESET_COLOR%} "
	else
		echo "%{$PYTHON_PROMPT_COLOR_BRACES%}${RUBY_PROMPT_PREFIX}%{$PYTHON_PROMPT_COLOR_DISABLED%}${python_info}%{$PYTHON_PROMPT_COLOR_BRACES%}${RUBY_PROMPT_SUFFIX}%{$RESET_COLOR%} "
	fi
}
local prompt_py='$(prompt_py_f)'

function get_user_at_host() {
	local host_color=''
	local user_color=''

	if [[ $USER == root ]]; then
		user_color="%{$RED_BOLD%}"
		host_color="%{$RED_BOLD%}"
	else
		if [[ $USER == hake5 ]]; then
			user_color="%{$GREEN_BOLD%}"
		else
			user_color="%{$MAGENTA_BOLD%}"
		fi

		if [[ $HOST == *marius* ]]; then
			host_color="%{$GREEN_BOLD%}"
		else
			host_color="%{$MAGENTA_BOLD%}"
		fi
	fi

	echo "%{${user_color}%}%n%{$YELLOW_BOLD%}@%{${host_color}%}%m%{$RESET_COLOR%}"
}

function get_prompt() {
	if [[ $USER == root ]]; then
		echo "#"
	else
		echo "$"
	fi
}

local user_host='$(get_user_at_host)'
local user_prompt='%(?.%{$WHITE_BOLD%}$(get_prompt)%{$RESET_COLOR%}.%{$RED_BOLD%}$(get_prompt)%{$RESET_COLOR%})'
local current_dir='[%{$CYAN_BOLD%}%~%{$RESET_COLOR%}]'
local current_time='[%{$GREEN%}$(date +"%H:%M %d-%m-%Y")%{$RESET_COLOR%}] '
local return_code="%(?..[%{$RED_BOLD%}%?%{$RESET_COLOR%}] )"


PROMPT="
┌─[${user_host}]─${current_dir}${prompt_git}
└─${prompt_git_short}${user_prompt} "
#RPS1="%{$(echotc UP 1)%}${return_code}${current_time}${prompt_py}${prompt_ruby}%{$(echotc DO 1)%}"
RPS1="${return_code}${current_time}${prompt_py}${prompt_ruby}"