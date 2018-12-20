clear all
close all

M = 5001;

temps = (1:M);
var = 2;
moy = 0;

nbIteration = 50;
FNs = zeros(1,nbIteration);
for iteration = 1:nbIteration
    bruit = sqrt(var)*randn(1,M)+moy;

    for m = 1:M
        bruit = bruit - mean(bruit);
        yint = cumsum(bruit); 
    end

    ensembleN = [11,13,17,21,27,35,47,59,77,101];
    resultatsFN = zeros(1,length(ensembleN));

    for indexN = 1:length(ensembleN)
        N = ensembleN(indexN);

        b = zeros(1,N+1); b(1) = 1/N; b(N+1) = -1/N;
        a = zeros(1,N+1); a(1) = 1; a(2) = -1;

        filtre = filter(b, a, yint);
        retard = (N-1)/2;
        filtreRephase = filtre(retard:M);

        residu = 0;
        for i = 1:(M-retard) %(M-(M-(retard-1))):M
            residu = residu + power((yint(i) - filtreRephase(i)),2);
        end

        resultatsFN(indexN) = sqrt((1 / (M-retard)) * residu);
    end

    log_ensembleN = log(ensembleN);
    log_resultatsFN = log(resultatsFN);
    %%% plot du log %%%
    % plot(log_ensembleN,log_resultatsFN)
    % title('Courbe des logs (DMA)'); xlabel('Log de l''ensemble des N'); ylabel('Log des résultats de FN');
    [a,b] = polyfit(log_ensembleN,log_resultatsFN,1);
    FNs(iteration) = a(1);    
end

meanFNs = mean(FNs)
varFNs = (std2(FNs)).^2


% PLOTS
% zplane(b ,a)
% freqz(b,a,59)
%%% yint filtré rephasé %%%
% plot((1:M),yint,(1:(M-(retard-1))),filtreRephase)
% title('Profil de yint pour un bruit blanc et son filtre rephasé'); xlabel('M (nb échantillons)'); ylabel('yint (profil) & yint filtré'); legend('yint (profil)', 'yint filtré')
% plot((1:M),yint); title('Profil de yint pour un bruit blanc'); xlabel('M (nb échantillons)'); ylabel('yint (profil)');
%%%%%%%%%%%%%%%%%%%%%%%%%%%

