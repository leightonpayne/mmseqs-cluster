# mmseqs-cluster

![License](https://img.shields.io/badge/License-MIT-blue.svg)
[![Snakemake](https://img.shields.io/badge/snakemake-7.19.1-brightgreen.svg?style=flat)](https://snakemake.readthedocs.io)
[![Code style: snakefmt](https://img.shields.io/badge/code%20style-snakefmt-000000.svg)](https://github.com/snakemake/snakefmt)

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

Deploy the workflow:

```bash
snakedeploy deploy-workflow https://github.com/leightonpayne/mmseqs-cluster .
```

## Configuration

This workflow uses the [PEP](https://pep.databio.org/en/latest/), or *Portable Encapsulated Projects* specification for defining input and recording metadata.

The paths to each input file need to be added to `config/input_metadata.csv`. The columns `protein_name` and `file_path` must be defined. An example is given to run the workflow on the test data provided.

## Usage

To run the workflow, navigate to the base directory and run the command:

```bash
snakemake --cores all --use-conda
```