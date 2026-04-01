function r --wraps=paru\ -Qq\ \|\ fzf\ --preview\ \'paru\ -Qil\ \{\}\'\ --layout=reverse\ --bind\ \'enter:execute\(paru\ -Qil\ \{\}\ \|\ less\)\' --description alias\ r\ paru\ -Qq\ \|\ fzf\ --preview\ \'paru\ -Qil\ \{\}\'\ --layout=reverse\ --bind\ \'enter:execute\(paru\ -Qil\ \{\}\ \|\ less\)\'
  paru -Qq | fzf --preview 'paru -Qil {}' --layout=reverse --bind 'enter:execute(paru -Qil {} | less)' $argv
        
end
