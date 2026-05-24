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
      "command": "g++ -std=c++17 -o ${fileDirname}/${fileBasenameNoExtension} ${file} && ${fileDirname}/${fileBasenameNoExtension} < ${workspaceFolder}/input.txt > ${workspaceFolder}/output.txt",
      "group": {
        "kind": "build",
        "isDefault": true
      }
    }
  ]
}
EOF

  echo "🏆 Antigravity C++ project '$DIR' created successfully!"
  echo ""
  echo "📁 Project structure:"
  echo "  ├── $DIR.cpp      (main source)"
  echo "  ├── input.txt     (input file)"
  echo "  ├── output.txt    (output file)"
  echo "  ├── time.txt      (execution time)"
  echo "  └── .vscode/"
  echo "      └── tasks.json (Antigravity tasks)"
  echo ""
  echo "🚀 In Antigravity:"
  echo "  Ctrl+Shift+B      # run default task (compile and run)"
  echo "  Or select 'compile' task for just compilation"

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
