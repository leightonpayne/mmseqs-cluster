# General settings

To configure this workflow, modify `config/config.yaml` according to your needs, following the parameter descriptions provided in that file.

# Samples (i.e. input)

Add samples (i.e. input) to `config/samples.csv`. Each row in `config/samples.csv` corresponds with a separate input file.

The columns `protein_name` and `file_path` must be defined, where: 
 - `protein_name` is an arbitrary name used to identify outputs.
 - `file_path` is the path to the mutifasta input file (absolute, or relative to the base directory of the workflow).

Any additional columns can be added to `config/samples.csv` for metadata tracking purposes.

# Example data

Example data is provided in the workflow repository under `.test/`.

If the workflow was deployed using `snakedeploy` this data can be retrieved using Subversion, or by visiting the repository and downloading the directory:

If you deployed a specific release run:

```bash
svn export https://github.com/leightonpayne/mmseqs-cluster/tags/<RELEASE>/.test/
```

If you deployed from the master branch:

```bash
svn export https://github.com/leightonpayne/mmseqs-cluster/branches/master/.test/
```

To run the workflow on the example data, simply run:

```bash
snakemake --cores all --use-conda
```

