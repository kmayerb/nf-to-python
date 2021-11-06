# nf-to-python

Run a Python routine on many files using NextFlow to keep everything tidy and reproducible.

### Purpose 

Suppose you have a set of files that all need to be processed in the same way by a routine coded in Python tested to work well within a particular Docker container. Then, this nextflow template worksflow manages the parallel Python execution, allocating appropriate computing resources and ensuring the use of a reproducible environment (with specified singularity image). 

![Picture3](https://user-images.githubusercontent.com/46639063/140591322-d7502bf4-05d7-4dc3-9dfe-abc6e5070a22.png)


### Are you a Fred Hutch User? Then read here first:

These two key resources are required reading system specific configuration:

* [Running Workflows on Gizmo](https://sciwiki.fredhutch.org/hdc/workflows/running/on_gizmo/) - discusses the nextflow config
* [Workflow Run Scripts](https://sciwiki.fredhutch.org/hdc/workflows/running/run_script/) - discusses the run execution options needed to get singularity to play nicely.

### Execution using a bash run file

See the `run_script.sh`. For instance, in this case, the project specific variables are:

* `RESOURCES` - where your input files reside.
* `OUTPUT_FOLDER` - the destination for output files. 
* `CONTAINER` - the path to the Singularity image with the correct Python environment to execute bin/python_routine.py

### Reuse procedure

This is how I envision reusing this again and again.

1. Create a private repo with this as the template. 
2. Modify the README.md like a lab notebook.
3. Change the default `params.container__python` to the container you want to use
4. Change the `bin/python_routine.py` to be the python script your want to execute on each file.
5. If things get more complex modify the workflow.

### Singularity container from a Docker image

Commands to make a singularity container from a docker image downloadable form dockerhub or quay.io. Save this file to the scratch delete[90|30|10] directory since you won't need it forever. 

```bash
ml Singularity
singularity build ../../fh/scratch/delete90/gilbert_p/singularity/tcrdist3_v022.sif docker://quay.io/kmayerb/tcrdist3:0.2.2
```

#### Be kind, rewind

That is, if you know that you're never going to need the intermediate workflow products delete those files.

```bash
rm -rf /fh/scratch/delete30/gilbert_p/nextflow/work/*
```

### TODO

[x] Singularity config
* add nextflow.config option for slurm or awsbatch execution
* add example of programmatic testing of workflow and sub processes.

