function [labels, probabilities] = classifyVoxel(model, voxel_mesh)

% model is the pretrained neural network model
% voxel_mesh is a NxNxN voxel description of 1s and 0s, where N =
% model.volume_size + 2 x model.pad_size
% It returns a vector of labels, probabilities


input_shape(1,:,:,:) = voxel_mesh;
[model, activation] = bp_forward(model, input_shape);

%[val, idx] = max(activation{end});
[val, idx] = sort(activation{end}, 'descend');

% return the top 3 labels and probs
labels = {idx(1), model.classnames{idx(1)}; idx(2) , model.classnames{idx(2)}; idx(3), model.classnames{idx(3)}};
probabilities = val(1:3)';
