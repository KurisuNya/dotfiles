function pyenv-init --wraps='pyenv init - | source' --description 'alias pyenv-init pyenv init - | source'
  pyenv init - | source $argv
        
end
