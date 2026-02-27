brave() {
  # -------- Shortcuts --------
  typeset -A SITES
  SITES=(
    lms        "https://lmsug25.iiitkottayam.ac.in"
    youtube    "https://youtube.com"
    yt         "https://youtube.com"
    tuf        "https://takeuforward.org/dsa/strivers-a2z-sheet-learn-dsa-a-to-z"
    takeuforward "https://takeuforward.org/dsa/strivers-a2z-sheet-learn-dsa-a-to-z"
    yt_dsa     "https://www.youtube.com/playlist?list=PLgUwDviBIf0oF6QL8m22w1hIDC1vJ_BHz"
  )

  # -------- Groups --------
  typeset -A GROUPS
  GROUPS=(
    dsa "yt_dsa tuf"
  )

  PRIVATE=false

  # -------- List mode --------
  if [[ "$1" == "--list" ]]; then
    echo "🔗 Shortcuts:"
    for k in ${(k)SITES}; do
      printf "  %-12s → %s\n" "$k" "${SITES[$k]}"
    done | sort

    echo
    echo "📦 Groups:"
    for g in ${(k)GROUPS}; do
      printf "  %-12s → %s\n" "$g" "${GROUPS[$g]}"
    done | sort
    return 0
  fi

  # -------- Parse flags --------
  while [[ "$1" == -* ]]; do
    case "$1" in
      -p|--private)
        PRIVATE=true
        shift
        ;;
      *)
        echo "❌ Unknown option: $1"
        return 1
        ;;
    esac
  done

  [[ $# -eq 0 ]] && {
    echo "Usage: brave [-p] <sites|groups|urls>"
    return 1
  }

  # -------- Collect URLs --------
  urls=()

  for item in "$@"; do
    if [[ -n "${GROUPS[$item]}" ]]; then
      for site in ${(s: :)GROUPS[$item]}; do
        urls+=("${SITES[$site]}")
      done
    else
      if [[ -n "${SITES[$item]}" ]]; then
        urls+=("${SITES[$item]}")
      else
        [[ "$item" != http* ]] && item="https://$item"
        urls+=("$item")
      fi
    fi
  done

  # -------- Deduplicate --------
  urls=($(printf "%s\n" "${urls[@]}" | awk '!seen[$0]++'))

  # -------- Build args --------
  ARGS=()
  $PRIVATE && ARGS+=(--incognito)

  # -------- Launch Brave --------
  open -na "Brave Browser" --args "${ARGS[@]}" "${urls[@]}"
}

