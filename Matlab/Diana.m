function [ ] = Diana( filename )

if nargin < 1
    display('A függvény egy paramétret vár!')
    return
end

%init
Rotated = false;

% kep betoltese
I = imread( filename );


% Orientaltsag
[height width d] = size(I);
if height > width
    Rotated = true;
    I = imrotate(I,90);
end    

% structuring element
se = strel('disk',5);

I_opened = imopen(I,se);
I_closed = imclose(I_opened,se);
figure, imshow(I - I_closed)    

end