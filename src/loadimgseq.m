function img=loadimgseq(varargin)
% Heling Zhou, Ph.D.
% Email: helingzhou7@gmail.com
% load tif or jpg
% examples: 
% img=loadimgseq(num_of_imgs)
% img=loadimgseq(num_of_imgs, startdir)
% img=loadimgseq(num_of_imgs, startdir, firstfile)

filenum=varargin{1};
if nargin==3
    PathName=varargin{2};
    FileName=varargin{3};    
elseif nargin==2
    startdir=varargin{2};
    [FileName,PathName]=uigetfile({'*.jpg;*.tif';'*.*'},'Select the 1st file',startdir);
elseif nargin==1
    [FileName,PathName]=uigetfile({'*.jpg;*.tif';'*.*'},'Select the 1st file');
end
file_extension_idx=strfind(FileName,'.');
files = dir(strcat(PathName,'\*',FileName(file_extension_idx(end):end)));
fileinfolder=length(files);
if filenum==fileinfolder
    idx=1;
else
    idx=find(strcmp({files.name},FileName)); % idx of the selected file.
end
    for i=idx:idx+filenum-1
        name=strcat(PathName, '\',files(i).name);
        img(:,:,i-idx+1)=mean(double(imread(name)),3);
    end
end
