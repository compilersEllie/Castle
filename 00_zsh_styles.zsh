zstyle ':use-xdg-basedirs:(aws|az|bundle|cargo|claude|codex|copilot|docker|dotnet|duckdb|go|gpg|irb|java|jupyter|kubectl|less|mysql|nim|node|npm|parallel|python3|rbenv|readline|redis-cli|rg|ruff|rustup|screen|sqlite3|starship|wget|psql)' enabled yes
zstyle ':autocomplete:*' default-context history-incremental-search-backward
zstyle ':completion:*:*' ignored-patterns '*ORIG_HEAD'
