clear all;close all;clc
addpath('./Tool_DDTF/');
%% Parameter setting of image denoising
sigma     	= 50;                            			% noise level
patchSize 	= 16; 										% patch size
%% Generate simulated noisy image
fileName  	= 'montage_texture';
tail='.png';
clear_img 	= imread(sprintf('%s%s',fileName,tail)); 				% read image   
load(sprintf('%s_seg.mat',fileName));
PSNR = [];
randn('seed',0); rand('seed',0)
[h, w] 	  	= size(clear_img);  						% image size
noisy_img 	= imnoise(clear_img,'gaussian',0,(sigma/255)^2); 	% add noise
PSNRinput 	= psnr(noisy_img,clear_img); 				% PSNR of noisy image
noisy_img=double(noisy_img);

tic;

%% Denoising image by using the tight frame
im_out_piece = piecewise_denoising_DDTF(sigma, noisy_img,labels, patchSize, fileName);
PSNRoutput_piece=psnr(uint8(round(im_out_piece)),clear_img);
toc;

%% Save the results
imwrite(uint8(im_out_ddtf),sprintf('%s_ddtf_%d_%.4f.png',fileName,sigma,PSNRoutput_ddtf))
imwrite(uint8(im_out_piece),sprintf('%s_piecewise_%d_%.4f.png',fileName,sigma,PSNRoutput_piece))

