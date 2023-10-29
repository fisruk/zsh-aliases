#—————————————————————————————————————————————————————————————————————————————————# 
# Delay the initialization of the just completion until first j (just) call
#—————————————————————————————————————————————————————————————————————————————————#
function j() {
  	source <(just --completions zsh)


  	just $@
}

alias j.s="just start"
alias j.i="just install"
alias j.b="just build"
alias j.t="just test"
alias j.pre="just pre-commit"