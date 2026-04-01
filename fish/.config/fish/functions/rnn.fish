function rnn --wraps="paru -Qqdtt | fzf --preview 'paru -Qil {}' --layout=reverse --bind 'enter:execute(paru -Qil {} | less)'  \$argv" --description "alias rnn paru -Qqdtt | fzf --preview 'paru -Qil {}' --layout=reverse --bind 'enter:execute(paru -Qil {} | less)'  \$argv"
    paru -Qqdtt | fzf --preview 'paru -Qil {}' --layout=reverse --bind 'enter:execute(paru -Qil {} | less)'  $argv $argv
end
