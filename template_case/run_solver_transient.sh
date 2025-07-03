#!/bin/bash

foamCleanTutorials
cd ../wingMotion2D_transient
cp -R ../wingMotion2D_steady/constant/polyMesh constant
mapFields ../wingMotion2D_steady -sourceTime latestTime -consistent | tee log.mapFields_transient
cp pointDisplacement 0/pointDisplacement
decomposePar | tee log.decomposePar_transient
mpirun -np 8 renumberMesh -overwrite -parallel | tee log.renumberMesh_transient
mpirun -np 8 foamRun -solver incompressibleFluid -parallel | tee log.solver_transient
reconstructPar -latestTime | tee log.reconstructPar_transient
rm -rf process*
paraFoam -builtin

postProcessing -func vorticity
postProcessing -func flowType -time 200
postProcessing -func "components(U)"
postProcessing -func "add(Ux, Uy, Uz)"
postProcessing -func "grad(p)"
