function A=incMask(A, r)

[row, col] = size(A);
for i=row-r:row
    for j=1:col
        A(i, j) = 0;
    end
end

for i=1:row
    for j=col-r:col
        A(i,j) = 0;
    end
end

for i=1:r
    A=incByOne(A);
end




function A=incByOne(A)
    [rows, cols] = size(A);
    [r1, c1] = find(A);

    bal = (c1-1-1)*rows + r1;
    jobb = (c1-1+1)*rows + r1;

    fel = (c1-1)*rows + r1 -1;
    le = (c1-1)*rows + r1 +1;

    bal_fel = (c1-1-1)*rows + r1 -1;
    jobb_fel = (c1-1+1)*rows + r1 -1;

    bal_le = (c1-1-1)*rows + r1 +1;
    jobb_le = (c1-1+1)*rows + r1 +1;

    try
        A(bal) = 1;
    catch
    end

    try
        A(jobb) = 1;
    catch
    end

    try
        A(le) = 1;
    catch
    end

    try
        A(fel) = 1;
    catch
    end

    try
        A(bal_fel) = 1;
    catch
    end

    try
        A(jobb_fel) = 1;
    catch
    end

    try
        A(bal_le) = 1;
    catch
    end

    try
        A(jobb_le) = 1;
    catch
    end

    A;
