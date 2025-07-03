#!/bin/bash

foamCleanTutorials

blockMesh

#transformPoints "scale=(100 100 100)"

checkMesh

decomposePar

#mpirun -np 4 renumberMesh -overwrite -parallel

mpirun -np 4 foamRun -parallel | tee log.solver

mpirun -np 4 foamPostProcess -func sampleDict -latestTime -parallel

gnuplot gnuplot/gnuplot_script
