function fish-prehook-long-command-notifier --on-event fish_preexec
    mkdir -p ~/tmp/fish/process/start_at/
    date +%s >~/tmp/fish/process/start_at/$fish_pid
end

function fish-posthook-long-command-notifier --on-event fish_postexec
    set -l s $status
    set message Success
    if [ $s -ne 0 ]
        set message Failure
    end

    set -l duration_sec (math (date +%s) - (cat ~/tmp/fish/process/start_at/$fish_pid))
    set -l threshold_sec 3
    if [ $duration_sec -ge $threshold_sec ]
        set -l a (echo $argv)
        echo "$message: $a"
        which noti 2>&1 >/dev/null && noti "$message: $a"
    end
    which voice 2>&1 >/dev/null && voice $message &
end
