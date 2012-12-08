function [ ] = cmp( filename )


Image1 = Diana(filename);
Image2 = Diana2(filename);

%init
Rotated = false; % el van-e forgatva
percent_height = 0.1; %magassag levagas
percent_width = 0.4; %szelesseg levagas
se = strel('disk',25); % gomb sugara morfologiai muveleteknel

% kep betoltese
I = imread( filename );

%I = I(:,:,1); %R
%I = I(:,:,2); %G
%I = I(:,:,3); %B

% Orientaltsag
[height width d] = size(I);
if height > width
    Rotated = true;
    I = imrotate(I,90);
end    

%vizsgalt terulet leszukitese
if Rotated
    cut_size_h = round(width * (1.0 - percent_height));
    cut_size_w = round(height * (1.0 - percent_width));
    max_h = width;
    max_w = height;
else
    cut_size_h = round(height * (1.0 - percent_height));
    cut_size_w = round(width * (1.0 - percent_width));
    max_h = height;
    max_w = width;
end

I = I(cut_size_h:max_h,:,:);
I = I(:,cut_size_w:max_w,:);

figure;

subplot(4,1,1);
imshow(I)
title('Eredeti RGB')

subplot(4,1,2);
imshow(Image1)
title('Mask RGB (Csak R)')

subplot(4,1,3);
imshow(Image2)
title('Mask RGB (Csak G)')

subplot(4,1,4);
imshow(Image2)
title('Mask RGB (Csak B)')

end

