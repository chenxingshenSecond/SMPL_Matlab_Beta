clc;
clear all;
close all;
filename= 'test_速度巨大_18_0.4胡克系数_0.01_visious.gif';    %你的gif文件的名字 
warning off; 
% % 
for i=1:5:1398 % 
    % Img=imread([num2str(i),'.bmp']);
    Img     = imread([ '1_' , num2str(i),'.bmp']); %% 
    delete( [ '1_' , num2str(i),'.bmp'] ) ;
    Img     = Img( 17:end , 1:end-17, :  ) ;
    [I,map] = rgb2ind(Img,256); %制作gif文件，图像必须是index索引图像
    k=i-0; % 
    if k==1;
        imwrite(I,map,filename,'gif','Loopcount',inf,...
            'DelayTime',0.1); % loopcount只是在i==1的时候才有用
    else
        imwrite(I,map,filename,'gif','WriteMode','append',...
            'DelayTime',0.1); % layTime用于设置gif文件的播放快慢
    end % 
end % 
close all ; 
clear all ; clc ; 
% % 
for i=1:1:1398 %  
    delete( [ '1_' , num2str(i),'.bmp'] ) ; % 
end