#!/bin/bash

foamCleanTutorials

blockMesh

checkMesh

#renumberMesh -overwrite

foamRun | tee log.solver

foamPostProcess -func sampleDict -latestTime

gnuplot gnuplot/gnuplot_script
