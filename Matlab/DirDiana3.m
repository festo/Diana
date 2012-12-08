function [ ] = DirDiana3( directory )
    extensions = {'.jpg' '.jpeg'};
    files = dir( [directory '*' ]);
    for k = 1:numel(files)
        if ~files(k).isdir
            [pathstr, name, ext] = fileparts(files(k).name);
            if eq(max(ismember(extensions,lower(ext))),1)
                img =  [directory files(k).name];
                %save =  [strcat(directory,'result/') strcat(pathstr, name)];
                %save_mask =  [strcat(directory,'mask/') files(k).name];

                [Original, mask] = Diana3(img);
                [result] = eltuntet(Original, mask);
                figure, imshow(result)
                %print(figure, save, '-dpng') ;
                %imwrite(mask, save_mask) ;

            end
        end    
    end

end

