clc;
close all;
clear all;

%-------- changing sampling frequency-----------N = 51;
N = 51;
a = (N-1)/2;
w = pi/2;
for n = 1:N
if (n==a)
Hd(n) = w/pi
else
Hd(n) = (sin(n-a)*w)/(pi*(n-a))
end
end
%rectangular window
win=boxcar(N)
output=Hd.*win';
%applying fft on output
y=20*log10(abs(fft(output,1024)))
figure;
subplot(1,3,1);
plot(y);
xlabel('F');
ylabel('Mag(dB)');
title('magnitude response in db');
%--------------samples = 101----------------
N = 101;
a = (N-1)/2;
w = pi/2;
for n = 1:N
if (n==a)
Hd(n) = w/pi
else
Hd(n) = (sin(n-a)*w)/(pi*(n-a))
end
end
%rectangular window
win=boxcar(N)
output=Hd.*win';
%applying fft on output
y=20*log10(abs(fft(output,1024)))
subplot(1,3,2);
plot(y);
xlabel('F');
ylabel('Mag(dB)');
title('magnitude response in db');
%----------------samples = 251---------------
N = 101;
a = (N-1)/2;
w = pi/2;
for n = 1:N
if (n==a)
Hd(n) = w/pi
else
Hd(n) = (sin(n-a)*w)/(pi*(n-a))
end
end
%rectangular window
win=boxcar(N)
output=Hd.*win';
%applying fft on output
y=20*log10(abs(fft(output,1024)))
subplot(1,3,3);
plot(y);
xlabel('F');
ylabel('Mag(dB)');
title('magnitude response in db');