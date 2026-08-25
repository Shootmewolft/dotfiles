# Symbols Icon Theme — NestJS override

This is a snapshot of the patched `symbols-icon-theme.json` from the
"Symbols Icon Theme" Zed extension, NOT a live symlink — Zed's extension
directory (`~/.local/share/zed/extensions/installed/`) is managed by Zed
itself and isn't part of the usual `~/.config` symlink pattern.

## What changed
`file_suffixes` remapped from Angular to NestJS icons (the theme ships the
Nest SVGs but doesn't wire them up by default):
- `service.ts` / `service.js`: angular-service -> nest-service
- `guard.ts` / `guard.js`: angular-guard -> nest-guard
- `controller.ts` / `controller.js`: (was unmapped) -> nest-controller
- `decorator.ts` / `decorator.js`: (was unmapped) -> nest-decorator
- `middleware.ts` / `middleware.js`: (was unmapped) -> nest-middleware

`module.ts`/`module.js` and `pipe.ts`/`pipe.js` were left as Angular — the
theme has no `nest-module` / `nest-pipe` icon to map them to.
`*.dart` suffixes were left untouched (NestJS doesn't use Dart).

## Reapplying after an extension update
If Zed updates the "Symbols Icon Theme" extension and reverts this file,
just overwrite it again:

    cp ~/dev/config/dotfiles/zed/icon-theme-overrides/symbols-icon-theme.json \
       ~/.local/share/zed/extensions/installed/symbols/icon_themes/symbols-icon-theme.json

Then reload the Zed window (or restart Zed) for it to take effect.
