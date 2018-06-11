#!/usr/bin/env bash
set -e

source ~/.bash_profile

printf "Configuring Bash-it installation...\n"
# Path to the bash it configuration
export BASH_IT="$HOME/.bash_it"


bash-it enable plugin alias-completion tmux ssh projects  history extract explain dirs compress xterm

bash-it enable alias apt curl docker general git homebrew tmux
bash-it enable completion bash-it	brew conda	defaults dirs docker	docker-compose	docker-machine git hub pip	projects	ssh system	tmux

bash-it disable plugin chruby
bash-it disable plugin chruby-auto
bash-it disable plugin postgres
bash-it disable plugin z
bash-it disable plugin todo
bash-it disable alias emacs
