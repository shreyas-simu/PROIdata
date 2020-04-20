# PROIdata
This folder contains PROI extracted and segmented images as well as ground truth images

Contains MATLAB file for extraction of PROI from hand radiograph. 

Each subfolder (Number denotes the corresponding image from IPILAB dataset) contains extracted data, segmented images and ground truth images. If not the data will be in .mat files where variables stand for:
Z - extracted image from hand radiograph.
S - Ground truth image. 

Each folder also contains results of segmentation using various techniques. Including our method.

Otsu - Otsu method
kmeans - kmeans algorithm
PSO - Particle Swarm optimization algorithm 
BFV - BFV algorithm
ARKFCM - ARKFCM algorithm 
KGRF - Kmeans and gibbs random fields algorithm 
GT- Ground Truth
level - our method

Cite the paper:
Simu, Shreyas, et al. "Fully automatic segmentation of phalanges from hand radiographs for bone age assessment." Computer Methods in Biomechanics and Biomedical Engineering: Imaging & Visualization 7.1 (2019): 59-87.
