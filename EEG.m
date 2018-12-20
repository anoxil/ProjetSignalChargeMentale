clear all
close all

load('dataEEG.mat');

M = 1001;



% DFA pour récupérer les alphas
alpha_e1 = zeros(2,5);
alpha_e2 = zeros(2,5);
for i_e = 1:2
    for i_p = 1:2
        for i_s = 1:5
            dfa_func();
            if (i_e == 1)
                alpha_e1(i_p,i_s) = alphaFN;
            else
                alpha_e2(i_p,i_s) = alphaFN;
            end
        end
    end
end
%

e1p1 = mean(alpha_e1(1,:))
e1p2 = mean(alpha_e1(2,:))
e2p1 = mean(alpha_e2(1,:))
e2p2 = mean(alpha_e2(2,:))

subplot(2,1,1);
plot((1:5),alpha_e1(1,:),'-o',(1:5),alpha_e1(2,:),'-o')
xlabel('Sujets');ylabel('Alphas de phase d''électrode'); legend('Alphas de phase 1 d''électrode 1','Alphas de phase 2 d''électrode 1');
title('Alphas de phase d''électrode 1 selon le sujet');
subplot(2,1,2);
plot((1:5),alpha_e2(1,:),'-o',(1:5),alpha_e2(2,:),'-o')
xlabel('Sujets');ylabel('Alphas de phase d''électrode'); legend('Alphas de phase 1 d''électrode 2','Alphas de phase 2 d''électrode 2');
title('Alphas de phase d''électrode 2 selon le sujet');