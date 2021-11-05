#!/usr/bin/env nextflow
// Using DSL-2
nextflow.enable.dsl=2

process python_routine {
    container '/fh/scratch/delete90/gilbert_p/singularity/tcrdist3_v022.sif'

    input:
    path(tsv_file)

    output:
    path "*.head5.tsv"
    
    script:
    """
    ml Singularity
    python_routine.py --input_filename ${tsv_file} --output_tag .head5.tsv --sep \$'\t'
    """
}

process publish_me { 
    publishDir "${params.output_folder}", mode: 'copy', overwrite: true

    input:
    path(tsv_file)

    output:
    path(tsv_file)

    script:
    """
    echo ${tsv_file}
    """
}
