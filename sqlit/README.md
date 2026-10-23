# sqlit

Only `themes/` is tracked here, symlinked to `~/.config/sqlit/themes`.

The rest of `~/.config/sqlit/` stays local on purpose: sqlit writes
`credentials.json` and `connections.json` into that same directory as soon as a
connection is saved, and `settings.json` is already mode `600`. None of that
belongs in a repo.

The trade-off is that the theme is versioned but its *activation* is not.
On a new machine, register it once:

```sh
python3 - <<'PY'
import json, pathlib
p = pathlib.Path.home()/".config/sqlit/settings.json"
d = json.loads(p.read_text()) if p.exists() else {}
d["theme"] = "kanagawa-blur"
d["custom_themes"] = sorted(set(d.get("custom_themes", []) + ["kanagawa-blur"]))
p.write_text(json.dumps(d, indent=2) + "\n")
PY
```

`keymap.json` is also local and untracked — move it here too if it ever holds
bindings worth keeping.

## Theme format

JSON under `themes/<name>.json`, with a single `theme` object. Valid keys come
from `CUSTOM_THEME_FIELDS` in
`site-packages/sqlit/domains/shell/app/theme_manager.py`: `name`, `primary`,
`secondary`, `warning`, `error`, `success`, `accent`, `foreground`,
`background`, `surface`, `panel`, `boost`, `dark`, `luminosity_spread`,
`text_alpha`, `variables`. Vim mode indicators live under `variables` as
`mode-normal-color` and `mode-insert-color`.

Do not probe the theme system by running `sqlit --theme '?'` — it launches the
TUI and hangs the shell. Read the package's Python sources instead.
