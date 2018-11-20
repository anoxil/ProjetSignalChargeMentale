clear all
close all

M = 5001;

temps = (1:M);
var = 2;
moy = 0;
bruit = sqrt(var)*randn(1,M)+moy;

% 3.2.1.1
yint = zeros(1,M);
total = 0;
for m = 1:M
    total = total + bruit(m);
    yint(m) = total;
end


% 3.2.1.2
L = 11;
N = floor(M/L);


for l = 1:11
    bruit((((l-1)*N)+1):(l*N));
end






