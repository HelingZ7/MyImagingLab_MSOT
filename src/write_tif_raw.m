function write_tif_raw(img,name)
%%
img=single(img);
t = Tiff(name,'w');
tags.ImageLength   = size(img,1);
tags.ImageWidth    = size(img,2);
tags.Photometric   = Tiff.Photometric.MinIsBlack;
tags.BitsPerSample = 32;
tags.SampleFormat  = Tiff.SampleFormat.IEEEFP;
tags.RowsPerStrip  = 16;  
tags.PlanarConfiguration = Tiff.PlanarConfiguration.Chunky;
tags.SamplesPerPixel = 1;
tags.ExtraSamples   = Tiff.ExtraSamples.Unspecified;
t.setTag(tags)
t.write(img);
t.close();
end
