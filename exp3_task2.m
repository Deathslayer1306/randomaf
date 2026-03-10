n = [1 : 25]
x = cos(0.2*pi*n) + cos(0.22*pi*n) + cos(0.6*pi*n)
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


%ZERO PADDING
figure;

subplot(4,1,1); 
stem(abs(fft(x))); 
title('Absolute Fourier Transform')

subplot(4,1,2);
stem(abs(fft(x,256))); 
title('Zero Padded 256')

subplot(4,1,3);
stem(abs(fft(x, 512)));
title('Zero Padded 512');

subplot(4,1,4);
stem(abs(fft(x,1024))); 
title('Zero Padded 1024')

figure;
n1 = [1 : 25]
x = cos(0.2*pi*n1) + cos(0.22*pi*n1) + cos(0.6*pi*n1)
subplot(3,1,1);
stem(abs(fft(x,1024))); 
title('Zero Padded 1024 for 25 samples')

n2 = [1 : 50]
x = cos(0.2*pi*n2) + cos(0.22*pi*n2) + cos(0.6*pi*n2)
subplot(3,1,2);
stem(abs(fft(x,1024))); 
title('Zero Padded 1024 for  50 samples')

n3 = [1 : 100];
x = cos(0.2*pi*n3) + cos(0.22*pi*n3) + cos(0.6*pi*n3);
subplot(3,1,3);
stem(abs(fft(x,1024))); 
title('Zero Padded 1024 for  100 samples');