# Troubleshooting Google Colab Extension in VS Code

## Error: "Extension activation failed, run the 'Developer: Toggle Developer Tools'"

This means the Jupyter extension failed to activate. Here's how to fix it:

---

## ✅ Solution 1: Reload Window (Quick Fix)

1. Press `Cmd + Shift + P` (Mac) or `Ctrl + Shift + P` (Windows/Linux)
2. Type: `Developer: Reload Window`
3. Press Enter
4. Wait for VS Code to reload

**Test:** Open a `.ipynb` file and check if the error is gone.

---

## ✅ Solution 2: Install Required Extensions

The Google Colab extension needs these dependencies:

### Check and Install:

1. **Open Extensions panel:**
   - Click the Extensions icon (left sidebar)
   - Or press `Cmd+Shift+X` (Mac) / `Ctrl+Shift+X` (Windows)

2. **Search for and install these IN ORDER:**

   a. **Python** (by Microsoft)
      - Extension ID: `ms-python.python`
      - This is the foundation

   b. **Jupyter** (by Microsoft)
      - Extension ID: `ms-toolsai.jupyter`
      - Depends on Python extension

   c. **Jupyter Notebook Renderers** (by Microsoft)
      - Extension ID: `ms-toolsai.jupyter-renderers`
      - Optional but helpful

   d. **Colab** (by Google)
      - Extension ID: `Google.colab`
      - Depends on Jupyter extension

3. **After installing all, reload:**
   - `Cmd+Shift+P` → `Developer: Reload Window`

---

## ✅ Solution 3: Check Python Installation

The Jupyter extension needs Python installed on your system.

### Verify Python:

```bash
python3 --version
# Should show: Python 3.x.x
```

### If Python is missing:

**Mac (using Homebrew):**
```bash
brew install python3
```

**Or download from:** https://www.python.org/downloads/

### After installing Python:
1. Reload VS Code
2. Select Python interpreter: `Cmd+Shift+P` → `Python: Select Interpreter`

---

## ✅ Solution 4: View Detailed Error

1. Press `Cmd + Shift + P`
2. Type: `Developer: Toggle Developer Tools`
3. Click the **Console** tab
4. Look for red error messages
5. Common errors and fixes:

### Error: "Python extension not found"
- Install the Python extension (see Solution 2)

### Error: "Cannot find module 'node:xyz'"
- Update VS Code to latest version
- Help → Check for Updates

### Error: "Failed to activate extension 'ms-toolsai.jupyter'"
- Uninstall and reinstall Jupyter extension

---

## ✅ Solution 5: Reinstall Jupyter Extension

If Jupyter is corrupted:

1. **Open Extensions panel** (`Cmd+Shift+X`)
2. Find **Jupyter** extension
3. Click **Uninstall**
4. Reload window (`Cmd+Shift+P` → `Reload Window`)
5. Reinstall **Jupyter** extension
6. Reload window again

---

## ✅ Solution 6: Clear Extension Cache

Sometimes extension cache gets corrupted:

### Mac:
```bash
rm -rf ~/.vscode/extensions/ms-toolsai.jupyter-*
rm -rf ~/Library/Application\ Support/Code/User/workspaceStorage
```

### Then:
1. Restart VS Code completely (quit and reopen)
2. Reinstall Jupyter extension

---

## ✅ Solution 7: Update VS Code

Old VS Code versions may have compatibility issues:

1. **Check version:** Help → About
2. **Update:** Help → Check for Updates
3. **Minimum required:** VS Code 1.85+

---

## ✅ Solution 8: Check for Conflicting Extensions

Some extensions conflict with Jupyter:

### Temporarily disable all other extensions:

1. `Cmd+Shift+P` → `Extensions: Disable All Installed Extensions`
2. Reload window
3. Enable only:
   - Python
   - Jupyter
   - Colab
4. Reload window
5. Test if it works

If it works, re-enable other extensions one-by-one to find the conflict.

---

## 🧪 Test if Fixed

1. Open the phylogenetics notebook:
   ```bash
   # In terminal
   cd ~/Code/google-collab-notebooks
   open phylogenetics_tutorial.ipynb
   ```

2. Or in VS Code: File → Open → Select `phylogenetics_tutorial.ipynb`

3. **Top right should show:** "Select Kernel" button

4. Click it → Should see "Google Colab" option

5. Select Google Colab → Sign in → Choose runtime

6. **Success indicators:**
   - No error messages
   - See: `🟢 Connected to Colab`
   - Can run cells

---

## 🆘 Still Not Working?

### Get more info:

1. **Check Jupyter extension output:**
   - View → Output
   - Dropdown → Select "Jupyter"
   - Look for error messages

2. **Check Python extension output:**
   - View → Output
   - Dropdown → Select "Python"

3. **Share these details:**
   - VS Code version (Help → About)
   - Python version (`python3 --version`)
   - macOS version
   - Full error from Developer Tools console

---

## 🔄 Alternative: Use Regular Jupyter Instead

If Colab extension keeps failing, you can develop with local Jupyter:

```bash
# Install Jupyter
pip3 install jupyter notebook

# Start Jupyter
jupyter notebook
```

Then edit in browser and push to GitHub for students to use with Colab.

---

## 📝 Known Issues

### Issue 1: M1/M2/M3 Mac ARM Architecture
Some older extension versions had ARM compatibility issues.

**Fix:** Update all extensions to latest versions

### Issue 2: Multiple Python Installations
If you have Anaconda + Homebrew + System Python, extensions get confused.

**Fix:**
```bash
# Check all Python installations
which -a python3

# Select one in VS Code
Cmd+Shift+P → "Python: Select Interpreter"
```

### Issue 3: Corporate Proxy/Firewall
Extensions may fail to download dependencies.

**Fix:** Configure proxy settings in VS Code settings.json

---

## ✅ Recommended Setup Order

For fresh installation:

1. Update VS Code to latest
2. Install Python extension
3. Reload window
4. Install Jupyter extension
5. Reload window
6. Install Jupyter Renderers (optional)
7. Reload window
8. Install Google Colab extension
9. Reload window
10. Open a notebook
11. Select Python interpreter if prompted
12. Select Google Colab kernel

---

## 📧 Get Help

If still stuck, share:
- Screenshot of error
- Developer Tools console output
- Extension versions
- Python version
- VS Code version

Then we can debug further!
