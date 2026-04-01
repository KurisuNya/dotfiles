function rn --wraps="paru -Qqdt | fzf --preview 'paru -Qil {}' --layout=reverse --bind 'enter:execute(paru -Qil {} | less)'  \$argv" --description "alias rn paru -Qqdt | fzf --preview 'paru -Qil {}' --layout=reverse --bind 'enter:execute(paru -Qil {} | less)'  \$argv"
    paru -Qqdt | fzf --preview 'paru -Qil {}' --layout=reverse --bind 'enter:execute(paru -Qil {} | less)'  $argv $argv
end
