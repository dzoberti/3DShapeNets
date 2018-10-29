# 3D ShapeNets: A Deep Representation for Volumetric Shapes
------------------------------------------------------------------------

## Introduction

- The code implements a Convolution Deep Belief Network in 3D and apply it for 2.5D depth object recognition, 3D shape completion, NBV selection and etc.
- To run the code, a CUDA supported GPU should be installed.
- The users should make sure the depth rendering function RenderMex is working properly. It depends on openGL. We suggest to add $MATLAB_HOME/sys/opengl/lib/glnxa64/libGL.so.1 to LD_LIBRARY_PATH.
- We have tested our code on Ubuntu 12.04 and 14.04, Matlab R2013a and after.
- You need to havelibosmesa6-dev or newer osmesa installed: ` sudo apt-get install libosmesa6-dev`
- Mex in Matlab with `mex RenderMex.cpp -lGLU -lOSMesa`, or `mex RenderMex.cpp  -L/opt/X11/lib/  -lOSMesa  -I/opt/X11/include/`

## Code

Training 3D ShapeNets involves a pretraining phase (run_pretrainin.m) and a finetuning phase (run_finetuning.m). Generative finetuning is time consuming and sometimes can just slightly improve the performance. You can probably ignore it.

Here is how the code is organized:

	1. The root folder contains interfaces for training and testing.
	2. The folder "generative" is for probablistic CDBN training.
	3. The folder "bp" does discriminative fine-tuning for 3D mesh classification and retrieval.
    4. We provide a 3D cuda convolution routine based on [cuda-convnet](https://code.google.com/p/cuda-convnet/) developed by Alex Krizhevsky. They are in kFunction.cu and kFunction2.cu.  
	5. The folder "3D" involves 3D computations like TSDF and Rendering.
	6. The folder "voxelization" is a toolbox to convert the mesh model to a volume representation. 
	

After training, the model could be powerful to do these tasks:

	1. 2.5D object recognition. Given a depth map of an object, infer the category.
	2. Shape completion. Given a depth map of an object, infer the full 3D shape.
	3. Next-best-view prediction. Compute the recognition uncertainties for the current view and decide the Next-Best-View and move the camera.
	4. Discriminative feature learning. Features for 3D meshes learned from volumes can be used for classification and retrieval.
	
## Models

We provide our generative 3D ShapeNets model as well as discriminative finetuned models which should produce the exact result for mesh classification and retrieval in the paper.

## Data

- The original off mesh data can be downloaded at [project page](http://3dshapenets.cs.princeton.edu).
- The input of 3D ShapeNets is volumetric shapes. One needs to convert the mesh representation into volumes. We provide a function utils/write_input_data.m to produce these volumes from meshes.
- We also precomputed some volumes with size 30 under the directory volumetric_data.

## Citing 3DShapeNets

If you use our code in your research, please consider citing:

	@inproceedings{Zhirong15CVPR,
        	Author = {Z. Wu, S. Song, A. Khosla, F. Yu, L. Zhang, X. Tang, J. Xiao},
        	Title = {3D ShapeNets: A Deep Representation for Volumetric Shapes},
        	Booktitle = {Computer Vision and Pattern Recognition},
        	Year = {2015}
	}

## Contact

Please email Zhirong Wu (xavibrowu@gmail.com) for problems and bugs. Thanks!

## Instructions:

1. Run the `setup_paths` script to add the required paths
2. Run the `kernels` script to add functions
3. Load a pretrained model from the mat files: discriminative_40_class.mat or generative_40_class.mat
4. Run `bp_test(model)` for discriminative models or `rec_test(model)` for generative.
5. As mentioned in the Data description, you are required to have a folder called volumetric_data in the 3DShapeNets root folder. In order to generate the required files, download the ModelNet10 and ModelNet40 data set with *.off* files. This is achieved by using this command (modify paths accordingly) `write_input_data('../../Downloads/ModelNet10', './volumetric_data', model.classnames, model.volume_size, model.pad_size, 30)`. `mex polygon2voxel_double.c -v` must be done beforehand.

### Usefull functions in voxelization folder
- `show3DModel(offobj.faces,offobj.vertices)` can visualize the off flies read with off_loader or other meshes in matlab format
- `polygon2voxel(offobj, [volume_size, volume_size, volume_size], 'auto')` transforms an off mesh file read with off_loader into a voxelized mesh
- `plot3D(Volume)` can visualize the voxelized meshes, like the ones in volumetric_data and created by polygon2voxel
- `sparse3D(M)` converts a voxelized mesh to a pointcloud format (Nx3)

### Usefull functions in util
- beforementioned write_input_data
- possibly some functions to visualize intermediate layers
- several functions for batch processing

### Usefull functions in 3D
- `off_loader()` reads an off file and rotates by theta around z
- other functions for next veiw, joining point clouds and other

### Usefull functions in bp
- 

