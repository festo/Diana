function [ ] = cmp( filename )


Image1 = Diana(filename);
Image2 = Diana2(filename);

figure;
subplot(2,1,1);
imshow(Image1)
title('5 sugaru kor, HSW -H csatorna')

subplot(2,1,2);
imshow(Image2)
title('5 sugaru kor, RGB csatorna')

end

