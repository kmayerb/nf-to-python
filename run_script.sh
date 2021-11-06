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
    -profile cluster \
    ${WORKFLOW_REPO} \
    -r main \
    --container__python_container $CONTAINER \
    --resources $RESOURCES \
    --output_folder $OUTPUT_FOLDER \
    -process.queue $QUEUE \
    -with-report nextflow.report.html \
    -resume
