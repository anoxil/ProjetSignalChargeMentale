clear all
close all

M = 5001;

temps = (1:M);
var = 2;
moy = 0;

nbIterations = 50;

FNs = zeros(1,nbIterations);
for i = 1:nbIterations
    
    bruit = sqrt(var) * randn(1,M) + moy;

    for m = 1:M
        bruit = bruit - mean(bruit);
        yint = cumsum(bruit); 
    end
    
    ensembleN = [11,13,17,21,27,35,47,59,77,101];
    resultatsFN = zeros(1,length(ensembleN));

    for indexN = 1:length(ensembleN)

        N = ensembleN(indexN);
        L = floor(M/N);

        % calcul tendances aux segments L (pour ax+b)
        tendances_locales_a = zeros(1,L);
        tendances_locales_b = zeros(1,L);
        for l = 1:L
            tendance = polyfit( (((l-1)*N)+1):(l*N) , yint((((l-1)*N)+1):(l*N)) , 1 );
            tendances_locales_a(l) = tendance(1);
            tendances_locales_b(l) = tendance(2);
        end

        % calcul F(N)
        sumL = 0;
        for l = 1:L
            sumN = 0;
            for n = 1:N
                xl = tendances_locales_a(l) * (((l-1)*N)+n) + tendances_locales_b(l);
                sumN = sumN + (yint((l-1)*N+n) - xl).^2;
            end
            sumL = sumL + sumN;
        end

        fn = sqrt( (1/(L*N)) * sumL );
        resultatsFN(indexN) = fn;

    end

    log_ensembleN = log(ensembleN);
    log_resultatsFN = log(resultatsFN);
    %%% plot du log %%%
    % plot(log_ensembleN,log_resultatsFN)
    % title('Courbe des logs (DFA)'); xlabel('Log de l''ensemble des N'); ylabel('Log des résultats de FN');
    [a,b] = polyfit(log_ensembleN,log_resultatsFN,1);
    FNs(i) = a(1);
    
    % plots
    if (N == 101 && i == 50)
        % plot du bruit blanc
        figure
        plot((1:M),yint); title('Profil de yint pour un bruit blanc'); xlabel('M (nb échantillons)'); ylabel('yint (profil)');
        % plot de segmentation pour N=101
        figure
        hold on
        plot((1:M),yint); title('Profil de yint pour un bruit blanc et sa tendance'); xlabel('M (nb échantillons)'); ylabel('yint (profil) et tendance');
        for pente = 1:L
            plot((((pente-1)*N)+1):(pente*N),(tendances_locales_a(pente)*((((pente-1)*N)+1):(pente*N))+tendances_locales_b(pente)),'Color',[1,0,0],'LineWidth',2)
            line([(pente*N) (pente*N)], [-80 80])
        end
    end
end

meanFNs = mean(FNs)
varFNs = (std2(FNs)).^2