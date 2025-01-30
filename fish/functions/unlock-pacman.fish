function unlock-pacman --wraps='sudo rm /var/lib/pacman/db.lck' --description 'alias unlock-pacman sudo rm /var/lib/pacman/db.lck'
  sudo rm /var/lib/pacman/db.lck $argv
        
end
