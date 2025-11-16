# Claude Code Autonomous Development Workflow

## 🎯 Goal: Maximum Claude Autonomy

This workflow allows Claude Code to **edit → test → fix → push** with minimal human intervention.

---

## 🔄 The Workflow

### Phase 1: Development (100% Claude)

```bash
# 1. Claude edits the notebook
# 2. Claude tests it locally:
source .venv/bin/activate
jupyter nbconvert --to notebook --execute phylogenetics_tutorial.ipynb \
  --output phylogenetics_tutorial_tested.ipynb

# 3. If errors: Claude sees them immediately and fixes
# 4. If success: Overwrite original
mv phylogenetics_tutorial_tested.ipynb phylogenetics_tutorial.ipynb

# 5. Claude commits and pushes
git add phylogenetics_tutorial.ipynb
git commit -m "Fix: [description]"
git push
```

### Phase 2: Validation (You check in Colab)

```bash
# You open in browser:
https://colab.research.google.com/github/YOUR_USERNAME/evomics-colab-notebooks/blob/main/phylogenetics_tutorial.ipynb

# Final check that it works in real Colab environment
# Report any Colab-specific issues to Claude
```

---

## 📝 Commands Claude Uses

### Test notebook locally:
```bash
source .venv/bin/activate
jupyter nbconvert --to notebook --execute phylogenetics_tutorial.ipynb \
  --ExecutePreprocessor.timeout=600 \
  --output tested.ipynb 2>&1
```

### See what failed:
Errors show up immediately in the output - Claude reads and fixes

### Update and retest:
Claude edits the .ipynb file directly, then runs execute again

### Push when working:
```bash
git add .
git commit -m "Fix: [specific issue]"
git push
```

---

## 🚀 Advantages

**For Claude:**
- ✅ Edit notebook
- ✅ Execute locally
- ✅ See errors immediately
- ✅ Fix without asking you
- ✅ Iterate rapidly
- ✅ Push when ready

**For You:**
- ✅ Just review final result in Colab
- ✅ No manual testing loop
- ✅ No copy/paste of errors
- ✅ Just approve or request changes

---

## ⚠️ Limitations

**Local testing won't catch:**
- Colab-specific environment differences
- Pre-installed package versions on Colab
- Colab-only features (forms, Drive mounting)

**Solution:** Claude tests 90% locally, you do final 10% validation in real Colab

---

## 📊 Comparison

| Workflow | Claude Autonomy | Speed | Colab Accuracy |
|----------|----------------|-------|----------------|
| Manual upload/download | 20% | Slow | 100% |
| VS Code Extension (broken) | 80% | Fast | 100% |
| **Jupyter Local + GitHub** | **90%** | **Very Fast** | **95%** |

---

## 🎓 Example Session

```bash
You: "The MAFFT cell has a BioPython error"

Claude:
1. Reads notebook
2. Fixes BioPython code
3. Runs: jupyter nbconvert --execute
4. Sees it works
5. Commits and pushes
6. Tells you: "Fixed! Test at: [Colab URL]"

You: "Works! Now add error handling"

Claude:
1. Adds try/except blocks
2. Tests locally
3. Pushes
4. You: Final check in Colab
```

---

## 🔧 Setup Complete

Already done:
- ✅ venv created at `.venv/`
- ✅ Jupyter installed
- ✅ Git initialized
- ✅ .gitignore configured

Next step:
- Push to GitHub (so you can test in Colab)
