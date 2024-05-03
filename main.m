clc;
clear;
close all;

% 获取文件夹里所有的tif文件，并形成列表
MCD_path = 'MCD64A1';
MCD_file_list = dir(fullfile(MCD_path,'*.tif'));
firelist=ones(1,3);
unfirelist=ones(1,3);
% 循环读取每个MCD tif文件
for i = 1:length(MCD_file_list)
    MCD_path_1 = fullfile(MCD_path, MCD_file_list(i).name);  %单个tif的路径
    MCD_data0 = geotiffread(MCD_path_1);      %读取图像
    radius=10; %火点附近的搜索半径
    [fireIndices,nonfireIndices]=Getpoints_index(MCD_data0,radius) ;%得到火点和非火点的索引
     nonfireIndices=nonfireIndices';
    for s=1:length(fireIndices)
        doylist_fire(s)=MCD_data0(fireIndices(s));   %将每个火点发生的DOY保存在一个列表中
    end
    mcd_year = MCD_file_list(i).name(1:4);   %读取年
    mcd_year = str2num(mcd_year);
    %得到每个着火点时间最近的FMC和FFL影像
    [nearest_path_fmc,nearest_doy_fmc]=Getnearest_FMC(mcd_year,doylist_fire) ;
    [nearest_path_ffl,nearest_doy_ffl]=Getnearest_FFL(mcd_year,doylist_fire) ;
    %提取值
    [value_fire_fmc,value_unfire_fmc]=GetValue(nearest_path_fmc,fireIndices,nonfireIndices);
    [value_fire_ffl,value_unfire_ffl]=GetValue(nearest_path_ffl,fireIndices,nonfireIndices); 
    %转置
    value_fire_fmc=value_fire_fmc';
    value_unfire_fmc=value_unfire_fmc';
    value_fire_ffl=value_fire_ffl';
    value_unfire_ffl=value_unfire_ffl';
    %建立标签
     label_fire= ones(length(fireIndices), 1);
     label_unfire=zeros(length(nonfireIndices), 1);
    %合并fmc、ffl和标签
    fire_temp = horzcat(value_fire_fmc, value_fire_ffl, label_fire);
    unfire_temp = horzcat(value_unfire_fmc, value_unfire_ffl, label_unfire);
    %加入到总表
    firelist=vertcat(firelist,fire_temp);
    unfirelist=vertcat(unfirelist,unfire_temp);
end

%指定保存路径，根据需要修改
file_path1 ="your file path\fire.txt";
file_path2 ="your file path\unfire.txt";
% 将数组保存为txt文件
dlmwrite(file_path1, firelist, 'delimiter', '\t');
dlmwrite(file_path2, unfirelist, 'delimiter', '\t');







