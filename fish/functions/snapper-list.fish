function snapper-list --wraps='sudo snapper -c $1 list' --description 'alias snapper-list sudo snapper -c $1 list'
  sudo snapper -c $argv list
end
