function [] = RGB( filename )

if nargin < 1
    display('Egy mappat var parameterkent!')
    return
end

%init
Rotated = false; % el van-e forgatva
percent_height = 0.1; %magassag levagas
percent_width = 0.4; %szelesseg levagas

% kep betoltese
I = imread( filename );


R = I(:,:,1);

G = I(:,:,2); %G

B = I(:,:,3); %B

% Orientaltsag
[height width d] = size(I);
if height > width
    Rotated = true;
    I = imrotate(I,90);
end   

Original = I;

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

R = R(cut_size_h:max_h,:,:);
R = R(:,cut_size_w:max_w,:);

G = G(cut_size_h:max_h,:,:);
G = G(:,cut_size_w:max_w,:);

B = B(cut_size_h:max_h,:,:);
B = B(:,cut_size_w:max_w,:);

%I(1:cut_size,:,:) = 0;
    
   
    result_figure = figure()
    
    subplot(2,2,1), imshow(I)
    title('Original RGB')

    subplot(2,2,2), imshow(R)
    title('Red')
    
    subplot(2,2,3), imshow(G)
    title('Green')
    
    subplot(2,2,4), imshow(B)
    title('Blue')
    
    print(result_figure, '\Users\laci\rgb.png', '-dpng')
        
end