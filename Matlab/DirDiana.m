function [ ] = DirDiana( directory )

    files = dir( [directory '*' ]);
    for k = 1:numel(files)
        if ~files(k).isdir
            img =  [directory files(k).name];
            Diana(img);
        end    
    end

end

