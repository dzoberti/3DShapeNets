param = []; param.nparticles = 50; param.earlyStop = false;  param.epochs = 50;
data_size = model.volume_size + 2 * model.pad_size;
old_TSDF = cubicle2col(gridDists, mult);
surface_num = sum((old_TSDF < 1 & old_TSDF > -1),1);
out_num = sum((old_TSDF == 1),1);
in_num = sum((old_TSDF == -1),1);

surface_index = (surface_num > 0 & in_num > 0 & out_num > 0) | surface_num > 1;
out_index = (out_num >= in_num) & ~surface_index;

old_TSDF = - ones([data_size,data_size,data_size], 'single');
old_TSDF(surface_index) = 1;
old_TSDF(out_index) = 0;
[original_entropy, completed_samples, prediction_o]= get_recognition_entropy(model, permute(old_TSDF,[3,1,2]), param);


test_data(1,:,:,:) = instance;
