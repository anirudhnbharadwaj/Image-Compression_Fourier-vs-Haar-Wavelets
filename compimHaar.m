function [snrvalue, outim] = compimHaar(im, compratio)

im = imresize(im, [256 256]);

transim = haar2dL(im, 6);

tmp = transim;
% Find all negative values in tmp for undoing the absolute value operation later
neg_mask = tmp < 0; % neg_mask is [256, 256]

% Sort the Haar coefficients in ascending order of their absolute value
% make sure you keep the sorting index returned by matlab (e.g. in a variable called indx)
[stmp, indx] = sort(abs(tmp(:)), 'ascend'); % tmp(:) flattens to [65536, 1]

% Get the cutoff position thresh for the given compression ratio
m = round((compratio-1)*numel(im)/compratio);
% make all values below m equal to zero
stmp(1:m) = 0;

% Restore the original order of the Haar coefficients
tmp = unsort(stmp, indx); % tmp is [65536, 1]

% Reshape tmp back to the original 2D size
tmp = reshape(tmp, [256, 256]); % Reshape to [256, 256]

% Undo absolute value using the original neg_mask
tmp(neg_mask) = -tmp(neg_mask); % Now applies correctly on 2D array

% Debug: Check size of tmp
disp(['Size of tmp before ihaar2dL: ', num2str(size(tmp))]);

% Inverse Haar transform the compressed coefficients
outim = uint8(round(ihaar2dL(tmp, 6)));

% Calculate the SNR value for the compressed image
snrvalue = 10 * log10(sum(im(:).^2) / sum((im(:) - double(outim(:))).^2));

end