function [ image ] = Diana( filename, param )

if nargin < 1
    display('A függvény egy paramétret vár!')
    return
end

%init
Rotated = false; % el van-e forgatva
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

Ihsw = rgb2hsv(I);
Irgb = I;
    morfIrgb = morf(Irgb,param);
    morfIhsw = morf(Ihsw,param);
    
    i_size = size(morfIhsw)
    %size(morfIrgb)
    maxMorf = morfIhsw;
    
    for i=1:i_size(1)
        for j=1:i_size(2)
            maxMorf(i,j) = max(morfIhsw(i,j),morfIrgb(i,j))
        end;
    end;
    
    subplot(4,1,1), imshow(I)
    subplot(4,1,2), imshow(morfIhsw)
    subplot(4,1,3), imshow(morfIrgb)
    subplot(4,1,4), imshow(maxMorf)

end