clear


%% 
M = 64; % 图像像素数64*64
d = -2; % 参数0.5

% [H_new,fd,I] = fd_hadamard(M,d);   % 运行一次产生排序即可

%% 成像
%将TVAL3加入路径
addpath('TVAL3');
%导入快速排序
load H_new.mat;
% H_new = hadamard(4096);%自然序列做比较
%导入图像
% img = double(imread('cameraman.tif'));
load OAM_img.mat
img = OAM_img*255;
% 调制像素为64*64
img = img(:,:,1);
img = imresize(img,[64,64]);
I0 = img;
img = img(:);

% TVAL3参数
opts.mu = 2^8;
opts.beta = 2^5;
opts.tol = 1E-3;
opts.maxit = 300;
opts.TVnorm = 1;
opts.nonneg = true;
%采样率
ratio = 0.2;     % 100%
%根据采样率调整采样矩阵个数
H_sub = H_new(1:round(ratio*M*M),:);
%全采样
f = H_new*img;
%根据采样率调整采样个数
f = f(1:round(ratio*M*M));
%重建
[object_re,~]=TVAL3(H_sub,f,M,M,opts);   
%展示图像
figure,imshow(object_re,[])
%计算PSNR
mse = MSE_diy(M,I0,object_re);
psnr = PSNR_diy(mse);
disp(['now the PSNR is: ',num2str(psnr)])

%%
function mse = MSE_diy(M,I0,I)
mse = I0-I;
mse = sum(mse(:))/(M*M);
end

function psnr = PSNR_diy(mse)
psnr = 10*log10(255*255/mse);
end