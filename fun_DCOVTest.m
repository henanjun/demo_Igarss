function [predict] = fun_DCOVTest(F_train,F_test,TrainCOV_ID_Form)
% 20110711 test function for DCOV

nTest_COV = size(F_test,2);
nTrain_COV = size(F_train,2);
predict = zeros(1,nTest_COV);

for i = 1:nTest_COV
    sample_i = F_test(:,i);
    res_m = repmat(sample_i,1,nTrain_COV)-F_train;
    res_v = sum(res_m.^2);
   [~,id(i)] = min(res_v); 
end
predict = TrainCOV_ID_Form(id);

