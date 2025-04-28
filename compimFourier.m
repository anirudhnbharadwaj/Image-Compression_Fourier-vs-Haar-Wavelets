function [snrvalue, outim] = compimFourier(im,compratio)

im=imresize(im,[256 256]);

transim=fft2(im);

% Find the magnitude and the phase angle of the Fourier coefficients
M=
P=
P=P(:);
tmp=M;
% Sort the Fourier coefficients in ascending order of their magnitude
% make sure you keep the sorting index in a variable, e.g. called indx

% Get the cuttoff position m for the given compression ratio
m=round((compratio-1)*numel(im)/compratio);
% make all values below m equal to zero

% Restore the original order of the Fourier coefficients
tmp=unsort(stmp,indx);
% Restore the compressed Fourier coefficients in real-imaginary format using tmp and P

% Rashape the compressed coefficients in original image size

% Inverse Fourier transform the compressed cefficients 
% make sure you take the real part, round, and then cast as uint8
outim=
% Calculate the SNR value for the compressed image
snrvalue=
    
end

