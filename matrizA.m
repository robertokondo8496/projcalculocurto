function [ M ] = matrizA()
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
M = sparse(3,3);
m=0;
n=0;
while(m<3)
    while(n<3)
        M(m,n) = 1;
        n=n+1;
    end
    n= 0;
    m=m+1;
end
   
M(2,2) = -0.5 + j*0.866666; % 1/_120º
M(2,3) = -0.5 -j*0.866666; % 1/_240º
M(3,2) = M(2,3);
M(3,3) = M(2,2);

end


