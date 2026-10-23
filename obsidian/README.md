# obsidian

Only the system-level look is tracked here, symlinked into the notes vault
(`~/Documents/notes/.obsidian/`):

- `snippets/kanagawa-gentleman.css` — the Kanagawa Wave theme (stock base theme + this snippet)
- `appearance.json` — fonts (Google Sans Flex, IosevkaTerm NF), accent, enabled snippet

Everything else in `.obsidian/` (plugins, hotkeys, QuickAdd/Templater config,
folder icons) is vault-specific — it references the vault's own paths — and is
versioned in the vault's repo instead.

Obsidian writes `appearance.json` with a plain `writeFile`, which follows
symlinks, so edits made from the app land here.

## New machine

```sh
V=~/Documents/notes/.obsidian
D=~/dev/config/dotfiles/obsidian
mkdir -p "$V/snippets"
ln -sfn "$D/snippets/kanagawa-gentleman.css" "$V/snippets/kanagawa-gentleman.css"
ln -sfn "$D/appearance.json" "$V/appearance.json"
```

Close Obsidian before linking; it rewrites `appearance.json` on exit.
