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

I;


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
image = I - I_closed;

%kep megjelenitese
%figure, imshow(image)  

edge1 = 50;
edge2 = 100;

image_gray_original = rgb2gray(image);
image_gray = image_gray_original;
image_gray(image_gray<edge1) = 0;
image_gray(image_gray>edge2) = 0;

%imhist(image_gray) ;

figure, imshow(image_gray)
%figure, imshow(image_gray_original);

end