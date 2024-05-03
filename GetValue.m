function [value_fire,value_unfire]=GetValue(nearest_path,fireIndices,nonfireIndices)  %获取火点和非火点的值
for i=1:length(fireIndices)
    path_cel=nearest_path(i); %这是cell，需要转为字符串才能用于读取
    tif=geotiffread(path_cel{1});
    value_fire(i)=tif(fireIndices(i));
    value_unfire(i)=tif(nonfireIndices(i));
end
end

