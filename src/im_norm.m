function img=im_norm(img)
% Heling Zhou, Ph.D.
% Email: helingzhou7@gmail.com
% normalize images (of any dimentions) to a scale of 0 to 1

img=double(img);
img=outlier_del(img);
% low_limit=prctile(img(:),0.001);
% high_limit=prctile(img(:),0.999);
low_limit=min(img(:));
high_limit=max(img(:));
img=(img-low_limit)/(high_limit-low_limit);
img(img<0)=0; 
img(img>1)=1;
end