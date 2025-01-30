function snapper-cleanup --wraps='sudo systemctl start snapper-cleanup.service' --description 'alias snapper-cleanup sudo systemctl start snapper-cleanup.service'
  sudo systemctl start snapper-cleanup.service $argv
        
end
