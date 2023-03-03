rule seqkit_rmdup:
    input:
        lambda wildcards: pep.sample_table.at[wildcards.protein, "file_path"],
    output:
        "results/fasta_filtered/{protein}/{protein}.faa",
    log:
        "logs/seqkit_rmdup/{protein}.log",
    params:
        extra="--by-seq --dup-num-file results/fasta_filtered/{protein}_seqkit_duplicates.txt --dup-seqs-file results/fasta_filtered/{protein}_seqkit_duplicates.faa",
    threads: config["seqkit_rmdup"]["threads"]
    wrapper:
        github("leightonpayne/snakemake-wrappers", path="seqkit/rmdup/wrapper.py")

