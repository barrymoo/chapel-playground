#!/usr/bin/env bash
#SBATCH --time=12:00:00
#SBATCH --job-name=hello
#SBATCH --output=hello.out
#SBATCH --nodes=2
#SBATCH --ntasks-per-node=28
#SBATCH --cluster=mpi

source /ihome/sam/bmooreii/src/chapel/util/setchplenv.bash
source ../chapel.sh

export HFI_NO_CPUAFFINITY=1

$SLURM_SUBMIT_DIR/hello --numLocales=$SLURM_NNODES --tasksPerLocale=$SLURM_NTASKS_PER_NODE
