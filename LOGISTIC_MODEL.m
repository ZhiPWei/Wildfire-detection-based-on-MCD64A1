clc
clear
%输入fire.txt和unfire.txt的路径，根据需要更改
fireFilePath = "fire.txt";
unfireFilePath = "unfire.txt";
dataFire = importdata(fireFilePath);
dataUnfire = importdata(unfireFilePath);
m1 = length(dataFire);
m2 = length(dataUnfire);
if m1~=m2
    if m1>=m2
        dataFire = dataFire(randperm(m1, m2),:);
    else
        dataUnfire = dataUnfire(randperm(m2, m1),:);
    end
end

% -------------LR核心代码-------------
% 读入提取的火点处数据与非火点数据，火点处以1为标识，非火点以0为标识，列为最后一行。
data = [dataFire;dataUnfire]; 
%% 数据集分训练集和测试集
X = data(:,1:end-1);% 读取各因子数据
Y = data(:,end);% 读取是否发生火点（1/0）
[X_train, y_train,  X_test, y_test] = split_train_test(X,Y,2,0.7);%提取训练与测试集,2表示两个标签，0.7为70%数据用于训练
%% 训练数据集
[b,~,stats] = glmfit(X_train,y_train,'binomial','link','logit'); 
% b为最终LR模型回归系数
weights=b
yhat= glmval(b,X_test,'logit');
%% 验证数据集
[X,Y,T,AUC] = perfcurve(y_test,yhat,1);
% AUC出图
figure(1)
plot(X,Y)
xlabel('False positive rate')
ylabel('True positive rate')
title('ROC')
fprintf('AUC是%f',AUC);
%输出权重系数，保存为txt文件
file=['b.txt'];   %路径根据需要更改
dlmwrite(file,b,'-append','delimiter','\t','newline','pc','precision',10);