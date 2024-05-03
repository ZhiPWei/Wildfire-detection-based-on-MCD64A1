function [nearest_path_fmc,nearest_doy_fmc]=Getnearest_FMC(mcd_year,doylist_fire) 
%获取文件路径并生成tif列表
FMC_path = 'FMC/all';
FMC_file_list = dir(fullfile(FMC_path,'*.tif'));
for i=1:length(doylist_fire)
    mcd_doy=doylist_fire(i);
      for j=1:length(FMC_file_list)
         FMC_path_1 = fullfile(FMC_path,  FMC_file_list(j).name);
         fmc_year =  FMC_file_list(j).name(1:4);
         fmc_year = str2num(fmc_year);
         fmc_doy = FMC_file_list(j).name(5:7);
         fmc_doy = str2num(fmc_doy);
        if mcd_year==fmc_year && mcd_doy>=fmc_doy
            temp_doy=fmc_doy;
            temp_path=FMC_path_1;
        end
      end
     nearest_path_fmc{i}=temp_path;
     nearest_doy_fmc(i)=temp_doy;
end
% nearest_doy_fmc=nearest_doy_fmc';
end