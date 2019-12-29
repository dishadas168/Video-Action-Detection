% Function to predict the label of an action sequence. Input parameters are
% the hu moments of test case, training cases and the training label set.
% Output is a single label.
function [ predictedLabel ] = predictAction( testMoments, trainMoments, trainLabels )

%Uncomment to use euclidian distance
%distances = dist2(testMoments, trainMoments);

%Uncomment to use normalized euclidian distance
distances = normDist(testMoments, trainMoments);

distances = distances/max(distances(:));
[minval, id] = min(distances);
predictedLabel = trainLabels(id);

end

