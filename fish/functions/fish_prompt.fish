function fish_prompt
    set -l last_status $status
    set -l stat
    set -l pwd
    # Check if it's a transient or final prompt
        if contains -- --final-rendering $argv
                set pwd (path basename $PWD)
        else
                set pwd (prompt_pwd)
                # Prompt status only if it's not 0
        if test $last_status -ne 0
            set stat (set_color red)"[$last_status]"(set_color normal)
        end
    end

    string join '' -- (set_color green) $pwd (set_color normal) $stat '> '
end
