function [result] = eltuntet(I, M)

%I = imread( Image );
%M = imread( Mask );

IB = I(:,:,3);
IR = I(:,:,1);
IG = I(:,:,2);

LIB = levag(IB, M);
LIR = levag(IR, M);
LIG = levag(IG, M);

%figure, imshow(M)

%M2 = BM(M);
M2 = incMask(M, 3);
%figure, imshow(M2)

OutB = roifill(LIB, M2);
%figure, imshow(OutB)
OutR = roifill(LIR, M2);
%figure, imshow(OutR)
OutG = roifill(LIG, M2);
%figure, imshow(OutG)

OutB = osszerak(IB, OutB, M);
%figure, imshow(OutB)
OutR = osszerak(IR, OutR, M);
%figure, imshow(OutR)
OutG = osszerak(IG, OutG, M);
%figure, imshow(OutG)

RGB = cat(3, OutR, OutG, OutB);

result = RGB;

function M2 = BM(Mask)
[x y] = size(Mask);

%for k=1:x
%    for l=1:y
%        if Mask(k,l)<10
%            Mask(k,l) = 0;
%        end
%   end
%end

[rf1, cf1] = find(Mask, 1, 'first');
[cf2, rf2] = find(Mask', 1, 'first');

[rl1, cl1] = find(Mask, 1, 'last');
[cl2, rl2] = find(Mask', 1, 'last');

for i=rf2:rl2
    for j=cf1:cl1
        Mask(i,j) = 255;
    end
end

M2 = Mask;

function V = levag(Kep, M)

[x y] = size(M);
[height width] = size(Kep);

V = Kep((height-x+1):height,:,:);
V = V(:,(width-y+1):width,:);

function E = osszerak(Kep, Out, M)
[x y] = size(M);
[height width] = size(Kep);

Felso = Kep(1:height-x,:);
Also = Kep((height-x+1):height,:);
Also = Also(:, 1:width-y);
E = [Felso;Also Out];