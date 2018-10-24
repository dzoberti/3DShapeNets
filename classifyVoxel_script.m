path = '/home/rbevec/Downloads/ModelNet10/chair/test/chair_0892.off';
theta = 0;
volume = [24,24,24];
padding = [3,3,3];

cadFile = off_loader(path,theta);
voxelData = polygon2voxel(cadFile,volume,'auto');
voxelData = padarray(voxelData, padding);
voxelData = int8(voxelData);
plot3D(voxelData);
[labels, probs] = classifyVoxel(model, voxelData)




