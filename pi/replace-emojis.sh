#!/usr/bin/env bash
# Replace the color emojis that Pi extensions hardcode with monochrome
# Nerd Font icons, so they follow the terminal theme.
#
# The emojis live inside installed npm packages, so `pi update` (or any
# reinstall of these packages) brings them back. Re-run this script after
# updating. It is idempotent: running it twice changes nothing.
#
#   🧠 -> 󰧑 (nf-md-brain)          engram status and memory tools
#   🤖 -> 󰚩 (nf-md-robot)          subagent cards and messages
#   🚀 -> 󱓞 (nf-md-rocket_launch)  YOLO mode
#   🔥 -> 󰈸 (nf-md-fire)           YOLO mode
#   🌹 -> ✿                         RDD card and banner (gentle-pi's own glyph)
#   ❌ -> ✗                         pi-btw errors
set -euo pipefail

modules="${PI_NPM_MODULES:-$HOME/.pi/agent/npm/node_modules}"
packages=(gentle-pi gentle-engram pi-btw pi-web-access)

targets=()
for package in "${packages[@]}"; do
  [[ -d "$modules/$package" ]] || continue
  while IFS= read -r -d '' file; do
    targets+=("$file")
  done < <(grep -rlZP '🧠|🤖|🚀|🔥|🌹|❌' "$modules/$package" \
             --include='*.ts' --include='*.js' --include='*.mjs' \
             --exclude-dir=node_modules --exclude-dir=tests --exclude-dir=test 2>/dev/null || true)
done

if (( ${#targets[@]} == 0 )); then
  echo "No emojis left to replace."
  exit 0
fi

perl -CSD -pi -e '
  s/\x{1F9E0}/\x{F09D1}/g;
  s/\x{1F916}/\x{F06A9}/g;
  s/\x{1F680}/\x{F14DE}/g;
  s/\x{1F525}/\x{F0238}/g;
  s/\x{1F339}/\x{273F}/g;
  s/\x{274C}/\x{2717}/g;
' "${targets[@]}"

echo "Replaced emojis in ${#targets[@]} file(s):"
printf '  %s\n' "${targets[@]#"$modules/"}"
