function [nearest_path_ffl,nearest_doy_ffl]=Getnearest_FFL(mcd_year,doylist_fire) 
%获取文件路径并生成tif列表
FFL_path = 'FFL/all';
FFL_file_list = dir(fullfile(FFL_path,'*.tif'));
for i=1:length(doylist_fire)
    mcd_doy=doylist_fire(i);
     %遍历FFL寻找最接近日期
     for k=1:length(FFL_file_list)
        ffl_year =  FFL_file_list(k).name(5:8);
        ffl_year = str2num(ffl_year);
        ffl_doy=2*k-1;
        if ffl_doy>365
            ffl_doy=ffl_doy-366;
        end
        if mcd_year==ffl_year && mcd_doy>=ffl_doy
            temp_doy=ffl_doy;     %nearest_day_ffl是doy，找对应tiff时要反算索引。若为2014年就是它，若为2015年要加上366
            temp_path= fullfile(FFL_path,  FFL_file_list(k).name);
        end
     end    
     nearest_path_ffl{i}=temp_path;
     nearest_doy_ffl(i)=temp_doy;
end
end