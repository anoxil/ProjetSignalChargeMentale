clear all
close all

M = 5001;

temps = (1:M);
var = 2;
moy = 0;

bruit = sqrt(var)*randn(1,M)+moy;

for m = 1:M
    bruit = bruit - mean(bruit);
    yint = cumsum(bruit); 
end

N = 11;
L = floor(M/N);

b = zeros(1,N+1); b(1) = 1/N; b(N+1) = -1/N;
a = zeros(1,N+1); a(1) = 1; a(2) = -1;

filtre = filter(b, a, yint);
retard = (N-1)/2;
filtreRephase = filtre(retard:M);


% PLOTS
% zplane(b ,a)
% freqz(b,a,N)
%%% yint filtré rephasé %%%
% plot((1:M),yint,(1:(M-(retard-1))),filtreRephase)
% title('Profil de yint pour un bruit blanc et son filtre rephasé'); xlabel('M (nb échantillons)'); ylabel('yint (profil) & yint filtré'); legend('yint (profil)', 'yint filtré')
%%%%%%%%%%%%%%%%%%%%%%%%%%%












% plot((1:M),yint); title('Profil de yint pour un bruit blanc'); xlabel('M (nb échantillons)'); ylabel('yint (profil)');




