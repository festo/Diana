function [ ] = Diana( filename )

if nargin < 1
    display('A függvény egy paramétret vár!')
    return
end

%init
Rotated = false;

% kep betoltese
I = imread( filename );

%kek reteg eltavolitasa
%I(:,:,3) = 0;

I_default = I;


% Orientaltsag
[height width d] = size(I);
if height > width
    Rotated = true;
    I = imrotate(I,90);
end    

% structuring element
se = strel('disk',5);

%morfologiai muveletek
I_opened = imopen(I,se);
I_closed = imclose(I_opened,se);

%az eredeti kepbol kivonjuk a morfologiailag modositottat
image = I_default - I_closed;

%kep megjelenitese
figure, imshow(image)    

end