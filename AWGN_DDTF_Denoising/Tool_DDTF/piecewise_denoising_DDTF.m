function denoised_img = piecewise_denoising_DDTF(sigma, noisy_img, labels, patchSize, filename)
%% Set parameter
[row,col] = size(noisy_img);
if strcmp(filename,'montage_texture')||strcmp(filename,'Emerald')
    par = parset_DDTF_textureimg(sigma, row);
else
    par = parset_DDTF_smoothimg(sigma, row);
end
%% Judge whether labels is a segmentation of image
[row_l, col_l]=size(labels);
if sum(sum(labels == round(labels)))~=row_l*col_l
    error('labels is not a segmentation of image. \n')
end
max_labels = max(max(labels));
denoised_img = zeros(row,col);
for i = 1:max_labels
    label = zeros(row,col);
    label(labels == i) = 1;
    [piece_img, learnt_dict] = Balanced_DDTF_denoising_piecewise(par, patchSize,noisy_img,label);
    denoised_img(label == 1) = piece_img(label == 1);
    fprintf('Piece %d is done. \n',i)
end
    
