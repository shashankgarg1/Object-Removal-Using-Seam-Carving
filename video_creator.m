T%%this script I copied from the matlabworks website.
outputVideo = VideoWriter(fullfile('output.avi'));
outputVideo.FrameRate = 10;
open(outputVideo);

for ii = 1:length(m)
   img = im2uint8(m{ii});
   writeVideo(outputVideo,img);
end

close(outputVideo);