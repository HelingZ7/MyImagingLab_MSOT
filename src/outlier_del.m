function img=outlier_del(img)
% Heling Zhou, Ph.D.
% Email: helingzhou7@gmail.com
% compress outliers (3*std from mean)
m_img=mean(img(img~=0&~isnan(img)));
s_img=3*std(img(img~=0&~isnan(img)));
img(img>(m_img+s_img))=m_img+s_img;
img(img<(m_img-s_img))=m_img-s_img;
end