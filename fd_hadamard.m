function [H_new,fd,I] = fd_hadamard(M,d)
%%  计算fd

% M = 4;    % 像素数
% d = 0.5;   % 可调参数d, 0.5和切蛋糕类似

H = hadamard(M*M);
fd = zeros(1,M*M);

for k = 1:M*M
    P_1M2 = H(k,1:M*M);
    
    P_MM = zeros(M,M);
    
    count = 1;
    for kk = 1:M
        P_MM(kk,1:M) = P_1M2(count:count+M-1);   % 取每个M，按照行的方式进行组合，自然序是按行排列的
        if kk ~= M
            count = M*kk+1;
        end
    end

%     P_MM = reshape(P_1M2,M,M);   % 取每个M，按照列的方式进行组合。从仿真结果上看，这两个是等价的。

    m = P_MM(2,:);   % 随意取一行
    n = P_MM(:,2);   % 随意取一列
    
    m_counts = 0;  %计算i值，看数值变化N次，则i=n+1
    m_now = m(1);  %先赋一个初值，看后来的是否和他相同
    for a = 2:M
        m_next = m(a);
        if m_next ~= m_now
            m_counts = m_counts+1;
        end
        m_now = m(a);
    end
    
    j = m_counts+1;
    
    n_counts = 0;  %计算j值，看数值变化N次，则j=n+1
    n_now = n(1);
    for a = 2:M
        n_next = n(a);
        if n_next ~= n_now
            n_counts = n_counts+1;
        end
        n_now = n(a);
    end
    
    i = n_counts+1;
    
    fd(k) = Fd(i,j,d);  % 从小到大排序
    
end

[Y,I]=sort(fd);  % 从小大大排序，Y是排序后的向量，I给出原来的位置
% 注意，fd中有相同的数目，可先按i从小到大，再按j从小到大，也可任意

%% Hadamard排序

H_new = zeros(M*M);
for k = 1:M*M
    H_new(k,:) = H(I(k),:);
end

%% 展示

figure
for k = 1:16
    subplot(4,4,k)
    P = reshape(H_new(k,:),M,M);
    imshow(P,[]),title(k)
    hold on
end

save('H_new.mat','H_new');
end










