function rr --wraps=paru\ -Qqe\ \|\ fzf\ --preview\ \'paru\ -Qil\ \{\}\'\ --layout=reverse\ --bind\ \'enter:execute\(paru\ -Qil\ \{\}\ \|\ less\)\'\  --description alias\ p\ paru\ -Qqe\ \|\ fzf\ --preview\ \'paru\ -Qil\ \{\}\'\ --layout=reverse\ --bind\ \'enter:execute\(paru\ -Qil\ \{\}\ \|\ less\)\'\ 
  paru -Qqe | fzf --preview 'paru -Qil {}' --layout=reverse --bind 'enter:execute(paru -Qil {} | less)'  $argv
        
end
