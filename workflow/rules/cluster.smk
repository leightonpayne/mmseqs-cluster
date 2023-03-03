rule seqkit_rmdup:
    input:
        lambda wildcards: pep.sample_table.at[wildcards.protein, "file_path"],
    output:
        "results/fasta_filtered/{protein}.faa",
    log:
        "logs/seqkit_rmdup/{protein}.log",
    params:
        "--threads {params.threads}",
        "--by-seq",
        "--dup-num-file results/fasta_filtered/{protein}_seqkit_duplicates.txt",
        "--dup-seqs-file results/fasta_filtered/{protein}_seqkit_duplicates.faa",
    threads: config["seqkit_rmdup"]["threads"]
    wrapper:
        "https://raw.githubusercontent.com/leightonpayne/snakemake-wrappers/master/seqkit/rmdup/wrapper.py"


rule mmseqs_createdb:
    input:
        "results/fasta_filtered/{protein}.faa",
    output:
        "results/database_sequences/{protein}/{protein}.db",
    log:
        "logs/mmseqs_createdb/{protein}.log",
    conda:
        "../envs/mmseqs.yaml"
    shell:
        "mmseqs createdb {input} {output} &> {log}"


# Output merging is forced to simplify output while allowing utilization of
# multiple threads. i.e. MMSEQS_FORCE_MERGE=1
rule mmseqs_cluster:
    input:
        "results/database_sequences/{protein}/{protein}.db",
    output:
        "results/database_clusters/{protein}/{protein}_clu.db",
    log:
        "logs/mmseqs_cluster/{protein}.log",
    params:
        tmpdir="results/database_clusters/{protein}/tmp/",
        min_seq_id=config["mmseqs_cluster"]["min_seq_id"],
        coverage=config["mmseqs_cluster"]["coverage"],
        threads=config["mmseqs_cluster"]["threads"],
    threads: config["mmseqs_cluster"]["threads"]
    conda:
        "../envs/mmseqs.yaml"
    shell:
        """
        export MMSEQS_FORCE_MERGE=1
        mkdir -p {params.tmpdir}
        mmseqs cluster {input} {output} {params.tmpdir} \
        --min-seq-id {params.min_seq_id} \
        -c {params.coverage} \
        --threads {params.threads} &> {log}
        """


rule mmseqs_createtsv:
    input:
        database="results/database_sequences/{protein}/{protein}.db",
        cluster_database="results/database_clusters/{protein}/{protein}_clu.db",
    output:
        "results/clusters/{protein}/{protein}.tsv",
    log:
        "logs/mmseqs_createtsv/{protein}.log",
    conda:
        "../envs/mmseqs.yaml"
    shell:
        """
        mmseqs createtsv {input.database} {input.database} \
        {input.cluster_database} {output} &> {log}
        """


# Output merging is forced to simplify output while allowing utilization of
# multiple threads. i.e. MMSEQS_FORCE_MERGE=1
rule mmseqs_createseqfiledb:
    input:
        database="results/database_sequences/{protein}/{protein}.db",
        cluster_database="results/database_clusters/{protein}/{protein}_clu.db",
    output:
        cluster_sequences_database="results/database_clusters/{protein}/{protein}_clu_seq.db",
        cluster_sequences_database_index="results/database_clusters/{protein}/{protein}_clu_seq.db.index",
    log:
        "logs/mmseqs_createseqfiledb/{protein}.log",
    conda:
        "../envs/mmseqs.yaml"
    shell:
        """
        export MMSEQS_FORCE_MERGE=1
        mmseqs createseqfiledb {input.database} {input.cluster_database} {output.cluster_sequences_database} &> {log}
        """
