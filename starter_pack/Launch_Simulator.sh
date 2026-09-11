#!/usr/bin/env bash
# PegFX — Virtual Dot-Matrix Hardware Simulator Launcher for macOS & Linux

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

if command -v python3 >/dev/null 2>&1; then
    PY_CMD="python3"
elif command -v python >/dev/null 2>&1; then
    PY_CMD="python"
else
    echo "================================================================"
    echo " PegFX Virtual Dot-Matrix Hardware Simulator"
    echo "================================================================"
    echo ""
    echo " [!] Python 3 is required to run the Virtual Matrix Simulator,"
    echo "     but it was not found on your system PATH."
    echo ""
    echo " Please install Python 3 using your package manager:"
    echo "   - Ubuntu/Debian: sudo apt install python3 python3-tk"
    echo "   - Fedora:        sudo dnf install python3 python3-tkinter"
    echo "   - Arch Linux:    sudo pacman -S python python-tk"
    echo "   - macOS:         brew install python-tk"
    echo ""
    exit 1
fi

if [ -f "$DIR/../tools/simulate_matrix.py" ]; then
    "$PY_CMD" "$DIR/../tools/simulate_matrix.py" "$@"
elif [ -f "$DIR/tools/simulate_matrix.py" ]; then
    "$PY_CMD" "$DIR/tools/simulate_matrix.py" "$@"
elif [ -f "$DIR/simulate_matrix.py" ]; then
    "$PY_CMD" "$DIR/simulate_matrix.py" "$@"
else
    echo "Error: simulate_matrix.py not found."
    exit 1
fi
