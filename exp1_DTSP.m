clc;
close all;
clear all;

%Delta Signal
n=[-10:10]
delta= [zeros(1,10),1,zeros(1,10)]
subplot(4,2,1)
stem(n,delta)
title('Delta Signal');
xlabel('n');
ylabel('Amplitude');


%Unit step
n = [-10:10];
unitStep = [zeros(1,10), ones(1,11)];
subplot(4,2,2);
stem(n, unitStep);
title('Unit Step Signal');
xlabel('n');
ylabel('Amplitude');

%ramp
n1=[0:25]
ramp = n1;
subplot(4,2,3);
stem(n1, ramp);
title('Ramp Signal');
xlabel('n');
ylabel('Amplitude');

%parabolic
n2 = [0:20];
parabolic = (n2.^2);
subplot(4,2,4);
stem(n2, parabolic);
title('Parabolic Signal');
xlabel('n');
ylabel('Amplitude');

%o.5n
exponential = 0.5.^n1 ;
subplot(4,2,5);
stem(n1, exponential);
title('Exponential Signal');
xlabel('n');
ylabel('Amplitude');

%exp2n
exp2n = exp(n1)
subplot(4,2,6);
stem(n1, exp2n);
title('Exp2n');
xlabel('n');
ylabel('Amplitude');

%-0.5n
exponential = -(0.5.^n1);
subplot(4,2,7);
stem(n1, exponential);
title('Negative 0.5 Exponential Signal');
xlabel('n');
ylabel('Amplitude');

%-2n

exponential = -(2.^n1);
subplot(4,2,8);
stem(n1, exponential);
title('Negative 2 Exponential Signal');
xlabel('n');
ylabel('Amplitude');



