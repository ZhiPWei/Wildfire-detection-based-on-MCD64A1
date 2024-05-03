clc
clear
%����fire.txt��unfire.txt��·����������Ҫ����
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

% -------------LR���Ĵ���-------------
% ������ȡ�Ļ�㴦������ǻ�����ݣ���㴦��1Ϊ��ʶ���ǻ����0Ϊ��ʶ����Ϊ���һ�С�
data = [dataFire;dataUnfire]; 
%% ���ݼ���ѵ�����Ͳ��Լ�
X = data(:,1:end-1);% ��ȡ����������
Y = data(:,end);% ��ȡ�Ƿ�����㣨1/0��
[X_train, y_train,  X_test, y_test] = split_train_test(X,Y,2,0.7);%��ȡѵ������Լ�,2��ʾ������ǩ��0.7Ϊ70%��������ѵ��
%% ѵ�����ݼ�
[b,~,stats] = glmfit(X_train,y_train,'binomial','link','logit'); 
% bΪ����LRģ�ͻع�ϵ��
weights=b
yhat= glmval(b,X_test,'logit');
%% ��֤���ݼ�
[X,Y,T,AUC] = perfcurve(y_test,yhat,1);
% AUC��ͼ
figure(1)
plot(X,Y)
xlabel('False positive rate')
ylabel('True positive rate')
title('ROC')
fprintf('AUC��%f',AUC);
%���Ȩ��ϵ��������Ϊtxt�ļ�
file=['b.txt'];   %·��������Ҫ����
dlmwrite(file,b,'-append','delimiter','\t','newline','pc','precision',10);