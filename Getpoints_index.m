function [fireIndices,nonfireIndices]=Getpoints_index(MCD_data0,searchRadius)   %输入MCD图像和搜索半径r
MCD_data = MCD_data0;  
MCD_data(MCD_data0>0) = 1;              % 筛选出火点区域（>0）  
MCD_data(MCD_data0<=0) = 0;             % 确保非火点区域为0  
[rows, cols] = size(MCD_data);   
% 找到所有着火点的线性索引  
fireIndices = find(MCD_data == 1);  
  
% 遍历每个着火点  
for i = 1:length(fireIndices)  
    % 获取当前着火点的坐标  
    [y, x] = ind2sub(size(MCD_data), fireIndices(i));  %y是行，x是列
      
    % 定义一个搜索区域（假设图像足够大，不会超出边界）  
    minY = max(1, y - searchRadius);  
    maxY = min(rows, y + searchRadius);  
    minX = max(1, x - searchRadius);  
    maxX = min(cols, x + searchRadius);  
      
    % 提取搜索区域内的像素值  
    searchArea = MCD_data0(minY:maxY, minX:maxX);  
      
    % 查找搜索区域内的非着火点（值为0的像素）  
    [nonFireY, nonFireX] = find(searchArea == 0);
      
    % 如果搜索区域内存在非着火点，则随机选择一个  
    if ~isempty(nonFireY)  
     % 从非着火点中随机选择一个索引  
    randomIndex = randi(length(nonFireY));   
     % 获取随机索引对应的线性索引，注意这个索引是在searchArea下，不是MCD下的索引。因此作线性转换
    nonfireIndices(i) = sub2ind(size(MCD_data0), nonFireY(randomIndex)+minY-1, nonFireX(randomIndex)+minX-1);
    end  
end  
end