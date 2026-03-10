n = [1 : 25]
x = cos(0.2*pi*n) + cos(0.22*pi*n) + cos(0.6*pi*n)
%absolute fourier transform and then phase fourier transform 
stem(abs(fft(x,1024))); 
xlabel('Frequency'); 
ylabel('Amplitude'); 
title('Absolute Fourier Transform')
