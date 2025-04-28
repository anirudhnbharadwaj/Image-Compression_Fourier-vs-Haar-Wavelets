function haarcoef = haar2dL(im,L)
% Uses the function haar2d.m to perform L-level Haar wavelet transform
% of the input image
%
% Inputs: 
%       im is a gray-scal eimage image
%       L is the number of levels of Haar transformation
% 
% Output: haarcoef is a 2D array of the same size as the input image with L
% levels of Haar coefficients arranged in the common convention of
% hierarchical arrangement of the approximation, horzonal, vertical, and
% diagonal coefficients at each level.
%
% Copyright Hassan Foroosh, 2021
%


haarcoef=zeros(size(im));

[H,W]=size(im);
if (2^L>H)||(2^L>W)
    disp('Number of levels too large')
    return;
end
a=im;
for i=1:L
    [a,h,v,d]=haar2d(a);
    haarcoef(1:H/2^i,W/2^i+1:W/2^(i-1))=h;
    haarcoef(H/2^i+1:H/2^(i-1),1:W/2^i)=v;
    haarcoef(H/2^i+1:H/2^(i-1),W/2^i+1:W/2^(i-1))=d;
end
    haarcoef(1:H/2^L,1:W/2^L)=a;

end