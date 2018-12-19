function [ IG ] = IGR( U1, U2 )

%%
% m_U1 = mean(U1);
% m_U2 = mean(U2);

% 
% n_U1_rU1 = length(find(abs(U1-mean(U1))<abs(U1-mean(U2))));
% n_U2_rU1 = length(find(abs(U1-mean(U1))>abs(U1-mean(U2))));
% 
% n_U2_rU2 = length(find(abs(U2-mean(U2))<abs(U2-mean(U1))));
% n_U1_rU2 = length(find(abs(U2-mean(U2))>abs(U2-mean(U1))));
%%
n_U1_rU1 = 0;
n_U2_rU1 = 0;
n_U2_rU2 = 0;
n_U1_rU2 = 0;

for i = 1:length(U1)
    U1_temp = U1;
    U2_temp = U2;
    
    U1_temp(i) = [];
    U2_temp(i) = [];
    
    if (abs(U1(i)-mean(U1_temp))<abs(U1(i)-mean(U2_temp)))
        n_U1_rU1 = n_U1_rU1+1;
    else
        n_U2_rU1 = n_U2_rU1+1;
    end
    
    if (abs(U2(i)-mean(U2_temp))<abs(U2(i)-mean(U1_temp)))
        n_U2_rU2 = n_U2_rU2+1;
    else
        n_U1_rU2 = n_U1_rU2+1;
    end
end


nU1 = n_U1_rU1+n_U1_rU2;
nU2 = n_U2_rU1+n_U2_rU2;

HU1 = -n_U1_rU1/nU1*log(n_U1_rU1/nU1)-n_U1_rU2/nU1*log(n_U1_rU2/nU1);
HU2 = -n_U2_rU1/nU2*log(n_U2_rU1/nU2)-n_U2_rU2/nU2*log(n_U2_rU2/nU2);

Hafter = 1/(nU1+nU2)*(nU1*HU1+nU2*HU2);

IG = 1-Hafter;
end

