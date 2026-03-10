%Frequency Resolution and zero padding
clc;
clear all;
close all;
h = [0:7] 
x = [6 9 0 5 8 2 7 2]
subplot(2,1,1); 
%absolute fourier transform and then phase fourier transform 
stem(abs(fft(x))); 
xlabel('Frequency'); 
ylabel('Amplitude'); 
title('Absolute Fourier Transform')
subplot(2,1,2) 
stem(angle(fft(x))); 
xlabel('Frequency') 
ylabel('Phase (radians)'); 
title('Phase Fourier Transform');