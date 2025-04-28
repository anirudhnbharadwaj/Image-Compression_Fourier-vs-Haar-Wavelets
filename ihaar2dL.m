function outim = ihaar2dL(haarcoef,L)
% 
% Uses the function ihaar2d.m to perform L-level inverse Haar wavelet
% transform of the input image
%
% Inputs: 
%       haarcoef is a 2D array of the same size as the input image with L 
%       levels of Haar coefficients arranged in the common convention of 
%       hierarchical arrangement of the approximation, horzonal, vertical, 
%       and diagonal coefficients at each level.
%       L is the number of levels of inverse Haar transformation
% 
% Output:   
%       outim is a 2D gray-scale image resulting from the inverse
%       transformation
%
% Copyright Hassan Foroosh, 2021
%

[H,W]=size(haarcoef);
if (2^L>H)||(2^L>W)
    disp('Number of levels too large')
    exit;
end
for i=L:-1:1
    a=haarcoef(1:H/2^i,1:W/2^i);
    h=haarcoef(1:H/2^i,W/2^i+1:W/2^(i-1));
    v=haarcoef(H/2^i+1:H/2^(i-1),1:W/2^i);
    d=haarcoef(H/2^i+1:H/2^(i-1),W/2^i+1:W/2^(i-1));
    haarcoef(1:H/2^(i-1),1:W/2^(i-1)) = ihaar2d(a,h,v,d);
end
    outim=haarcoef;
end