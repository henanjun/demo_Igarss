
% Demo for IGARSS 2018 paper 'COVARIANCE MATRIX BASED FEATURE FUSION FOR REMOTELY SENSED SCENE CLASSIFICATION'
% written by Nanjun He (henanjun@hnu.edu.cn)
clear;clc;
%% load data
dataset_name = 'UCM21';
img_type = '*.tif';
rt_img_dir = ['D:\matlab_work_folder\classification\Scene_classification\Scene_data\',dataset_name,'\'];% replace it with your data set root
imdb = LoadData(rt_img_dir,img_type);
for i = 1:numel(imdb.allsamples_name)
    I = imread(imdb.allsamples_name{i});
    encoded_cov(:,:,i) = fun_GaborColorCov(I);
    fprintf('Processing:%d/%d\n',i,numel(imdb.allsamples_name));
end
label = imdb.label;
no_classes = 21;
train_number = ones(1,no_classes)*80;
for i = 1:10
    [train_SL,test_SL,test_number]= GenerateSample(label',train_number,no_classes);
    train_id = train_SL(1,:);
    train_label = train_SL(2,:);
    test_id = test_SL(1,:);
    test_label = test_SL(2,:);
    train_cov = encoded_cov(:,:,train_id);
    test_cov = encoded_cov(:,:,test_id);
    param.kernel = 'Log-E Gauss.';
    param.Beta = 2e-2;
    [ KMatrix_Train ] = LogE_Kernels(train_cov, train_cov, param);
    [ KMatrix_Test ] = LogE_Kernels(train_cov, test_cov, param);
    [eigvector, eigvalue] = fun_DCOVTrain(train_label, KMatrix_Train);
    Dim = no_classes - 1; %% the low dimensionality of LDA is c(#classes)-1
    alpha_matrix = eigvector(:,1:Dim);
    F_train = alpha_matrix'*KMatrix_Train;
    F_test = alpha_matrix'*KMatrix_Test;
    predict_label = fun_DCOVTest(F_train(1:Dim,:),F_test(1:Dim,:),train_label);
    [OA(i),Kappa,AA,CA(:,i), error_matrix(:,:,i)] = calcError(test_SL(2,:)'-1,predict_label'-1,[1:no_classes]);
end




