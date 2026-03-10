clc;
clear;
close all;

N = 51;
wc = pi/2;
a = (N-1)/2;

hd = zeros(1,N);    

% Ideal HPF impulse response
for n = 1:N
    if (n == a+1)             
        hd(n) = 1 - wc/pi;
    else
        hd(n) = -(sin((n-a-1)*wc))/(pi*(n-a-1));
    end
end

% Rectangular window
w = boxcar(N);

% Apply window
h = hd .* w';

% Frequency response
H = 20*log10(abs(fft(h,256)) + eps);   

figure;
subplot(2,1,1); plot(h); title('HPF Impulse Response');
subplot(2,1,2); plot(H); title('HPF Magnitude Response');


fs = 1000;
t = 0:1/fs:1;

f1 = 50;
f2 = 200;

x = sin(2*pi*f1*t) + sin(2*pi*f2*t);

figure;
plot(t,x);
title('Composite Signal');

% Filtering
y = filter(h,1,x);

figure;
subplot(2,1,1); plot(t,x); title('Original Signal');
subplot(2,1,2); plot(t,y); title('Filtered Output (HPF)');