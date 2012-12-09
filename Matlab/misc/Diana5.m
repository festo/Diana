function [ image ] = Diana5( filename )

if nargin < 1
    display('Egy mappat var parameterkent!')
    return
end

%init
Rotated = false; % el van-e forgatva
percent_height = 0.1; %magassag levagas
percent_width = 0.4; %szelesseg levagas
se = strel('disk',25); % gomb sugara morfologiai muveleteknel

% kep betoltese
I = imread( filename );

%I = I(:,:,1); %R
%I = I(:,:,2); %G
I = I(:,:,3); %B

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
    
    Ihsv = rgb2hsv(I);
    Ihsv(:,:,1) = 0;
    
    %Irgb = I;
    %piros reteg
    Irgb = I(:,:,1);
    
    [morfIrgb, morfIrgb_simpsal, morfIrgb_bin] = morf(Irgb, custom_param, se);
    [morfIhsv, morfIhsv_simpsal, morfIhsv_bin] = morf(Ihsv, custom_param, se);
       
    maxMorf = morfIhsv_bin;
    maxMorf(:,:) = morfIhsv_bin(:,:)+morfIrgb_bin(:,:);
       
    image = maxMorf;
    
end