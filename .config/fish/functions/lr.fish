function lr --description 'List files sorted by modified time, newest last'
    eza -la --sort=modified --icons --git  --group --bytes $argv
end
