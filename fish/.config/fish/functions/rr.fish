function rr --wraps="expac --timefmt='%s' '%l %w %n' | grep explicit | sort -r | awk '{print \$3}' | fzf --preview 'paru -Qil {}' --layout=reverse --bind 'enter:execute(paru -Qil {} | less)'" --description "alias rr expac --timefmt='%s' '%l %w %n' | grep explicit | sort -r | awk '{print \$3}' | fzf --preview 'paru -Qil {}' --layout=reverse --bind 'enter:execute(paru -Qil {} | less)'"
  expac --timefmt='%s' '%l %w %n' | grep explicit | sort -r | awk '{print $3}' | fzf --preview 'paru -Qil {}' --layout=reverse --bind 'enter:execute(paru -Qil {} | less)' $argv
        
end
