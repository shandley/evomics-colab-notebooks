# Evomics Google Colab Notebooks

Educational bioinformatics notebooks designed to complement [learn.evomics.org](https://learn.evomics.org).

## Available Notebooks

### 1. Phylogenetics Tutorial (`phylogenetics_tutorial.ipynb`)

[![Open In Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/shandley/evomics-colab-notebooks/blob/master/phylogenetics_tutorial.ipynb)

A comprehensive tutorial covering the complete phylogenetic inference workflow.

**Topics Covered:**
- Multiple sequence alignment with MAFFT
- Model selection with ModelFinder (IQ-TREE)
- Maximum likelihood tree inference with IQ-TREE
- Bootstrap analysis for branch support
- Tree visualization with toytree
- Interpretation of bootstrap values and branch lengths
- Evolutionary distance analysis

**Learning Objectives:**
- Understand phylogenetic inference principles
- Select appropriate evolutionary models
- Construct and interpret ML phylogenetic trees
- Analyze branch support and evolutionary distances

**Prerequisites:**
- Basic understanding of evolution and DNA sequences
- Familiarity with FASTA format
- Basic Python knowledge (helpful but not required)

**Usage:**
1. Open the notebook in Google Colab
2. Run cells sequentially from top to bottom
3. Use the example dataset or upload your own sequences
4. Complete interpretation exercises throughout

**Estimated Time:** 45-60 minutes

---

## How to Use These Notebooks

### For Students

**Option 1: Click the "Open in Colab" Badge** (Easiest)
- Click the badge above each notebook
- Notebook opens directly in Google Colab
- No installation required!

**Option 2: From GitHub URL**
```
https://colab.research.google.com/github/shandley/evomics-colab-notebooks/blob/master/phylogenetics_tutorial.ipynb
```

**Option 3: Manual Upload**
- Download the `.ipynb` file
- Go to [colab.research.google.com](https://colab.research.google.com)
- Click "Upload" and select the file

### For Instructors/Developers

**Recommended: Local Conda Environment + Claude Code**

This allows you to develop and test notebooks locally with full tool support:

1. **Activate the environment:**
   ```bash
   conda activate phylo-dev
   ```

   Or use the helper script:
   ```bash
   source activate.sh
   ```

2. **Development with Claude Code:**
   - Claude edits notebooks
   - Tests locally with: `jupyter nbconvert --execute`
   - Sees errors and fixes autonomously
   - Commits and pushes when ready

3. **Final validation:**
   - Open in Colab from GitHub URL
   - Verify results match local execution

**Tools installed in conda environment:**
- Python 3.14
- MAFFT v7.526
- IQ-TREE v3.0.1
- All required Python packages

**For detailed workflows**, see [COMPLETE_WORKFLOW.md](COMPLETE_WORKFLOW.md).

### Running the Notebooks

1. **Sequential Execution:** Run cells in order from top to bottom
2. **Install Dependencies:** The first cells install required software (MAFFT, IQ-TREE, etc.)
3. **Example Data:** Each notebook includes example datasets to get started quickly
4. **Custom Data:** Upload your own data using the provided upload cells
5. **Exercises:** Complete interpretation exercises to reinforce learning

### Tips for Students

- Read the markdown cells carefully - they contain important context
- Don't skip the interpretation exercises - they're key to understanding
- Experiment! Try different parameters and see what happens
- Save your work regularly (File → Save a copy in Drive)
- Download results before closing the session

### Tips for Instructors

- Notebooks are designed for self-paced learning
- Can be used in workshops or as homework assignments
- Interpretation exercises can serve as discussion points
- Easy to modify for specific datasets or learning objectives
- All code is documented and educational

---

## Notebook Structure

Each notebook follows this general structure:

1. **Introduction & Learning Objectives**
2. **Environment Setup** (install tools and packages)
3. **Data Loading** (example data + option to upload custom data)
4. **Analysis Workflow** (step-by-step with explanations)
5. **Visualization** (publication-quality figures)
6. **Interpretation Exercises** (guided questions)
7. **Results Export** (download files for records)
8. **Conclusion & Further Resources**

---

## Computational Requirements

**Runtime:**
- All notebooks run on Google Colab's free tier
- No local installation required
- No GPU needed for current notebooks

**Storage:**
- Notebooks use minimal disk space (<100MB typically)
- Results can be downloaded and deleted after each session

---

## Planned Notebooks

Future tutorials under development:

- **Genome Assembly:** *De novo* assembly with SPAdes and quality assessment
- **RNA-seq Analysis:** Differential expression with DESeq2
- **Variant Calling:** SNP/indel detection from sequencing data
- **Metagenomics:** Community analysis with QIIME2
- **Comparative Genomics:** Genome comparison and synteny analysis
- **Protein Structure Prediction:** AlphaFold2 tutorial

---

## Contributing

Suggestions for new notebooks or improvements to existing ones are welcome!

**Contact:**
- Website: [learn.evomics.org](https://learn.evomics.org)
- GitHub: [Issues](https://github.com/[your-repo]/issues)

---

## Citations

When using these notebooks in publications or courses, please cite:

**Notebooks:**
- Evomics Google Colab Notebooks. Available at: [URL]

**Software used in notebooks:**
- **IQ-TREE:** Nguyen et al. (2015) IQ-TREE: A fast and effective stochastic algorithm for estimating maximum-likelihood phylogenies. Mol Biol Evol 32:268-274
- **MAFFT:** Katoh & Standley (2013) MAFFT multiple sequence alignment software version 7: improvements in performance and usability. Mol Biol Evol 30:772-780
- **Toytree:** Eaton (2020) Toytree: A minimalist tree visualization and manipulation library for Python. Methods Ecol Evol 11:187-191

---

## License

These educational materials are provided under [appropriate license - specify based on your needs].

---

## Acknowledgments

Developed for the Evomics workshops and learn.evomics.org educational platform.

**Support:** This work is supported by [funding sources if applicable].
