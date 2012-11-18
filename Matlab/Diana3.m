function [ mask, result_figure ] = Diana3( filename )

if nargin < 1
    display('A függvény egy paramétret vár!')
    return
end

%init
Rotated = false; % el van-e forgatva
percent_height = 0.1; %magassag levagas
percent_width = 0.4; %szelesseg levagas
se = strel('disk',25); % gomb sugara morfologiai muveleteknel

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
    
    Ihsv = rgb2hsv(I);
    Ihsv(:,:,1) = 0;
    
    Irgb = I;
    
    [morfIrgb, morfIrgb_simpsal, morfIrgb_bin] = morf(Irgb, custom_param, se);
    [morfIhsv, morfIhsv_simpsal, morfIhsv_bin] = morf(Ihsv, custom_param, se);
       
    maxMorf = morfIhsv_bin;
    maxMorf(:,:) = morfIhsv_bin(:,:)+morfIrgb_bin(:,:);
    
    result_figure = figure();
    
    subplot(5,2,1), imshow(I)
    title('Original RGB')
    
    
    subplot(5,2,3), imshow(morfIhsv)
    title('HSV (hue=0): morf> I-open(close(I))')
    
    subplot(5,2,4), imshow(morfIrgb)
    title('RGB: morf> I-open(close(I))')
    
    subplot(5,2,5), imshow(morfIhsv_simpsal)
    title('HSV (hue=0): simpsal> Itti algorithm')
    
    subplot(5,2,6), imshow(morfIrgb_simpsal)
    title('RGB: simpsal> Itti algorithm')
        
    subplot(5,2,7), imshow(morfIhsv_bin)
    title('HSV (hue=0): binarize> 0.5')  
    
    subplot(5,2,8), imshow(morfIrgb_bin)
    title('RGB: binarize> 0.5')
    
    subplot(5,2,9), imshow(maxMorf)
    title('RGB + HSV (hue=0)')
    
    mask = maxMorf;
    
end