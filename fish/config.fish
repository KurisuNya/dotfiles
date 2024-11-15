if status is-interactive
  # login method
  if test -n "$SSH_TTY"  # login with ssh
    if test -z "$SSH_STARTED"
      export SSH_STARTED="started"
      neofetch
    end
  else  # login with laptop
    if test -z "$DISPLAY" -a $XDG_VTNR = 1
      uwsm start hyprland.desktop
    end
  end

  # terminal style
  if test -e ~/.config/fish/terminal-style.json
    oh-my-posh disable notice
    oh-my-posh init fish --config ~/.config/fish/terminal-style.json | source
  end

  # fzf bind
  fzf_configure_bindings --history=\ch --directory=\cf --git_log=\cl --git_status=\cs --processes=\cp

  # zoxide
  zoxide init fish | source

  # venv prompt
  export VIRTUAL_ENV_DISABLE_PROMPT=1
  functions -c fish_prompt _old_prompt
  function fish_prompt
    if set -q VIRTUAL_ENV
      echo -n -s (set_color yellow) "(" (basename "$VIRTUAL_ENV") ")" (set_color normal) " "
    end
    _old_prompt
  end
end

