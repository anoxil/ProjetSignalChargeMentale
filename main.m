clear all
close all

load('dataEEG.mat');

M = 5001;

%freq ech = 1000Hz
%bruit1 = randn(1,M);
temps = (1:M);
%plot(temps, bruit1)

var = 2; %ou 3;
moy = 0;
bruit2 = sqrt(var)*randn(1,M)+moy;



subplot(2,1,1); plot(temps, bruit2); xlim([20 775]); title('Représentation temporelle')
subplot(2,1,2); spectrogram(bruit2, 256, 128, 'yaxis'); xlim([20 775]); title('Représentation temps-fréquence')