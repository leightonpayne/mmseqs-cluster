<img src="https://avatars.githubusercontent.com/u/33450111?s=200&v=4" alt="Snakemake logo" title="Snakemake" align="right" height="96" width="96"/>

# mmseqs-cluster

[![Snakemake](https://img.shields.io/badge/snakemake-7.19.1-brightgreen.svg?style=flat)](https://snakemake.readthedocs.io)
![License](https://img.shields.io/badge/License-MIT-blue.svg)
[![Code style: snakefmt](https://img.shields.io/badge/code%20style-snakefmt-000000.svg)](https://github.com/snakemake/snakefmt)
[![CI](https://github.com/leightonpayne/mmseqs-cluster/actions/workflows/ci.yaml/badge.svg)](https://github.com/leightonpayne/mmseqs-cluster/actions/workflows/ci.yaml)

A Snakemake workflow to cluster proteins using MMseqs2.

## Installation

### Conda and Snakedeploy (recommended)

Install dependencies with conda:

```bash
# Install snakemake, snakedeploy, and eido in a new conda environment
conda create -c conda-forge -c bioconda --name snakemake snakemake snakedeploy eido
# Activate the environment
conda activate snakemake
```

Create a project directory for running the workflow:

```bash
mkdir -p mmseqs-cluster
cd mmseqs-cluster
```

Deploy a specific release (recommended):

```bash
# Check what releases are available (e.g. using the GitHub CLI or Subversion)
gh release list --repo leightonpayne/mmseqs-cluster
svn ls https://github.com/leightonpayne/mmseqs-cluster/tags/
```

```bash
snakedeploy deploy-workflow https://github.com/leightonpayne/mmseqs-cluster . --tag <RELEASE>
```

Deploy the development version (optional):

```bash
snakedeploy deploy-workflow https://github.com/leightonpayne/mmseqs-cluster . --branch master
```

## Configuration

This workflow uses the [PEP](https://pep.databio.org/en/latest/), or *Portable Encapsulated Projects* specification for defining input and recording metadata.

Read [`config/README.md`](https://github.com/leightonpayne/mmseqs-cluster/tree/master/config/README.md) for configuration instructions.

## Usage

To run the workflow, navigate to the base directory and run the command:

```bash
snakemake --cores all --use-conda
```


