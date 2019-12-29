%Script used to calculate Hu moments for all the 20 MHIs

clc
clear

load('allMHIs.mat');

%7d vectors for 20 MHIs
huVectors = zeros(20,7);

for seq = 1:20
    H = allMHIs(:,:,seq);
    huVectors(seq,:) = huMoments(H);
end

save('huVectors.mat', 'huVectors');