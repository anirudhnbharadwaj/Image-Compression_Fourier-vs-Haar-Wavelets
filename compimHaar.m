function [snrvalue, outim] = compimHaar(im,compratio)

im=imresize(im,[256 256]);

transim=haar2dL(im,8);

tmp=transim;
% Find all negative values in tmp for undoing the absolute value operation later

% Sort the Haar coefficients in ascending order of their absolute value
% make sure you keep the sorting index returned by matlab (e.g. in a variable called indx)

% Get the cuttoff position thresh for the given compression ratio
m=round((compratio-1)*numel(im)/compratio);
% make all values below m equal to zero
stmp=
% Restore the original order of the Haar coefficients
tmp=unsort(stmp,indx);
% Undo absolute value

% Rashape the compressed coefficients in original image size

% Inverse Haar transform the compressed cefficients
outim = uint8(round(ihaar2dL(tmp,8)));
% Calculate the SNR value for the compressed image
snrvalue=
    
end

