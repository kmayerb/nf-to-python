# nf-to-python

Run a Python routine on many files using NextFlow to keep everything tidy and reproducible.

![Picture3](https://user-images.githubusercontent.com/46639063/140591322-d7502bf4-05d7-4dc3-9dfe-abc6e5070a22.png)

#### Purpose 

* Suppose you have a set of files that all need to be processed in the same way.
* Suppose you have some Python routine ( bin/python_routine.py ) that processes a single file
* Then, this NextFlow routine manages the embarrisingly parallel Python execution, allocating appropriate computing resources and ensuring the use of a reproducible environment (with specified docker or singularity container)

#### FRED HUTCH user? Read here first:

Here are two key resources for configuring a workflow using Singularity this to run with SLURM:
* [Running Workflows on Gizmo](https://sciwiki.fredhutch.org/hdc/workflows/running/on_gizmo/) - discusses the nextflow config
* [Workflow Run Scripts](https://sciwiki.fredhutch.org/hdc/workflows/running/run_script/) - discusses the run execution options needed to get singularity to play nicely.


#### Execution using a run file

see the run_script.sh

* RESOURCES - where your files live
* OUTPUT_FOLDER - where your outputs should go 
* CONTAINER - the path to the Singularity container with the correct python environment


#### Templates reuse procedure

This is how I envision reusing this again and again.

* Create a repo with this as the template
* Change the default params.container__python_container to the container you want to use
* Change the bin/python_routine.py to be the python script your want to execute on each file


#### Singularity container for a Docker image

Commands to make a singularity container from a docker image/ hosted on quay.io. Save this file to the scratch delete[90|30|10] directory since you won't need it forever. 

```bash
ml Singularity
singularity build ../../fh/scratch/delete90/gilbert_p/singularity/tcrdist3_v022.sif docker://quay.io/kmayerb/tcrdist3:0.2.2
```

#### Be kind, rewind

That is, if you know that you're never going to need the intermediate workflow products delete those files.

```
rm -rf /fh/scratch/delete30/gilbert_p/nextflow/work/*
```

### TODO

[x] Singularity config
* add nextflow.config option for cluster or awsbatch execution
* add example of programmatic testing of workflow and sub processes.

