function [eigvector, eigvalue, elapse] = fun_DCOVTrain(gnd,data)
  %%% 20140828 This KLDA code is from Dr. Deng Cai (courtesy) at http://www.cad.zju.edu.cn/home/dengcai/


options.Regu = 0.001;
K = data;
clear data;
K = max(K,K');

% ====== Initialization
nSmp = size(K,1);
if length(gnd) ~= nSmp
    error('gnd and data mismatch!');
end

classLabel = unique(gnd);
nClass = length(classLabel);
Dim = nClass - 1;

K_orig = K;

sumK = sum(K,2);
H = repmat(sumK./nSmp,1,nSmp);
K = K - H - H' + sum(sumK)/(nSmp^2);
K = max(K,K');
clear H;

%======================================
% SVD
%======================================

Hb = zeros(nClass,nSmp);
for i = 1:nClass
    index = find(gnd==classLabel(i));
    classMean = mean(K(index,:),1);
    Hb (i,:) = sqrt(length(index))*classMean;
end
B = Hb'*Hb;
T = K*K;

for i=1:size(T,1)
    T(i,i) = T(i,i) + options.Regu;
end

B = double(B);
T = double(T);

B = max(B,B');
T = max(T,T');

option = struct('disp',0);
[eigvector, eigvalue] = eigs(B,T, Dim,'la', option);

% aul_S = inv(T)*B;
% aul_S = max(aul_S, aul_S');
% [eigvector, eigvalue] = eigs(aul_S, Dim,'la');


eigvalue = diag(eigvalue);

  
tmpNorm = sqrt(sum((eigvector'*K_orig).*eigvector',2));
eigvector = eigvector./repmat(tmpNorm',size(eigvector,1),1); 
