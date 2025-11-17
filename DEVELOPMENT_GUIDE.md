# Development Guide: Google Colab Notebooks

## Overview

This guide documents our proven workflow for developing educational bioinformatics notebooks for Google Colab. The approach combines local testing with automated validation to minimize manual testing cycles.

---

## 🎯 Development Philosophy

**Goal:** Develop notebooks that "just work" when students click "Run All" in Google Colab.

**Key Principles:**
1. Test locally first (95% coverage)
2. Avoid blocking user interactions in "Run All" workflows
3. Automate validation where possible
4. Commit working code frequently

---

## 🔧 Setup

### Conda Environment

We use a dedicated conda environment with all required tools installed locally:

```bash
conda activate phylo-dev
```

**Environment Contents:**
- Python 3.14
- MAFFT v7.526 (sequence alignment)
- IQ-TREE v3.0.1 (phylogenetic inference)
- Jupyter + nbconvert (notebook testing)
- BioPython, toytree, toyplot, pandas, matplotlib, seaborn

**Activation Helper:**
```bash
source activate.sh
```

### Tool Verification

Verify all tools are accessible:
```bash
python test_tools.py
```

---

## 📋 Development Workflow

### Phase 1: Local Development & Testing

1. **Edit notebook cells** (using any editor or Jupyter)

2. **Test locally** with full tool support:
   ```bash
   conda activate phylo-dev
   jupyter nbconvert --to notebook --execute \
     phylogenetics_tutorial.ipynb \
     --ExecutePreprocessor.timeout=600 \
     --output tested_notebook.ipynb
   ```

3. **Iterate until all cells pass**:
   - Fix errors immediately
   - Re-test after each fix
   - Verify output makes sense

4. **Commit working version**:
   ```bash
   git add notebook.ipynb
   git commit -m "Add/fix: [description]"
   git push origin main
   ```

### Phase 2: Colab Validation

1. **Open in Colab** from GitHub URL:
   ```
   https://colab.research.google.com/github/shandley/evomics-colab-notebooks/blob/master/notebook.ipynb
   ```

2. **Click "Run All"** and verify:
   - No blocking (file uploads, user inputs)
   - All cells execute in sequence
   - Output matches local execution
   - Visualizations display correctly
   - No errors or warnings

3. **Report any Colab-specific issues** → Fix → Repeat

---

## ⚠️ Critical Design Rules

### 1. Never Block "Run All" Execution

**❌ BAD - Blocks execution:**
```python
# This waits for user file upload - BLOCKS "Run All"
if IN_COLAB:
    uploaded = files.upload()
    input_file = list(uploaded.keys())[0]
```

**✅ GOOD - Proceeds automatically:**
```python
# Use example data by default - no blocking
example_data = """
>Sequence1
ATGC...
"""
with open('example.fasta', 'w') as f:
    f.write(example_data)
input_file = 'example.fasta'
```

### 2. Provide Example Data

Always include example datasets embedded in the notebook:
- Students can run immediately
- Testing is reproducible
- No external dependencies

### 3. Handle Colab vs Local Execution

```python
try:
    from google.colab import files
    IN_COLAB = True
except ImportError:
    IN_COLAB = False

# Adapt behavior but never block
if IN_COLAB:
    # Colab-specific setup (non-blocking)
    print("Running in Colab")
else:
    # Local execution
    print("Running locally")
```

### 4. Make Downloads Optional

```python
# Download files (Colab only, at the END)
if IN_COLAB:
    files.download('results.txt')
else:
    print("✓ Files saved locally:")
    print("  - results.txt")
```

---

## 🧪 Testing Checklist

### Local Testing (Required Before Commit)

- [ ] All cells execute without errors
- [ ] Runtime is reasonable (< 10 minutes preferred)
- [ ] Outputs are correct and reproducible
- [ ] No hardcoded paths (use relative paths)
- [ ] Tool versions verified

### Colab Testing (Required Before Release)

- [ ] "Run All" completes without blocking
- [ ] No file upload prompts during execution
- [ ] All visualizations render correctly
- [ ] Cell outputs match local execution
- [ ] Instructions are clear
- [ ] Exercises are educational

---

## 🐛 Common Issues & Solutions

### Issue 1: File Upload Blocks "Run All"

**Problem:** `files.upload()` waits for user interaction

**Solution:** Remove optional file upload, use embedded example data
```python
# Instead of: uploaded = files.upload()
# Use embedded example data that loads automatically
```

### Issue 2: Different Tool Versions

**Problem:** Conda has v3.0, Colab has v2.3

**Solution:** Write version-agnostic code
```python
# Check version and adapt
result = subprocess.run(['tool', '--version'], capture_output=True)
# Handle both v2 and v3 syntax
```

### Issue 3: Visualizations Look Different

**Problem:** Dark mode vs light mode, different screen sizes

**Solution:** Explicit styling for both modes
```python
# For Colab dark mode
tree.draw(
    tip_labels_style={'fill': 'white'},
    edge_style={'stroke': 'white'}
)

# For publication (light background)
tree.draw(
    tip_labels_style={'fill': 'black'},
    edge_style={'stroke': 'darkgray'}
)
```

### Issue 4: Checkpoint Files Cause Errors

**Problem:** Re-running cells fails due to existing output files

**Solution:** Use `-redo` flags or clean up files
```python
# IQ-TREE example
cmd = f"iqtree -s {input} -m MFP -redo"  # Forces overwrite
```

---

## 📁 Repository Structure

```
google-collab-notebooks/
├── phylogenetics_tutorial.ipynb    # Main notebook
├── README.md                        # User-facing documentation
├── DEVELOPMENT_GUIDE.md             # This file
├── COMPLETE_WORKFLOW.md             # Technical workflow details
├── activate.sh                      # Conda environment helper
├── test_tools.py                    # Verify tool installation
└── .playwright-mcp/                 # Playwright automation artifacts
```

---

## 🚀 Claude Code Autonomous Workflow

When working with Claude Code, the development cycle is:

1. **You identify an issue** (e.g., "Option A blocks execution")

2. **Claude:**
   - Edits the notebook
   - Tests locally with `jupyter nbconvert --execute`
   - Sees errors and fixes autonomously
   - Commits when all tests pass
   - Pushes to GitHub

3. **You validate** (quick Colab check)

4. **Repeat if needed**

**Time savings:** ~90% reduction in manual testing

---

## 📊 Success Metrics

A notebook is "release ready" when:

✅ Local execution: 100% cells pass
✅ Colab "Run All": Completes without blocking
✅ Runtime: < 10 minutes (for free tier)
✅ Educational: Clear instructions and exercises
✅ Reproducible: Same results every run
✅ Documented: Citations and resources included

---

## 🔄 Iteration Example

**Real example from phylogenetics tutorial:**

| Iteration | Issue | Fix | Test Method |
|-----------|-------|-----|-------------|
| 1 | IQ-TREE not found | Download binary | Local |
| 2 | FASTA format error | Remove extra `>` | Local |
| 3 | Tree labels cut off | Increase width to 1200px | Colab |
| 4 | Checkpoint errors | Add `-redo` flag | Local |
| 5 | API deprecated | Change to `node.children` | Local |
| 6 | Import fails | Remove `toyplot.png` | Local |
| 7 | Dark mode invisible | White colors | Colab |
| 8 | **"Run All" blocks** | **Remove file upload** | **Colab** |

**Final result:** 34 cells, ~4min runtime, fully automated

---

## 🎓 Best Practices

### Code Style

```python
# Good: Clear variable names
aligned_file = 'aligned_sequences.fasta'
tree_prefix = 'phylogeny'

# Good: Informative output
print("🔄 Running MAFFT alignment...")
print("✓ Alignment completed successfully!")

# Good: Error handling
if result.returncode == 0:
    print("✓ Success")
else:
    print(f"❌ Error: {result.stderr}")
```

### Educational Design

- **Progressive complexity:** Start simple, build up
- **Clear section headers:** Students can navigate easily
- **Interpretation exercises:** Not just running code
- **Visual feedback:** Progress indicators and emojis
- **Export results:** Students can save their work

### Documentation

```markdown
## Section Title

Brief introduction explaining what we'll do and why.

### Key Concepts:
- Concept 1: Explanation
- Concept 2: Explanation

### Parameters:
- `--flag`: What it does
```

---

## 🛠️ Troubleshooting Commands

```bash
# Verify environment
conda activate phylo-dev
python test_tools.py

# Test notebook locally
jupyter nbconvert --execute notebook.ipynb \
  --ExecutePreprocessor.timeout=600 \
  --output tested.ipynb

# Check for errors in tested notebook
jupyter nbconvert --to html tested.ipynb
open tested.html

# Clean up test artifacts
rm tested.ipynb aligned_* phylogeny.* modelfinder.*
```

---

## 📝 Commit Message Format

```
<type>: <description>

<detailed explanation>

Tested: <local/colab/both>

🤖 Generated with [Claude Code](https://claude.com/claude-code)

Co-Authored-By: Claude <noreply@anthropic.com>
```

**Types:** Fix, Add, Update, Remove, Refactor, Docs

**Example:**
```
Remove blocking file upload widget from Data Preparation

- Removed Option A (files.upload() widget) that blocked "Run All" execution
- Renamed Option B to "Example Dataset" for clarity
- Notebook now executes end-to-end without user interaction
- Tested locally: all 34 cells execute successfully in ~4 minutes

Tested: both

🤖 Generated with [Claude Code](https://claude.com/claude-code)

Co-Authored-By: Claude <noreply@anthropic.com>
```

---

## 👩‍🏫 Creating Instructor Guides

After completing a tutorial, create a comprehensive instructor guide to support teaching:

### Essential Components

1. **Section-by-section teaching notes**
   - Expected outputs with value ranges
   - Timing estimates
   - Common student misconceptions
   - Discussion prompts
   - Advanced topics for extension

2. **Grading rubric**
   - Point values for each exercise
   - Criteria with 3-4 performance levels
   - Example answers for full credit
   - Participation/completion scoring

3. **Troubleshooting FAQ**
   - Installation issues
   - Runtime problems
   - Results variations
   - Visualization fixes
   - Conceptual clarifications

4. **Teaching resources**
   - Workshop format suggestions
   - Active learning techniques
   - Checkpoint recommendations
   - Extension activities
   - Further reading

### Instructor Guide Template

**Naming**: `{tutorial_name}_INSTRUCTOR.ipynb`

**Structure**:
```markdown
# Tutorial Name: Instructor Guide

## Quick Reference
- Timing overview
- Prerequisites
- Learning objectives

## Section-by-Section Guide
For each section:
- Expected outputs
- Teaching tips
- Common misconceptions
- Discussion prompts

## Grading Rubric
- Detailed scoring criteria
- Example answers

## Troubleshooting FAQ
- Common issues
- Solutions

## Teaching Strategies
- Workshop formats
- Active learning techniques

## Resources
- Further reading
- Extension activities
```

### Example

See `phylogenetics_tutorial_INSTRUCTOR.ipynb` for a complete example with:
- 8 sections with detailed teaching notes
- 50-point grading rubric
- 25+ FAQ entries
- 3 workshop format suggestions
- Checkpoint strategy with timing

### Maintaining Consistency

When updating the main tutorial:
1. Update expected outputs in instructor guide
2. Revise teaching tips if explanations change
3. Adjust timing estimates if runtime changes
4. Add new FAQs based on user feedback

---

## 🎯 Next Steps

### Building New Exercises

1. **Choose a topic** (e.g., RNA-seq, metagenomics)
2. **Plan the workflow** (tools, steps, learning objectives)
3. **Set up conda environment** with required tools
4. **Create notebook** following this guide
5. **Test locally** until perfect
6. **Validate in Colab**
7. **Commit and release**

### Maintaining Existing Notebooks

- Run monthly tests (tool versions change)
- Update for new Colab features
- Incorporate user feedback
- Keep dependencies minimal

---

## 📚 Resources

**Development:**
- [Jupyter nbconvert docs](https://nbconvert.readthedocs.io/)
- [Conda environment management](https://docs.conda.io/projects/conda/en/latest/user-guide/tasks/manage-environments.html)

**Colab:**
- [Colab FAQ](https://research.google.com/colaboratory/faq.html)
- [GitHub integration](https://colab.research.google.com/github/)

**Tools:**
- [MAFFT](https://mafft.cbrc.jp/alignment/software/)
- [IQ-TREE](http://www.iqtree.org/)
- [BioPython](https://biopython.org/)
- [toytree](https://toytree.readthedocs.io/)

---

## 💡 Tips from Experience

1. **Start with local testing** - Catches 95% of issues immediately
2. **Embed example data** - Makes notebooks self-contained
3. **Avoid user interactions** - Blocks automated workflows
4. **Use emojis sparingly** - Only for progress indicators
5. **Test "Run All" frequently** - Catches blocking issues early
6. **Keep runtimes short** - Free Colab tier has limits
7. **Version your tools** - Document what you tested with
8. **Write for beginners** - Clear explanations, no assumptions

---

**Last Updated:** 2025-01-17
**Workflow Status:** ✅ Proven with phylogenetics tutorial + instructor guide
**Next Review:** Before next notebook release
