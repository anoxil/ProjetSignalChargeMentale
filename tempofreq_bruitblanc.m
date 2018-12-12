clear all
close all

M = 5001;

temps = (1:M);
var = 2;
moy1 = 0;
bruit1 = sqrt(var)*randn(1,M)+moy1;
moy2 = 2;
bruit2 = sqrt(var)*randn(1,M)+moy2;

subplot(2,2,1); plot(temps, bruit1); xlim([20 775]); title('Représentation temporelle (moy=0)')
subplot(2,2,3); spectrogram(bruit1, 256, 128, 'yaxis'); xlim([20 775]); title('Représentation temps-fréquence (moy=0)')
subplot(2,2,2); plot(temps, bruit2); xlim([20 775]); title('Représentation temporelle (moy=2)')
subplot(2,2,4); spectrogram(bruit2, 256, 128, 'yaxis'); xlim([20 775]); title('Représentation temps-fréquence (moy=2)')