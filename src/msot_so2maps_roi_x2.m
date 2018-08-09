function msot_so2maps_roi_x2
% Heling Zhou, Ph.D.
% Email: helingzhou7@gmail.com
% load tif images (three channels - single wavelength, hb, hbO2) generated from viewMSOT and save
% 1) SO2(%) : hbO2/(hb+hbO2)
% 2) SO2_roi(%) : hbO2/(hb+hbO2), outside roi is nan
% 3) SO2_roiandsnr5(%) : hbO2/(hb+hbO2), outside roi is set to nan, lower than 5
% times noise level is set to nan, noise level is defined as the mean of lower
% right conner (5*5) with outlier removed
% 4) total_hb(au) : hb+hbO2
% 5) total_hb_roi(au) : hb+hbO2, outside roi is nan


dirname=uigetdir;
files = dir(strcat(dirname,'\*.tif'));
fileinfolder=length(files);
cd(dirname)
mkdir('tif')
cd('tif')
mkdir('SO2')
mkdir('SO2_roi')
mkdir('SO2_roiandsnr5')
mkdir('total_hb')
mkdir('total_hb_roi')

% load three images (first,last and middle) for roi
img4roi(:,:,1)=outlier_del(double(imread(strcat(dirname,'\',files(1).name))));
img4roi(:,:,2)=outlier_del(double(imread(strcat(dirname,'\',files(round(end/2)).name))));
img4roi(:,:,3)=outlier_del(double(imread(strcat(dirname,'\',files(end).name))));
for i=1:3
    temp=img4roi(:,:,i);temp(temp<0)=0;
    img4roi(:,:,i)=im_norm(temp);
end
figure
imagesc(img4roi);img_setting1;
[mask, Position]=drawroi(1);
hold on
roi_para_drawing(Position,1);
saveas(gcf,'ROI.jpg')
save('mask','mask','Position')

for n=1:ceil(fileinfolder/501) % can't load more than 501 files in the same time
    % 501 files == 167 three channel frames
    numofremainingfile=fileinfolder-(n-1)*501;
    img=loadimgseq(min(numofremainingfile,501),dirname,files((n-1)*501+1).name); % load 501 images or the remaining less than 501
    % [x,y,t]=size(img);
    % ch=input('# of channels');
    % tp=input('# of timepoints');
    %
    % if ch*tp~=t
    %     warning('number doesnot match')
    %     return
    % end
    
    % img=reshape(img,[x,y,ch,tp]);
    img(:,:,1:3:end)=[]; % remove first channel to save memory
    img(img<0)=nan;
    hb_tot=img(:,:,1:2:end)+img(:,:,2:2:end);
    hb_tot=outlier_del(hb_tot);
    hb_tot(hb_tot<0)=nan;
    hb_tot_roi=hb_tot;
    hb_tot_roi(~repmat(mask,[1,1,size(hb_tot_roi,3)]))=nan;
    
    temp=hb_tot(end-5:end,end-5:end,:);
    noise_level=meannan(outlier_del(temp(:)))*5;
    so2=img(:,:,2:2:end)./hb_tot*100;
    so2(so2>100|so2<0)=nan;
    so2_roi=so2;
    so2_roi(~repmat(mask,[1,1,size(so2_roi,3)]))=nan;
    hb_tot_no_bg=hb_tot;
    hb_tot_no_bg(hb_tot<noise_level)=nan;
    so2_no_bg=img(:,:,2:2:end)./hb_tot_no_bg*100;
    so2_no_bg(so2_no_bg>100|so2_no_bg<0|~repmat(mask,[1,1,size(so2_no_bg,3)]))=nan;
    img=[];hb_tot_no_bg=[];
    
    % save figures as jpgs
    % mkdir('jpg')
    % figure;
    % cd('jpg')
    % for i=1:size(so2,3)
    %     clf
    %     imagesc(so2(:,:,i));colormap jet;colorbar;img_setting1;set(gca,'clim',[0,80]);
    %     saveas(gcf,strcat('SO2_',num2str(i+(n-1)*167),'.jpg'))
    %     clf
    %     imagesc(hb_tot(:,:,i));colormap jet;colorbar;img_setting1;set(gca,'clim',[0,0.5]);
    %     saveas(gcf,strcat('total_hb_',num2str(i+(n-1)*167),'.jpg'))
    %     clf
    %     imagesc(so2_no_bg(:,:,i));colormap jet;colorbar;img_setting1;set(gca,'clim',[0,80]);
    %     saveas(gcf,strcat('SO2_nobackground_',num2str(i+(n-1)*167),'.jpg'))
    % end
    
    % save index images as tif
    for i=1:size(so2,3)
        write_tif_raw(so2(:,:,i),strcat('SO2\SO2_',num2str(i+(n-1)*167),'.tif'))
        write_tif_raw(so2_roi(:,:,i),strcat('SO2_roi\SO2_roi_',num2str(i+(n-1)*167),'.tif'))
        
        write_tif_raw(hb_tot(:,:,i),strcat('total_hb\total_hb_',num2str(i+(n-1)*167),'.tif'))
        write_tif_raw(hb_tot_roi(:,:,i),strcat('total_hb_roi\total_hb_roi',num2str(i+(n-1)*167),'.tif'))
        
        write_tif_raw(so2_no_bg(:,:,i),strcat('SO2_roiandsnr5\SO2_roiandsnr5_',num2str(i+(n-1)*167),'.tif'))
    end
    clearvars -except n rgb fileinfolder dirname files
end
cd ..
end