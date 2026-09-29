zstyle ':use-xdg-basedirs:(aws|az|bundle|cargo|claude|codex|copilot|docker|dotnet|duckdb|fzf|go|gpg|irb|java|jupyter|kubectl|less|mysql|nim|node|npm|nvm|parallel|python3|rbenv|readline|redis-cli|rg|ruff|rustup|screen|sqlite3|starship|wget|psql)' enabled yes
zstyle ':autocomplete:*' default-context history-incremental-search-backward
zstyle ':completion:*:*' ignored-patterns '*ORIG_HEAD'
zstyle ':completion:*' menu select
zstyle ':completion:*:default'         list-colors ${(s.:.)LS_COLORS}
