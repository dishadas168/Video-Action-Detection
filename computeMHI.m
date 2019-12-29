% Function computes the MHI of a sequence of images from a video sequence
% and computes the H matrix and returns it. The function takes
% a directory name as input, where the images from a video sequence are
% contained.
function [ H ] = computeMHI( directoryName )
    
    %Make changes to the base directory here
    basedir = './';
    
    %Get a name of the action
    ind = strfind(directoryName,'-');
    actions = directoryName(1:ind-1);
    
    
    %Get all .pgm files from this directory
    depthfiles = dir([basedir  actions '/' directoryName '/*.pgm']);
    
    %First frame of sequence
    prevImg = imread([basedir  actions '/' directoryName '/' depthfiles(1).name]);   
    
    %H is a 3D matrix. The last slice of this matrix will be the MHI
    H = zeros(size(prevImg,1), size(prevImg,2),length(depthfiles)-1);

    % Cycle through all frames in this sequence 
    for i=2:length(depthfiles)  

        % read the next depth map
        frame = imread([basedir actions '/' directoryName '/' depthfiles(i).name]);
        
        %Image subtraction
        
        %Uncomment below to use Gaussian blurring
        %depth = imgaussfilt(frame,4); %4 is good
        
        %Comment this if using Gaussian blurring
        depth = frame;
        
        %Getting difference image
        diff = depth - prevImg;
        diff = im2double(diff);
        diff = im2bw(diff, 0.2);
        
        %Uncomment this to use dilation and erosion
%         se = strel('disk',4);
%         diff = imopen(diff,se);
%         se = strel('disk',4);
%         diff = imclose(diff,se);

        prevImg = frame;

        %Filling in the H matrix
        tau = length(depthfiles);
        diff1 = diff;
        diff = max(0,H(:,:,i-1)-1);
        diff(diff1==1) = tau;
        H(:,:,i) = diff;

    end
    
    H = H/max(H(:));
end

