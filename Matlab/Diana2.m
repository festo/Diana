function [ image ] = Diana2( filename )

if nargin < 1
    display('A függvény egy paramétret vár!')
    return
end

%init
Rotated = false; % el van-e forgatva
se = strel('disk',5); % gömb sugara morfologiai muveleteknel
percent = 0.20; %Az also hany szazalekot vizsgaljuk 

% kep betoltese
I = imread( filename );

%piros reteg
%I = I(:,:,1);

%zold reteg
%I = I(:,:,2);

%kek reteg
%I = I(:,:,3);

%I(:,:,3) = 0;

% Orientaltsag
[height width d] = size(I);
if height > width
    Rotated = true;
    I = imrotate(I,90);
end    

%vizsgalt terulet leszukitese
if Rotated
    cut_size = round(width * (1.0 - percent));
    max = width;
else
    cut_size = round(height * (1.0 - percent));
    max = height;
end
I = I(cut_size:max,:,:);
%I(1:cut_size,:,:) = 0;

%morfologiai muveletek
I_opened = imopen(I,se);
I_closed = imclose(I_opened,se);

%az eredeti kepbol kivonjuk a morfologiailag modositottat
image = I - I_closed;

%kep megjelenitese
%figure, imshow(image)

end