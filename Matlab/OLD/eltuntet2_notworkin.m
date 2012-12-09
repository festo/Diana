function Kep = eltuntet2(Image, Mask)

%I = imread( Image );
%M = imread( Mask );

IB = I(:,:,3);
IR = I(:,:,1);
IG = I(:,:,2);

LIB = levag(IB, M);
LIR = levag(IR, M);
LIG = levag(IG, M);

figure, imshow(M)

OutB = roifill(LIB, M);
figure, imshow(OutB)
OutR = roifill(LIR, M);
figure, imshow(OutR)
OutG = roifill(LIG, M);
figure, imshow(OutG)

OutB = osszerak(IB, OutB, M);
OutR = osszerak(IR, OutR, M);
OutG = osszerak(IG, OutG, M);

RGB = cat(3, OutR, OutG, OutB);
figure, imshow(RGB)

Kep=RGB;

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