function [a,h,v,d] = haar2d(im)
% 
% Performs one level Haar transform of an image 
%
% Input: 
%       im: is a gray-scale image
% 
% Outputs: 
%       a is the 2-D array containing the approximation coefficients of the
%       input image
%       h is the 2-D array containing the horizontal coefficients of the
%       input image
%       v is the 2-D array containing the vertical coefficients of the
%       input image
%       d is the 2-D array containing the diagonal coefficients of the
%       input image
%
% Copyright Hassan Foroosh, 2020
%

im=double(im);

    hmat=[0.7071    0.7071
       0.7071   -0.7071];

    haarimage = haartrans(im, hmat);
    a=haarimage(1:2:end,1:2:end);
    h=haarimage(2:2:end,1:2:end);
    v=haarimage(1:2:end,2:2:end);
    d=haarimage(2:2:end,2:2:end);

end


% Function to calculate the 2D haar transform
function haarimage = haartrans(im, hmat)

    haar = @(x) hmat'*x*hmat;
    [r,c] = size(im);

    % Divide the input image into cell arrays of NxN (e.g. N=2)
    cellim   = mat2cell( double(im) , 2*ones(1,r/2), 2*ones(1,c/2) );

    % Apply Haar transform to each NxN cell
    haarcells = cellfun(haar, cellim , 'UniformOutput', false) ;

    % Construct the Haar matrix from the Haar cell arrays
    haarimage = cell2mat(haarcells) ;

end
