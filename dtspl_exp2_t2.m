clc;
clear all;
close all;
load seismic_sig.mat; 
load noisy_seismic.mat; 
crc= xcorr(noisy_seismic,seismic_sign) 
figure();
subplot(1,2,1) 
plot(crc); 
title('Cross-Correlation'); 
xlabel('Time'); 
ylabel('Amplitude'); 

noise=randn(3048,1); 
crs= xcorr(noisy_seismic, noise)
subplot(1,2,2) 
plot(crs); 
title('Cross-Correlation'); 
xlabel('Time'); 
ylabel('Amplitude'); 
