#!/bin/zsh

mkcpp() {
  if [ -z "$1" ]; then
    echo "Usage: mkcpp <folder_name>"
    return 1
  fi

  DIR="$1"

  # ==============================
  # 📁 Safety Checks
  # ==============================
  if [ -e "$DIR" ] && [ ! -d "$DIR" ]; then
    echo "❌ Error: '$DIR' exists and is a file"
    return 1
  fi

  if [ -d "$DIR" ]; then
    echo "❌ Error: directory '$DIR' already exists"
    return 1
  fi

  mkdir -p "$DIR" || return 1

  # ==============================
  # 🔥 C++ SOURCE FILE
  # ==============================
  cat > "$DIR/$DIR.cpp" <<EOF
#include <bits/stdc++.h>
using namespace std;

using ll = long long;
using ld = long double;

int main() {
    ios::sync_with_stdio(false);
    cin.tie(nullptr);
    
    return 0;
}
EOF

  # ==============================
  # 📄 Required Files
  # ==============================
  echo "" > "$DIR/input.txt"
  echo "" > "$DIR/output.txt"
  echo "" > "$DIR/time.txt"

  # ==============================
  # 📁 Create .vscode folder
  # ==============================
  mkdir -p "$DIR/.vscode"

  # ==============================
  # ⚙️ TASKS.JSON inside .vscode folder
  # ==============================
  cat > "$DIR/.vscode/tasks.json" <<'EOF'
{
  "version": "2.0.0",
  "tasks": [
    {
      "label": "compile",
      "type": "shell",
      "command": "g++",
      "args": [
        "-std=c++17",
        "-o",
        "${fileDirname}/${fileBasenameNoExtension}",
        "${file}"
      ],
      "group": {
        "kind": "build",
        "isDefault": false
      }
    },
    {
      "label": "compile and run",
      "type": "shell",
      "command": "g++ -std=c++17 -o ${fileDirname}/${fileBasenameNoExtension} ${file} && START=$(gdate +%s%N 2>/dev/null || date +%s%N) && ${fileDirname}/${fileBasenameNoExtension} < ${workspaceFolder}/input.txt > ${workspaceFolder}/output.txt && END=$(gdate +%s%N 2>/dev/null || date +%s%N) && NS=$((END-START)) && MS=$((NS/1000000)) && echo \"Runtime: ${MS} ms | ${NS} ns\" > ${workspaceFolder}/time.txt",
      "group": {
        "kind": "build",
        "isDefault": true
      }
    }
  ]
}
EOF

  echo "🏆 Antigravity C++ project '$DIR' created successfully!"

  # ==============================
  # 📂 Enter Directory
  # ==============================
  cd "$DIR" || return 1

  # ==============================
  # 🖥 OPTIONAL: Open in Antigravity (if antigravity command exists)
  # ==============================
  echo ""
  echo "Opening in Antigravity..."
  open -a "Antigravity IDE" .
}
