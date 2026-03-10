%Design HPF IIR Filter using butterworth IIV and butterworth BLT method
clc;
clear all;
close all;
rp = 2; %passband ripple (dB)
rs = 30; %stopband ripple (dB)
fs = 2000; %sampling frequency (Hz)
fp = 400; %passband frequency (Hz)
fsb = 100; %stopband frequency (Hz)
wp = (2*pi*fp)/fs;
wsb = (2*pi*fsb)/fs;
[n, wc] = buttord(wp, wsb, rp, rs, 's'); %normalized angular passband and stopband frequency frequency
[b, a] = butter(n, wc, 'high', 's'); % Design the high-pass filter
%now apply IIV by using freqs command
[h w] = freqs(b,a);
%plot magnitude and phase response
figure;
subplot(3,4,1);
h1 = 20*log10(abs(h));
f=(w*fs)/(2*pi)
plot(f,h1)
title('Magnitude Response');
xlabel('Frequency (rad/s)');
ylabel('Magnitude (dB)');
subplot(3,4,2);
h2 = angle(h);
plot(f, h2);
title('Phase Response');
xlabel('Frequency (rad/s)');
ylabel('Phase (radians)');
%same thing using freqz
% Calculate frequency response using freqz for discrete
[b2,a2] = impinvar(b,a,1)
[h2 w2] = freqz(b2,a2);
% Plot magnitude and phase response using freqz
subplot(3,4,3);
h3 = 20*log10(abs(h2));
f2 = (w2*fs)/(2*pi);
plot(f2, h3);
title('Magnitude Response (freqz)');
xlabel('Frequency (rad/s)');
ylabel('Magnitude (dB)');
subplot(3,4,4);
h4 = angle(h2);
plot(f2, h4);
title('Phase Response (freqz)');
xlabel('Frequency (rad/s)');
ylabel('Phase (radians)');
%plot magnitude and phase response
subplot(3,4,5);
h1 = 20*log10(abs(h));
f=(w*fs)/(2*pi)
plot(f,h1)
title('Magnitude Response');
xlabel('Frequency (rad/s)');
ylabel('Magnitude (dB)');
subplot(3,4,6);
h2 = angle(h);
plot(f, h2);
title('Phase Response');
xlabel('Frequency (rad/s)');
ylabel('Phase (radians)');
%using blt
[b3,a3] = bilinear(b,a,1)
[h3 w3] = freqz(b3, a3); % Calculate frequency response using freqz for bilinear transformation
% Plot magnitude and phase response using freqz for bilinear transformation
subplot(3,4,7);
h5 = 20*log10(abs(h3));
f3 = (w3*fs)/(2*pi);
plot(f3, h5);
title('Magnitude Response (bilinear)');
xlabel('Frequency (rad/s)');
ylabel('Magnitude (dB)');
subplot(3,4,8);
h6 = angle(h3);
plot(f3, h6);
title('Phase Response (bilinear)');
xlabel('Frequency (rad/s)');
ylabel('Phase (radians)');

%designing the chebyshev filter using new fs = 5000, fp = [800,1600], fsb =
%[400, 2000], and max ripple rp1 = 10dB using only BLT
rp1 = 10; % maximum ripple (dB)
fs_new = 5000; % new sampling frequency (Hz)
fp_new = [800, 1600]; % new passband frequencies (Hz)
fsb_new = [400, 2000]; % new stopband frequencies (Hz)
wp_new = (2*pi*fp_new)/fs_new;
wsb_new = (2*pi*fsb_new)/fs_new;
[n_new, wc_new] = cheb1ord(wp_new, wsb_new, rp1, rs, 's'); % Determine the order and cutoff frequency for Chebyshev filter
[b_cheby, a_cheby] = cheby1(n_new, rp1, wc_new, 'bandpass', 's'); % Design the Chebyshev high-pass filter
[h_cheby, w_cheby] = freqs(b_cheby, a_cheby); % Calculate frequency response using freqs
%plotting in the same figure using BLT
% Plot magnitude and phase response for Chebyshev filter
subplot(3,4,9);
h_cheby_mag = 20*log10(abs(h_cheby));
f_cheby = (w_cheby*fs_new)/(2*pi);
plot(f_cheby, h_cheby_mag);
title('Magnitude Response (Chebyshev)');
xlabel('Frequency (rad/s)');
ylabel('Magnitude (dB)');
%plotting phase response
subplot(3,4,10);
h_cheby_phase = angle(h_cheby);
plot(f_cheby, h_cheby_phase);
title('Phase Response (Chebyshev)');
xlabel('Frequency (rad/s)');
ylabel('Phase (radians)');
%using blt
[b_cheby_blt, a_cheby_blt] = bilinear(b_cheby, a_cheby, 1); % Apply bilinear transformation to Chebyshev filter
[h_cheby_blt, w_cheby_blt] = freqz(b_cheby_blt, a_cheby_blt); % Calculate frequency response using freqz for bilinear transformation
% Plot magnitude and phase response for Chebyshev filter using bilinear transformation
subplot(3,4,11);
h_cheby_blt_mag = 20*log10(abs(h_cheby_blt));
f_cheby_blt = (w_cheby_blt*fs_new)/(2*pi);
plot(f_cheby_blt, h_cheby_blt_mag);
title('Magnitude Response (Chebyshev BLT)');
xlabel('Frequency (rad/s)');
ylabel('Magnitude (dB)');
% Plot phase response for Chebyshev filter using bilinear transformation
subplot(3,4,12);
h_cheby_blt_phase = angle(h_cheby_blt);
plot(f_cheby_blt, h_cheby_blt_phase);
title('Phase Response (Chebyshev BLT)');
xlabel('Frequency (rad/s)');
ylabel('Phase (radians)');