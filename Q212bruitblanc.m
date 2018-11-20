clear all
close all

M = 5001;

temps = (1:M);
var = 2;
moy = 0;
bruit = sqrt(var)*randn(1,M)+moy;

subplot(2,1,1); plot(temps, bruit); xlim([20 775]); title('Représentation temporelle')
subplot(2,1,2); spectrogram(bruit, 256, 128, 'yaxis'); xlim([20 775]); title('Représentation temps-fréquence')