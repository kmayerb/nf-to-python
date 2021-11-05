#!/usr/bin/env nextflow

// November 5, 2021

// Embarrisingly parallel Python data cleaning 
// operations run using NextFlow DSL2
// to manage computing resources, caching, 
// environment (with a singularity container)

// We use NextFlow to run any Python code on as many files as you like

// Reminder to set NextFlow version at runtime: 
//NF_VER=21.04.1
//NXF_VER=$NF_VER nextflow run main.nf -resume

//Using DSL-2
nextflow.enable.dsl=2

// params
params.resources     = './test_data/'
params.output_folder = './test_data/test_output_folder/'
// containers
params.container__python_container = '/fh/scratch/delete90/gilbert_p/singularity/tcrdist3_v022.sif'

// import processes

// head_5_pandas, is our python process
include { python_routine } from './modules/processes' 
// publish_me is process that takes any input file and publishes it to params.output_folder
include { publish_me } from './modules/processes'

// workflow 
workflow {
    // Check that params were supplied
    if(params.resources == false || params.output_folder == false ){
        exit 1
    }
    // all .tsv files in resources will be read
    tsv_channel = Channel.fromPath("${params.resources}/*.tsv")
    // first run any executable Python file in bin/python_routine.py
    python_routine(tsv_channel)
    // publishe the output
    publish_me(python_routine.out)
}    
