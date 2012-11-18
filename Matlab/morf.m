function [ image, mapbig, mapbig_bin ] = morf( I, param, se)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
    
    %morfologiai muveletek
    I_opened = imopen(I,se);
    I_closed = imclose(I_opened,se);

    %az eredeti kepbol kivonjuk a morfologiailag modositottat
    image = I - I_closed;

    map = simpsal (image, param);
    
    mapbig = mat2gray(imresize( map , [ size(image,1) size(image,2) ] ));
    nmapbig = zeros(size(mapbig));
    
    maxval = max(mapbig(:,:))
    
    nmapbig(:,:) = mapbig(:,:)/max(mapbig(:,:));
    
    
    %nmapbig = mapbig ./ max;
    
    %expmap = exp(nmapbig);
    %mapbig = expmap/max(expmap);
    %mapbig = nmapbig;
    mapbig_bin = im2bw(mapbig,0.5);

end

