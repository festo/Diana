function [ image ] = Diana3( filename)

if nargin < 1
    display('A függvény egy paramétret vár!')
    return
end

%init
Rotated = false; % el van-e forgatva
percent_height = 0.1; %magassag levagas
percent_width = 0.4; %szelesseg levagas
se = strel('disk',15); % gomb sugara morfologiai muveleteknel

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

%I(1:cut_size,:,:) = 0;

Ihsw = rgb2hsv(I);
Irgb = I;
    morfIrgb = morf(Irgb,custom_param, se);
    morfIhsw = morf(Ihsw,custom_param, se);
       
    maxMorf = morfIhsw;
    maxMorf(:,:) = morfIhsw(:,:)+morfIrgb(:,:);
    
    STATS = regionprops(maxMorf, 'centroid');
    centroids = cat(1, STATS.Centroid);
    
    figure;
    subplot(4,1,1), imshow(I)
    title('Original')
    subplot(4,1,2), imshow(morfIhsw)
    title('HSW: Morf. operators, Saliency matrix, binarize ')
    subplot(4,1,3), imshow(morfIrgb)
    title('RGB: Morf. operators, Saliency matrix, binarize ')
    subplot(4,1,4), imshow(maxMorf)
    hold on
    plot(centroids(:,1), centroids(:,2), 'b*')
    hold off
    title('RGB + HSW')

end