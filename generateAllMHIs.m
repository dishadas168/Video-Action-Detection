%This script generates the MHIs for all the 20 sequences and stores them in
%a mat file

clc
clear

%Make changes to the base directory if needed
basedir = './';

%Names of actions
actions = {'botharms', 'crouch', 'leftarm', 'punch', 'rightkick'};

%Hardcoded width and height of the images
allMHIs = zeros(480, 640, 20);
cnt = 1;

%Iterate over all actions
for actionnum=1:length(actions)

    subdirname = [basedir actions{actionnum} '/'];
    subdir = dir(subdirname);
    
    for seqnum=3:length(subdir)
        directoryName = subdir(seqnum).name;
        H = computeMHI(directoryName);
        
        %Uncomment below to view MHIs
        figure;
        imagesc(H(:,:,end));  
        title(['Action : ' actions{actionnum} ' , Sequence: ' directoryName]);
        
        %Stores the last slice of H matrix as the MHI
        allMHIs(:,:,cnt) = H(:,:,end);
        cnt = cnt+1;
    end 
end
save('allMHIs.mat','allMHIs');