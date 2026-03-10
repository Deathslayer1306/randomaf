%%Performing Correlations Auto Correlation and cross correlations

clc;
clear all;
close all;

%Tranmitted
Tx= [1,2,3,4,5,6,5,4,3,2,1]
figure();
subplot(3,2,1)
plot(Tx)
xlabel("Duration")
ylabel("Amplitude")
title("Transmitted")

%Delayed Pulse
delay_pulse = [zeros(1,50), Tx]
subplot(3,2,2);
plot(delay_pulse)
xlabel("Duration")
ylabel("Amplitude")
title("Delayed")

%Received Pulse
delay_pulse = [zeros(1,50), Tx, zeros(1,(200-61))];
a=0.999999;
noise = randn(1,200);
rx = ( a * delay_pulse)+noise;
subplot(3,2,3);
plot(rx)
xlabel("Duration")
ylabel("Amplitude")
title("Received")


%Auto Corr

acr= xcorr(noise);
subplot(3,2,4);
plot(acr)
xlabel("Duration")
ylabel("Amplitude")
title("AutoCorrelation Of Noise")

% Cross Correlation
ccr = xcorr(rx, Tx);
subplot(3,2,5);
plot(ccr)
xlim([200 400])
xlabel("Duration")
ylabel("Amplitude")
title("Cross Correlation of Transmitted and Received")

% Cross Correlation
ccr1 = xcorr(noise, Tx);
subplot(3,2,6);
plot(ccr1)
xlabel("Duration")
ylabel("Amplitude")
title("Cross Correlation of Noise and Transmitted ")
