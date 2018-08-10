# MyImagingLab_MSOT_SO2maps
MyImagingLab_MSOT_SO2maps is part of my matlab codebase at UTSW for analysis of MSOT data.

The code was developed during my postdoc training in the [Mason lab](https://www.utsouthwestern.edu/labs/mason/)

## **Description of the main function:**
**msot_so2maps_roi_x2**
This program loads tif images (three channels - single wavelength, hb, hbO2) generated from viewMSOT and save
1) SO2(%) : hbO2/(hb+hbO2)
2) SO2_roi(%) : hbO2/(hb+hbO2), outside roi is nan
3) SO2_roiandsnr5(%) : hbO2/(hb+hbO2), outside roi is set to nan, lower than 5 times noise level is set to nan, noise level is defined as the mean of lower right conner (5*5) with outlier removed
4) total_hb(au) : hb+hbO2
5) total_hb_roi(au) : hb+hbO2, outside roi is nan

## **Workflow**

![Select folder to analyze](https://github.com/HelingZ7/MyImagingLab_MSOT_SO2maps/docs/SelectFolder.JPG?raw=true)

![Outline region of interest](https://github.com/HelingZ7/MyImagingLab_MSOT_SO2maps/docs/OutlineROI.jpg?raw=true)

![Images are automatically saved in five folders in the results folder](https://github.com/HelingZ7/MyImagingLab_MSOT_SO2maps/docs/OutputFolders.JPG?raw=true)
