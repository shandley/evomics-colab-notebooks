# Development Workflows for Google Colab Notebooks

This document outlines the best workflows for developing Colab notebooks with Claude Code assistance.

---

## 🏆 Option 1: VS Code + Google Colab Extension (RECOMMENDED)

**Best for:** Real-time development and testing while keeping local editing

### Setup (One-time)

1. **Install the Google Colab extension:**
   ```bash
   code --install-extension Google.colab
   ```
   Or: VS Code → Extensions → Search "Google Colab" → Install

2. **Sign in to Google:**
   - Open any `.ipynb` file in VS Code
   - Click "Select Kernel" (top right)
   - Choose "Google Colab"
   - Sign in with your Google account

### Development Workflow

```
┌─────────────────┐
│  Edit in VS Code │ ← You and Claude Code work here
│  (.ipynb files)  │
└────────┬────────┘
         │
         ▼
┌─────────────────┐
│ Select Colab    │ ← Choose CPU/GPU/TPU runtime
│ Kernel          │
└────────┬────────┘
         │
         ▼
┌─────────────────┐
│ Run cells       │ ← Executes on Colab infrastructure
│ Test locally    │
└────────┬────────┘
         │
         ▼
┌─────────────────┐
│ Save & commit   │ ← Changes saved locally
│ to git          │
└─────────────────┘
```

### Advantages
- ✅ No upload/download cycle
- ✅ Instant changes and testing
- ✅ Keep VS Code features (git, Claude Code, extensions)
- ✅ Access to GPUs/TPUs
- ✅ Works with local git repository

### Limitations
- ⚠️ Google Drive secrets not yet supported
- ⚠️ Some Colab-specific features may not work

---

## 🥈 Option 2: GitHub Integration

**Best for:** Sharing with students, version control, collaboration

### Setup (One-time)

1. **Create GitHub repository:**
   ```bash
   # In this directory
   git init
   git add .
   git commit -m "Initial commit: Phylogenetics tutorial"
   gh repo create evomics-colab-notebooks --public --source=. --push
   ```

   Or manually:
   - Go to https://github.com/new
   - Create repository (e.g., `evomics-colab-notebooks`)
   - Follow instructions to push

2. **Configure for Colab:**
   - Add a "Open in Colab" badge to README
   - Ensure notebooks are in repository root or clear subdirectory

### Development Workflow

```
┌─────────────────┐
│  Edit locally   │ ← Claude Code helps here
│  with Claude    │
└────────┬────────┘
         │
         ▼
┌─────────────────┐
│ git commit      │
│ git push        │
└────────┬────────┘
         │
         ▼
┌─────────────────┐
│ Open in Colab   │ ← Use special URL or badge
│ from GitHub     │
└────────┬────────┘
         │
         ▼
┌─────────────────┐
│ Test in Colab   │ ← Student/instructor testing
│ Share URL       │
└────────┬────────┘
         │
         ▼
┌─────────────────┐
│ Save to Drive   │ ← (Optional) Students can save copy
│ or GitHub       │
└─────────────────┘
```

### Opening from GitHub

**Method 1: Direct URL**
```
https://colab.research.google.com/github/[username]/[repo]/blob/[branch]/[notebook].ipynb
```

Example:
```
https://colab.research.google.com/github/scotthandley/evomics-colab-notebooks/blob/main/phylogenetics_tutorial.ipynb
```

**Method 2: Badge in README**
Add to your README.md:
```markdown
[![Open In Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/[username]/[repo]/blob/main/phylogenetics_tutorial.ipynb)
```

### Advantages
- ✅ Version control built-in
- ✅ Easy sharing with students
- ✅ Can save changes back to GitHub from Colab
- ✅ Works with evomics.org website
- ✅ Public visibility for educational content

### Workflow with Claude Code
1. Ask Claude to modify notebook
2. Test locally with VS Code Colab extension (Option 1)
3. Commit and push to GitHub
4. Share GitHub URL with students
5. Students open directly in Colab

---

## 🥉 Option 3: Google Drive Mounting

**Best for:** Quick personal testing, not recommended for production

### Setup

```python
# In a Colab cell
from google.colab import drive
drive.mount('/content/drive')

# Navigate to your notebook
%cd /content/drive/MyDrive/path/to/notebooks
```

### Development Workflow

1. Edit locally with Claude Code
2. Upload to Google Drive (manually or via sync tool)
3. Open Colab, mount Drive
4. Run notebook from Drive location

### Advantages
- ✅ Private storage
- ✅ Good for personal experiments

### Disadvantages
- ❌ Still requires upload step
- ❌ Drive sync can be slow
- ❌ Not good for sharing
- ❌ Not version controlled

---

## 🔧 Option 4: Colab CLI Tools (Advanced)

There are some community tools for Colab automation:

### jupyter-colab
```bash
pip install jupyter-colab
jupyter colab upload notebook.ipynb
```

### Limitations
- Community-maintained (not official)
- Less reliable than GitHub integration
- Requires API tokens

---

## 📋 Recommended Setup for Evomics

For your use case (educational platform), I recommend a **hybrid approach**:

### Development Phase
1. **Use VS Code + Colab Extension** (Option 1)
   - Edit with Claude Code locally
   - Test on Colab runtime in real-time
   - Commit to local git

### Publishing Phase
2. **Push to GitHub** (Option 2)
   - Make repository public
   - Add Colab badges to README
   - Link from learn.evomics.org

### Student Experience
3. **Students use GitHub links**
   - Click "Open in Colab" badge
   - Runs in their Google account
   - Can save copy to their Drive
   - Can fork on GitHub if they want

---

## 🎯 Quick Start Commands

### Set up VS Code + Colab Extension
```bash
# Install extension
code --install-extension Google.colab

# Open notebook
code phylogenetics_tutorial.ipynb

# Select Colab kernel in VS Code
# (Use Command Palette: Cmd/Ctrl+Shift+P → "Select Kernel" → "Google Colab")
```

### Set up GitHub Integration
```bash
# Initialize repo
git init
git add .
git commit -m "Initial commit: Evomics phylogenetics tutorial"

# Create on GitHub (using gh CLI)
gh repo create evomics-colab-notebooks --public --source=. --push

# Or add remote manually
git remote add origin https://github.com/[username]/evomics-colab-notebooks.git
git push -u origin main
```

### Update workflow with Claude Code
```bash
# 1. Edit notebook with Claude Code assistance
# 2. Test in VS Code with Colab runtime
# 3. Commit changes
git add phylogenetics_tutorial.ipynb
git commit -m "Fix: Update MAFFT alignment cell to remove deprecated BioPython"
git push

# Students access at:
# https://colab.research.google.com/github/[username]/evomics-colab-notebooks/blob/main/phylogenetics_tutorial.ipynb
```

---

## 🚀 Integration with learn.evomics.org

Once on GitHub, you can embed in your educational site:

### Direct Link
```html
<a href="https://colab.research.google.com/github/[user]/[repo]/blob/main/phylogenetics_tutorial.ipynb">
  <img src="https://colab.research.google.com/assets/colab-badge.svg" alt="Open In Colab"/>
</a>
```

### Embedded Preview
Some educational platforms can embed Colab notebooks directly using iframes.

---

## 📝 Summary

| Method | Setup Time | Testing Speed | Sharing | Version Control | Recommended For |
|--------|-----------|---------------|---------|-----------------|-----------------|
| VS Code Extension | 5 min | Instant | No | Git | **Development** |
| GitHub | 10 min | Fast | Yes | Git | **Publishing** |
| Drive Mount | 2 min | Slow | Limited | No | Personal only |
| CLI Tools | 15 min | Medium | Limited | No | Advanced users |

**For Evomics: Use VS Code Extension for development, GitHub for distribution.**
