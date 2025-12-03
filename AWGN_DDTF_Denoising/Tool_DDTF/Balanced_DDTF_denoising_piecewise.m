function [denoised_img_piece,learnt_dict] = Balanced_DDTF_denoising_piecewise(par,patchSize,noisy_img,label)
%UNTITLED2 此处显示有关此函数的摘要
%   此处显示详细说明
maxit=250;
D = dctmtx(patchSize);
D=kron(D,D);
D=D';
temp_img=zeros(size(noisy_img));
label_Data=im2col(label,[patchSize,patchSize],'sliding');
label_sum=sum(label_Data,1);
dilate = par.dilate;
lambda = par.lambda;
rho = par.rho;
a = par.a;
b = par.b;
for i = 1:dilate
  label=imdilate(label,[1,1,1;1,1,1;1,1,1]);
end
noisy_img=noisy_img.*label;
noisy_data=im2col(noisy_img,[patchSize,patchSize],'sliding');
index=label_sum<1;
noisy_data(:,index)=[];
% rperm 		= randperm(size(noisy_data, 2));
% noisy_data 	= noisy_data(:, rperm(1:ceil(0.5*size(noisy_data,2))));%optimal 0.3
Coef=D'*noisy_data;
denoised_img_piece=noisy_img;
for k=1:maxit
    if mod(k,50) == 0
        fprintf('Iteration %d. \n',k)
    end
    Data=im2col(denoised_img_piece,[patchSize,patchSize],'sliding');
    Data(:,index)=[];
    Coef=wthresh((D'*Data+a*Coef)/(1+a),'h',lambda/sqrt(1+a));
    temp_img=frame_denoising(denoised_img_piece,D,lambda);
    denoised_img_piece=(temp_img+rho*noisy_img)/(1+rho);
    Data=im2col(denoised_img_piece,[patchSize,patchSize],'sliding');
    Data(:,index)=[];
    [U, ~, V]=svd(Data*Coef');
    % temp_D=D;
    D=U*V'+b*D;
    img_comp=temp_img;
    temp_img=frame_denoising(denoised_img_piece,D,lambda);
    denoised_img_piece=(temp_img+rho*noisy_img)/(1+rho);
    if norm(img_comp-temp_img,'fro')<1e-2
        break
    end
end
denoised_img_piece=temp_img;
learnt_dict=D;
end
