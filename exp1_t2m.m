%%%Addition Of sinusoidal Signals
clc;
clear all;
close all;
A=1
fm=50
fs=1000
dt = 1/fs
t=0:dt:1
sin1= A*sin(2*pi*fm*t)
subplot(3,1,1)
plot(t,sin1)
xlabel('Time')
ylabel("Amplitude")
title("Sin wave")

A=1
fm=250
fs=1000
dt = 1/fs
t=0:dt:1
sin2= A*sin(2*pi*fm*t)
subplot(3,1,2)
plot(t,sin2)
xlabel('Time')
ylabel("Amplitude")
title("Sin wave")

% Add the two sinusoidal signals
combinedSignal = sin1 + sin2;
subplot(3,1,3)
plot(t, combinedSignal)
xlabel('Time')
ylabel("Amplitude")
title("Combined Sinusoidal Signal")