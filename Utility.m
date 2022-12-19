classdef Utility
    methods(Static)
         % load image from file explorer
         function img = loadImage()
            [file,path] = uigetfile('assets/*.*');
            % get the full path of image
            imgPath = strcat(path,file);
            % read the image
            img = imread(imgPath);
         end

         % check if image is grayscale
         function res = isGrayscale(img)
            res = size(img,3) == 1;
         end

         % change image to binary image with black background
         function bw = imgToBinary(img)
             gray = im2gray(img);
             bw = imbinarize(gray);
             if bwarea(bw) > bwarea(~bw)
               bw = ~bw;
            end

         end
    end
end