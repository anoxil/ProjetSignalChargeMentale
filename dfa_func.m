temp = cell2mat(dataEEG(i_p,i_e,i_s));
temp = temp';
for m = 1:M
    temp = temp - mean(temp);
    temp_int = cumsum(temp);
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
        tendance = polyfit( (((l-1)*N)+1):(l*N) , temp_int((((l-1)*N)+1):(l*N)) , 1 );
        tendances_locales_a(l) = tendance(1);
        tendances_locales_b(l) = tendance(2);
    end

    % calcul F(N)
    sumL = 0;
    for l = 1:L
        sumN = 0;
        for n = 1:N
            xl = tendances_locales_a(l) * (((l-1)*N)+n) + tendances_locales_b(l);
            sumN = sumN + (temp_int((l-1)*N+n) - xl).^2;
        end
        sumL = sumL + sumN;
    end

    fn = sqrt( (1/(L*N)) * sumL );
    resultatsFN(indexN) = fn;

end

log_ensembleN = log(ensembleN);
log_resultatsFN = log(resultatsFN);
[a,b] = polyfit(log_ensembleN,log_resultatsFN,1);
alphaFN = a(1);