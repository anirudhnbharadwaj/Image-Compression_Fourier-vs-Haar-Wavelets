function out = ihaar2d(a,h,v,d)
% 
% Performs one level inverse Haar transform of an image 
%
% Inputs: 
%       a is the 2-D array containing the approximation coefficients of the image
%       h is the 2-D array containing the horizontal coefficients of the image
%       v is the 2-D array containing the vertical coefficients of the image
%       d is the 2-D array containing the diagonal coefficients of the image
% 
% Output: out is the output image
%
% Copyright Hassan Foroosh, 2020
%

    hmat=[0.7071    0.7071
          0.7071   -0.7071];

   haarim=zeros(2*size(a));
   haarim(1:2:end,1:2:end)=a;
   haarim(2:2:end,1:2:end)=h;
   haarim(1:2:end,2:2:end)=v;
   haarim(2:2:end,2:2:end)=d;
   out = ihaartrans(haarim, hmat);

end


% Construct the image by inverting the Haar transformation
function out = ihaartrans(haarim, hmat)
    
    % Use this if hmat matrix is not normalized:
    % invhaar       = @(x) inv(hmat)'*x*inv(hmat); 
    invhaar = @(x) hmat*x*hmat';
    [r,c] = size(haarim);
    cellhaarim = mat2cell( double(haarim) , 2*ones(1,r/2), 2*ones(1,c/2) );
    imagecells = cellfun(invhaar, cellhaarim , 'UniformOutput', false) ;
    out = cell2mat(imagecells);

end