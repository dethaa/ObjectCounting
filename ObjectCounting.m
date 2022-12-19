classdef ObjectCounting
    methods (Static)
        % convert image to binary using thresholding method
        function bw = getBinaryImg(img, threshold_algorithm, value)
            % convert to grayscale image
            gray = im2gray(img);

            % convert the grayscale image to binary image using selected method 
            if (threshold_algorithm == "Selected Threshold")
                T = value/255;
                bw = imbinarize(gray, T);
            elseif (threshold_algorithm == "Otsu")
                T =  graythresh(gray);
                bw = imbinarize(gray, T);
            elseif (threshold_algorithm == "Adaptive")
                bw = imbinarize(gray,'adaptive');
            end

            % make sure that the background is black & the object is white
            if bwarea(bw) > bwarea(~bw)
                bw = ~bw;
            end
        end

        % get segmentation mask from binary image
        function mask = getSegmentationMask(bw)
            % fill the holes in object
            mask = imfill(bw, 'holes');

            % remove objects with area less than 1500
            mask = bwareaopen(mask, 1500);
        end

        % get number of objects from the segmentation mask
        function num = getNumberOfObjects(mask)
            num = bwconncomp(mask).NumObjects;
        end
    end
end