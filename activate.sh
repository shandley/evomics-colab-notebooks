#!/bin/bash
# Activate the phylo-dev conda environment
# Usage: source activate.sh

echo "🔬 Activating phylo-dev conda environment..."
eval "$(conda shell.bash hook)"
conda activate phylo-dev

echo "✅ Environment activated!"
echo ""
echo "Available tools:"
echo "  - Python $(python --version 2>&1 | cut -d' ' -f2)"
echo "  - MAFFT $(mafft --version 2>&1 | head -1)"
echo "  - IQ-TREE $(iqtree --version 2>&1 | head -1)"
echo ""
echo "Ready for development!"
