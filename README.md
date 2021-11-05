# nf-to-python

Run a Python routine on many files using NextFlow to keep everything tidy and reproducible.




### Purpose 

* Suppose you have a set of files that all need to be processed in the same way.
* Suppose you have some Python routine ( bin/python_routine.py ) that processes a single file
* Then, this NextFlow routine manages the embarrisingly parallel Python execution, allocating appropriate computing resources and ensuring the use of a reproducible environment (with specified docker or singularity container)


### FRED HUTCH USER? READ HERE FIRST:

Here are two key resources for configuring a workflow using Singularity this to run with SLURM:
* [Running Workflows on Gizmo](https://sciwiki.fredhutch.org/hdc/workflows/running/on_gizmo/) - discusses the nextflow config
* [Workflow Run Scripts](https://sciwiki.fredhutch.org/hdc/workflows/running/run_script/) - discusses the run execution options needed to get singularity to play nicely.


### Execution using a run file
```bash
#!/bin/bash
set -Eeuo pipefail
# Nextflow Version
NXF_VER=20.10.0
# Nextflow Configuration File
NXF_CONFIG=/home/kmayerbl/NextFlow/nf-to-python/nextflow.config
# Workflow to Run (e.g. GitHub repository)
WORKFLOW_REPO=kmayerb/nf-to-python
# Queue to use for exeution
QUEUE=campus-new
# Workflow-Specific Options
RESOURCES=/home/kmayerbl/NextFlow/nf-to-python/test_data/
OUTPUT_FOLDER=/fh/fast/gilbert_p/kmayerbl/nextflow_sink/
CONTAINER=/fh/scratch/delete90/gilbert_p/singularity/tcrdist3_v022.sif
# Load the Nextflow module (if running on rhino/gizmo)
ml Nextflow
# Load the Singularity module (if running on rhino/gizmo with Singularity)
ml Singularity
# Make sure that the singularity executables are in the PATH
export PATH=$SINGULARITYROOT/bin/:$PATH
# Run the workflow
NXF_VER=$NXF_VER \
nextflow \
    run \
    -c ${NXF_CONFIG} \
    ${WORKFLOW_REPO} \
    -r main \
    --container__python_container $CONTAINER \
    --resources $RESOURCES \
    --output_folder $OUTPUT_FOLDER \
    -process.queue $QUEUE \
    -with-report nextflow.report.html \
    -resume
```

### Reuse Procedure

* Create a repo with this as the template
* Change the default params.container__python_container to the container you want to use
* Change the bin/python_routine.py to be the python script your want to execute on each file


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
