function [ ] = DirDiana3( directory )
    extensions = {'.jpg' '.jpeg'};
    files = dir( [directory '*' ]);
    for k = 1:numel(files)
        if ~files(k).isdir
            [pathstr, name, ext] = fileparts(files(k).name);
            if eq(max(ismember(extensions,lower(ext))),1)
                img =  [directory files(k).name];
                disp(strcat(' Fajl beolvasva: ',img))
                tic; 
                
                [s,mess,messid] = mkdir(strcat(directory,'mask/'));
                [s,mess,messid] = mkdir(strcat(directory,'final/'));
                [s,mess,messid] = mkdir(strcat(directory,'cmp/'));
                
                save_mask =  [strcat(directory,'mask/') strcat(pathstr, name)];
                save_final =  [strcat(directory,'final/') files(k).name];
                save_cmp =  [strcat(directory,'cmp/') files(k).name];

                [result_figure, Original, mask] = Diana3(img);
                [result] = eltuntet(Original, mask);
                
                print(result_figure, save_mask, '-djpeg'); %mask eredmenyek
                
                
                cmp_figure = figure('Visible','Off');
    
                subplot(1,2,1), imshow(Original);
                title('Original');
                
                subplot(1,2,2), imshow(result);
                title('After inpainting');
    
                print(cmp_figure, save_cmp, '-djpeg'); %eredeti, retusalt egy kepen
                
                imwrite(result, save_final); %retusalt kep
                disp(strcat(' Eredmeny elmentve: ',save_final))
                TimeSpent = toc;
                disp(TimeSpent)
                disp('-------------')
                
            end
        end    
    end

end

