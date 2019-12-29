%Function to calculate Hu moments for a given MHI. Function takes an MHI as
% the input and returns a 7-D vector Hu moments.
function [ moments ] = huMoments( H )

    x = 1:size(H,1);
    y = 1:size(H,2);

    M_00 = sum(H(:));
    M_10 = x'.*sum(H,2);
    M_10 = sum(M_10(:));
    M_01 = y.*sum(H,1);
    M_01 = sum(M_01(:));

    x_m = M_10/M_00;
    y_m = M_01/M_00;

    u_00 = sum(H(:));
    u_20 = 0;
    u_02 = 0;
    u_11 = 0;
    u_30 = 0;
    u_12 = 0;
    u_21 = 0;
    u_03 = 0;


    for i = 1:size(H,1)
        for j = 1:size(H,2)
            u_20 = u_20 + ((i - x_m)^2)*H(i,j);
            u_02 = u_02 + ((j - y_m)^2)*H(i,j);
            u_11 = u_11 + (i - x_m)*(j - y_m)*H(i,j);
            u_30 = u_30 + ((i - x_m)^3)*H(i,j);
            u_03 = u_03 + ((j - y_m)^3)*H(i,j);
            u_12 = u_12 + (i - x_m)*((j - y_m)^2)*H(i,j);
            u_21 = u_21 + ((i - x_m)^2)*(j - y_m)*H(i,j);
        end
    end

% Uncomment to use scale-invariant moments
%     n_20 = u_20/(u_00^(2));
%     n_02 = u_02/(u_00^(2));
%     n_11 = u_11/(u_00^(2));
%     n_30 = u_30/(u_00^(2.5));
%     n_12 = u_12/(u_00^(2.5));
%     n_21 = u_21/(u_00^(2.5));
%     n_03 = u_03/(u_00^(2.5));
    
    
% Uncomment to use central moments
    n_20 = u_20;
    n_02 = u_02;
    n_11 = u_11;
    n_30 = u_30;
    n_12 = u_12;
    n_21 = u_21;
    n_03 = u_03;
 
    moments = zeros(1,7);
    
    moments(1) = n_20 + n_02;
    moments(2) = (n_20 - n_02)^2 + 4*n_11^2;
    moments(3) = (n_30 - 3*n_12)^2 + (3*n_21 - n_03)^2;
    moments(4) = (n_30 - n_12)^2 + (n_21 + n_03)^2;
    moments(5) = (n_30 - 3*n_12)*(n_30 + n_12)*((n_30 + n_12)^2 ... 
           - 3*(n_21 + n_03)^2) + (3*n_21 - n_03)*...
            (n_21 + n_03)*(3*(n_30 + n_12)^2 - (n_21 + n_03)^2);
    moments(6) = (n_20 - n_02)*((n_30 + n_12)^2 - (n_21 + n_03)^2)...
            + 4*n_11*(n_30 + n_12)*(n_21 + n_03);
    moments(7) = (3*n_21 - n_03)*(n_30 + n_12)*((n_30 + n_12)^2 - 3*(n_21 + n_03)^2)...
            - (n_30 - 3*n_12)*(n_21 + n_03)*(3*(n_30 + n_12)^2 - (n_21 + n_03)^2);

end

