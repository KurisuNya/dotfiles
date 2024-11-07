function conda_start
    export CRYPTOGRAPHY_OPENSSL_NO_LEGACY=1
    if test -f /opt/miniconda3/bin/conda
        eval /opt/miniconda3/bin/conda "shell.fish" "hook" $argv | source
    else
        if test -f "/opt/miniconda3/etc/fish/conf.d/conda.fish"
            . "/opt/miniconda3/etc/fish/conf.d/conda.fish"
        else
            set -x PATH "/opt/miniconda3/bin" $PATH
        end
    end
    export TERMINFO=/usr/share/terminfo
end
