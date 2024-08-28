# PROMPT="%{$fg_bold[blue]%}➜%{$reset_color%} %n@%{$fg[blue]%}%m%{$reset_color%}: %{$fg[cyan]%}%c%{$reset_color%} %# $(git_prompt_info)"

# ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg_bold[blue]%}git:(%{$fg[green]%}"
# ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%} "
# # ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[blue]%}) %{$fg[yellow]%}✗"
# # ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[blue]%})"

# af-magic.zsh-theme
#
# Author: Andy Fleming
# URL: http://andyfleming.com/

# ------------------------------------------------------------------------------------------
# ~/Developer/Projects/malstrom.me (main*) »                                orion@Tesseract 

# Make pwd just last path component

# primary prompt: dashed separator, directory and vcs info
PS1="${FG[091]}%c\$(git_prompt_info)\$(hg_prompt_info) ${FG[091]}%(!.#.$)%{$reset_color%} "
PS2="%{$fg[red]%}\ %{$reset_color%}"

# right prompt: return code, virtualenv and context (user@host)
RPS1="%(?..%{$fg[red]%}%? ↵%{$reset_color%})"
if (( $+functions[virtualenv_prompt_info] )); then
  RPS1+='$(virtualenv_prompt_info)'
fi
RPS1+=" ${FG[244]}%n@%m%{$reset_color%}"

# git settings
ZSH_THEME_GIT_PROMPT_PREFIX=" ${FG[244]}(${FG[028]}"
ZSH_THEME_GIT_PROMPT_CLEAN=""
ZSH_THEME_GIT_PROMPT_DIRTY="${FG[124]}*%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="${FG[244]})%{$reset_color%}"

# hg settings
ZSH_THEME_HG_PROMPT_PREFIX=" ${FG[244]}(${FG[078]}"
ZSH_THEME_HG_PROMPT_CLEAN=""
ZSH_THEME_HG_PROMPT_DIRTY="${FG[091]}*%{$reset_color%}"
ZSH_THEME_HG_PROMPT_SUFFIX="${FG[244]})%{$reset_color%}"

# virtualenv settings
ZSH_THEME_VIRTUALENV_PREFIX=" ${FG[244]}["
ZSH_THEME_VIRTUALENV_SUFFIX="]%{$reset_color%}"
