#!/usr/bin/env bash
set -u

git add .

if git diff --cached --quiet; then
  echo "Nada para commitear."
  exit 0
fi

prompt="Write a single git commit message in Conventional Commits format: <type>(<scope>): <description>. Valid types: feat, fix, refactor, docs, test, chore, style, perf, build, ci, revert. Imperative mood, one line, no body. Output ONLY the raw commit message text, no quotes, no code fences, no explanation, no AI attribution."
commit_regex='^(feat|fix|refactor|docs|test|chore|style|perf|build|ci|revert)(\([a-z0-9-]+\))?: .+'

diff=$(git diff --cached)
msg=""

is_valid_commit_message() {
  printf "%s" "$1" | grep -Eq "$commit_regex"
}

extract_commit_message() {
  printf "%s" "$1" \
    | tr -d '\r' \
    | sed '/^[[:space:]]*$/d' \
    | grep -E "$commit_regex" \
    | head -n 1
}

try_provider() {
  provider="$1"
  shift

  command_name="$1"
  if ! command -v "$command_name" >/dev/null 2>&1; then
    echo "Saltando $provider: comando '$command_name' no encontrado." >&2
    return 1
  fi

  echo "Generando mensaje con $provider..." >&2

  output=$(printf "%s" "$diff" | "$@" 2>&1)
  status=$?
  candidate=$(extract_commit_message "$output")

  if [ $status -ne 0 ]; then
    echo "$provider falló:" >&2
    printf "%s\n" "$output" | sed -n '1,3p' >&2
    return 1
  fi

  case "$output" in
    *"Not logged in"*|*"Please run /login"*)
      echo "$provider no está autenticado." >&2
      return 1
      ;;
  esac

  if [ -z "$candidate" ]; then
    echo "$provider no devolvió un Conventional Commit válido." >&2
    printf "%s\n" "$output" | sed -n '1,3p' >&2
    return 1
  fi

  msg="$candidate"
  return 0
}

# Fallbacks en orden. Se usan solo si el comando existe y devuelve un mensaje válido.
# - claude: Claude Code CLI
# - codex: OpenAI Codex CLI (`codex exec`)
# - chatgpt: CLI compatible con `-p`
try_provider "Claude" claude -p "$prompt" \
  || try_provider "Codex" codex exec "$prompt" \
  || try_provider "ChatGPT" chatgpt -p "$prompt"

if [ -z "$msg" ]; then
  echo "No se pudo generar un mensaje de commit válido con ningún proveedor."
  echo "Verifica login/configuración de claude, codex o chatgpt."
  exit 1
fi

if ! is_valid_commit_message "$msg"; then
  echo "El mensaje generado no cumple Conventional Commits:"
  echo "$msg"
  exit 1
fi

echo "Commit: $msg"
git commit -m "$msg" && git push -u origin HEAD
