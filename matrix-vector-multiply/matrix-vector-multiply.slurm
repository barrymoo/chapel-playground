#!/usr/bin/env bash
#SBATCH --time=12:00:00
#SBATCH --job-name=matrix-vector-multiply
#SBATCH --output=matrix-vector-multiply.out
#SBATCH --nodes=3
#SBATCH --ntasks-per-node=28
#SBATCH --cluster=mpi

#source /ihome/sam/bmooreii/src/chapel-1.15.0/util/setchplenv.bash
source /ihome/sam/bmooreii/src/chapel/util/setchplenv.bash
source ../chapel.sh

rm vis/*

export HFI_NO_CPUAFFINITY=1

$SLURM_SUBMIT_DIR/$SLURM_JOB_NAME \
    --numLocales=$SLURM_NNODES \
    --tasksPerLocale=$SLURM_NTASKS_PER_NODE
