function [ ] = DirDiana( directory )
    extensions = {'.jpg' '.jpeg'};
    files = dir( [directory '*' ]);
    for k = 1:numel(files)
        if ~files(k).isdir
            [pathstr, name, ext] = fileparts(files(k).name);
            lower(ext);
            if eq(max(ismember(extensions,ext)),1)
                img =  [directory files(k).name];
                Diana(img);
            end
        end    
    end

end

