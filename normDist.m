%normDist calculates the Normalized Euclidian distance between C hu moments
%and M moments.
function [ dist ] = normDist( C, M )

r = size(M,1);
dist = zeros(r,1);
vars = var(M);
for i = 1:r
    sqrs = ((C - M(i,:)).^2)./vars;
    sqrs = sum(sqrs(:));
    dist(i) = sqrt(sqrs);
end

end

