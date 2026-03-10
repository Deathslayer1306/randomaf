%Design Of FIR filter
clc;
clear all;
close all;
N = 51;
wc = pi/2;
a = (N-1)/2;

for n = 1:N
    if (n == a)
        hd(n) = wc/pi
    else
        hd(n) = (wc * sin ( n - a )) / (pi * (n - a));
    end
end

figure;
subplot(4,4,1);
plot(hd);
title("Input signal");

%rectangular window
w = boxcar(N)
subplot(4,4,2);
plot(w);
title("Rectangular Window")

% Apply the window to the filter response
hd_windowed = hd .* w';
subplot(4,4,3);
plot(hd_windowed);
title("Windowed");

%Fourrier Transform Magnitude
output = 20 * log10(abs(fft(hd_windowed, 256)))
subplot(4,4,4);
plot(output);
title("Fourier Transform Magnitude");

subplot(4,4,5);
plot(hd);
title("Input signal");

%Hamming Window
w1 = hamming(N)
subplot(4,4,6);
plot(w1);
title("Hamming Window")

% Apply the hamming window to the filter response
hd_windowed1 = hd .* w1';
subplot(4,4,7);
plot(hd_windowed1);
title("Windowed");

%Fourrier Transform Magnitude
output1 = 20 * log10(abs(fft(hd_windowed1, 256)))
subplot(4,4,8);
plot(output1);
title("Magnitude");

subplot(4,4,9);
plot(hd);
title("Input signal");

%Hanning Window
w2 = hanning(N)
subplot(4,4,10);
plot(w2);
title("Hanning Window")

% Apply the hanning window to the filter response
hd_windowed2 = hd .* w2';
subplot(4,4,11);
plot(hd_windowed1);
title("Windowed");

%Fourrier Transform Magnitude
output2 = 20 * log10(abs(fft(hd_windowed2, 256)))
subplot(4,4,12);
plot(output2);
title("Magnitude");

subplot(4,4,13);
plot(hd);
title("Input signal");

%bartlett Window
w3 = bartlett(N)
subplot(4,4,14);
plot(w3);
title("Bantlett Window")

% Apply the bartlett window to the filter response
hd_windowed3 = hd .* w3';
subplot(4,4,15);
plot(hd_windowed3);
title("Windowed");

%Fourrier Transform Magnitude
output3 = 20 * log10(abs(fft(hd_windowed3, 256)))
subplot(4,4,16);
plot(output3);
title("Magnitude ");