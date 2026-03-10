clc;
close all;
clear all;
%%Covolution of chirp signal with fuctions (low pass filter and high pass
%%filter)

% Generate a chirp signal
fs = 5000; % Sampling frequency
t = 0:1/fs:1; % Time vector
x = chirp(t, 0, 1, 5000); % Chirp from 0 to 500 Hz

subplot(2,2,1)
plot(t,x)
title("Chirp Signal")

h1 = [1/2 1/2 1/2 1/2 1/2 1/2 1/2 1/2];
y1=conv(x,h1)
subplot(2,2,2)
plot(y1)
title("Plot lpf")

subplot(2,2,3)
specgram(y1)
title("Specgram lpf")

h2 = [1/2 -1/2 1/2 -1/2 1/2 -1/2 1/2 -1/2]; % High pass filter coefficients
y2 = conv(x, h2); % Convolve with high pass filter
subplot(2,2,4)
plot(y2)
title("High Pass Filtered Signal");