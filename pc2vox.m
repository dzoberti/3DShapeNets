function [ Volume ] = pc2vox( ptCloud, VolumeSize, pad_size )
%PC2VOX Summary of this function goes here
%   Detailed explanation goes here


%This is equivalent to auto mode
%Find the maximum dimension of the cloud for normalization

largestDistance = max(ptCloud.Location) - min(ptCloud.Location);
% these are also already given in the Limits
% largestDistance = [...
%     ptCloud.XLimits(2)-ptCloud.XLimits(1),...
%     ptCloud.YLimits(2)-ptCloud.YLimits(1),...
%     ptCloud.ZLimits(2)-ptCloud.ZLimits(1)];

%largest distance must fit in VolumeSize (which in an integer)
normalizationFactor = (VolumeSize-1) / max(largestDistance);

centerOffset =  largestDistance/2 + min(ptCloud.Location);

normalizedCenteredLocation = (ptCloud.Location - centerOffset) .* normalizationFactor + [VolumeSize/2 VolumeSize/2 VolumeSize/2];

instance = zeros(VolumeSize, VolumeSize, VolumeSize);

for i=1:size(normalizedCenteredLocation,1)
    coordinates = normalizedCenteredLocation(i,:);
    coordinates = ceil(coordinates);
    instance(coordinates(1), coordinates(2), coordinates(3)) = 1;
end

instance = padarray(instance, [pad_size, pad_size, pad_size]);
Volume = int8(instance);

end

