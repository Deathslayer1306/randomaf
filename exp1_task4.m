clc;
clear;
close all;

% Define impulse responses
h1 = [1/2 1/2 1/2 1/2 1/2 1/2 1/2 1/2];
h2 = [1/2 -1/2 1/2 -1/2 1/2 -1/2 1/2 -1/2];

% Convolution
y = conv(h1, h2);

% Display results
disp('Impulse response h1(n):');
disp(h1);

disp('Impulse response h2(n):');
disp(h2);

disp('Convolution result y(n) = h1(n) * h2(n):');
disp(y);

% Plot results
figure;
subplot(3,1,1);
stem(h1,'filled');
title('Impulse Response h_1(n)');
xlabel('n'); ylabel('Amplitude');

subplot(3,1,2);
stem(h2,'filled');
title('Impulse Response h_2(n)');
xlabel('n'); ylabel('Amplitude');

subplot(3,1,3);
stem(y,'filled');
title('Convolution Output y(n)');
xlabel('n'); ylabel('Amplitude');
