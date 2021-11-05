# nf-to-python

Run a embarrassingly parallel Python routine on many files using NextFlow to keep everything tidy and reproducible.

### Purpose 

* Suppose you have a set of files that all need to be processed in the same way.
* Suppose you have some Python routine ( bin/python_routine.py ) that processes a single file
* Then, this NextFlow routine manages the embarrisingly parallel Python execution, allocating appropriate computing resources and ensuring the use of a reproducible environment (with specified docker or singularity container)

### Execution

```bash
NF_VER=21.04.1
NXF_VER=$NF_VER nextflow run main.nf \
    --resources path_to_input_files \
    --output_folder path_to_deposit_output \
    --container__python_container container_name \ 
    -resume
```

### Reuse Procedure

* Create a repo with this as the template
* Change the default params.container__python_container
* Change the bin/python_routine.py


### Singularity Container

Making a singularity container from a docker image/

```bash
ml Singularity
singularity build ../../ / /delete90/ /singularity/tcrdist3_v022.sif docker://quay.io/kmayerb/tcrdist3:0.2.2
```

### TODO

* Configure to work for singularity 
* add nextflow.config option for cluster or awsbatch execution
* add example of programmatic testing of workflow and sub processes.
