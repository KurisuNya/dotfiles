function backrun
  if test -z "$argv"
    echo "Error: No command provided."
    return 1
  end
  set start_time (date "+%m-%d-%H:%M:%S.%N" | cut -c1-18)
  set log_file "backrun_$argv[1]_$start_time.log"
  nohup unbuffer $argv > $log_file 2>&1 </dev/null &
end
