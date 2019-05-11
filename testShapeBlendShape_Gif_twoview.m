
clc 
% test
close all; clc ; clear all; 
addpath(genpath(cd))
% obj = readObj('smpl_np-norm.obj');
faces      = csvread('faces.csv'); 
T_mean      = csvread('v_template.csv'); 
weights     = csvread('weights.csv'); 
Beta_Model  = csvread('shapedirs.csv'); % shapedirs.csv 
J_regressor = csvread('J_regressor.csv'); % shapedirs.csv 
kintree_table = csvread('kintree_table.csv'); 
kintree_table(1) = 28; 
% 
Joints = J_regressor * T_mean ; 
%% 
Theta = zeros(25,3); 
Beta  = ones(10,1) * 4; 

[mesh1 , Joints1] = updateSmplModelswithBeta(Theta,Beta,T_mean,kintree_table,J_regressor,weights,Beta_Model); 

Theta = rand(25,3)* 0.001; 
figure('color',[1 1 1]); 
y = input('放大图形Figure') ; 
%% 
for i = 1:10
    Beta = Beta * 0; 
    filename= [num2str(i),'_view2.gif']; %你的gif文件的名字 
    iter = 0 ; 
    for j = -6:6 
        Beta(i) = j ; % 
        iter = iter + 1; 
        [mesh2 , Joints2] = updateSmplModelswithBeta(Theta,Beta,T_mean,kintree_table,J_regressor,weights,Beta_Model);
        % plot3(Joints2(:,1),Joints2(:,2),Joints2(:,3),'bo'); hold on;  
        subplot(121); 
        trisurf(faces+1,mesh2(:,1),mesh2(:,2),mesh2(:,3),'edgecolor','black');% plot3(mesh2(:,1),mesh2(:,2),mesh2(:,3),'bo');
        text(0.2,-0.8,0.0,['The ',num2str(i),'th Beta = ', num2str(j) ]) ; 
        axis equal ; axis vis3d ; daspect([1 1 1]); view([0 0 1]); camup([0 1 0])
        subplot(122); 
        trisurf(faces+1,mesh2(:,1),mesh2(:,2),mesh2(:,3),'edgecolor','black');% plot3(mesh2(:,1),mesh2(:,2),mesh2(:,3),'bo');
        text(0.2,-0.8,0.0,['The ',num2str(i),'th Beta = ', num2str(j) ]) ; 
        axis equal ; axis vis3d ; daspect([1 1 1]); view([1 0 0]); camup([0 1 0])
        drawnow; 
        hold off;
        
        frame=getframe();
        im=frame2im(frame);%制作gif文件，图像必须是index索引图像
        [I,map]=rgb2ind(im,256);
        if iter==1;
            imwrite(I,map,filename,'gif','Loopcount',inf,...
                'DelayTime',0.1);%loopcount只是在i==1的时候才有用
        else
            imwrite(I,map,filename,'gif','WriteMode','append',...
                'DelayTime',0.1);
        end
        
    end
end