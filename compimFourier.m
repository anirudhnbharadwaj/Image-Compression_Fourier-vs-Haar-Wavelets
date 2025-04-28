function [snrvalue, outim] = compimFourier(im, compratio)

im = imresize(im, [256 256]);

transim = fft2(im);

% Find the magnitude and the phase angle of the Fourier coefficients
M = abs(transim); % Magnitude
P = angle(transim); % Phase angle
P = P(:);
tmp = M;

% Sort the Fourier coefficients in ascending order of their magnitude
% make sure you keep the sorting index in a variable, e.g. called indx
[stmp, indx] = sort(tmp(:), 'ascend');

% Get the cutoff position m for the given compression ratio
m = round((compratio-1)*numel(im)/compratio);
% Make all values below m equal to zero
stmp(1:m) = 0;

% Restore the original order of the Fourier coefficients
tmp = unsort(stmp, indx);

% Restore the compressed Fourier coefficients in real-imaginary format using tmp and P
tmp = reshape(tmp, size(transim)); % Reshape to original size
P = reshape(P, size(transim));
transim_compressed = tmp .* exp(1i * P); % Convert back to complex form

% Debug: Check size of transim_compressed
disp(['Size of transim_compressed before ifft2: ', num2str(size(transim_compressed))]);

% Inverse Fourier transform the compressed coefficients
% Take the real part, round, and cast as uint8
outim = uint8(round(real(ifft2(transim_compressed))));

% Calculate the SNR value for the compressed image
snrvalue = 10 * log10(sum(im(:).^2) / sum((im(:) - double(outim(:))).^2));

end