function mask = maskImage(Img)
%% Enter Your Code Here
	imshow(Img,[]);
    imfreeHandle=imfreehand();
    position=wait(imfreeHandle);
    mask=createMask(imfreeHandle);
end

