clc; clear; close all;

%% Step 1: Initialize Parameters
N = 20;              % Number of bits
Rb = 1e3;            % Bit rate (bits per second)
Fs = 10*Rb;          % Sampling frequency
Tb = 1/Rb;           % Bit duration
Ns = Fs/Rb;          % Samples per bit

%% Step 2: Generate Random Binary Sequence
data = randi([0 1], 1, N);
disp('Random Binary Data:');
disp(data);

%% Step 3: Line Coding Implementations

% --- Unipolar NRZ ---
unipolar = repelem(data, Ns);

% --- Polar NRZ ---
polar = repelem(2*data - 1, Ns);

% --- Manchester Encoding ---
manchester = zeros(1, N*Ns);
for i = 1:N
    if data(i) == 1
        manchester((i-1)*Ns+1 : (i-1)*Ns+Ns/2) = 1;
        manchester((i-1)*Ns+Ns/2+1 : i*Ns) = -1;
    else
        manchester((i-1)*Ns+1 : (i-1)*Ns+Ns/2) = -1;
        manchester((i-1)*Ns+Ns/2+1 : i*Ns) = 1;
    end
end

% --- Bipolar AMI ---
bipolar = zeros(1, N*Ns);
last = -1;   % Keep track of last polarity
for i = 1:N
    if data(i) == 1
        last = -last; % Alternate between +1 and -1
        bipolar((i-1)*Ns+1 : i*Ns) = last;
    else
        bipolar((i-1)*Ns+1 : i*Ns) = 0;
    end
end

%% Step 4: Plot the Line Codes
t = (0:length(unipolar)-1)/Fs; % Time vector

figure;
subplot(4,1,1);
plot(t, unipolar, 'LineWidth', 1.5);
title('Unipolar NRZ');
xlabel('Time (s)'); ylabel('Amplitude'); grid on; ylim([-1.5 1.5]);

subplot(4,1,2);
plot(t, polar, 'LineWidth', 1.5);
title('Polar NRZ');
xlabel('Time (s)'); ylabel('Amplitude'); grid on; ylim([-1.5 1.5]);

subplot(4,1,3);
plot(t, manchester, 'LineWidth', 1.5);
title('Manchester Encoding');
xlabel('Time (s)'); ylabel('Amplitude'); grid on; ylim([-1.5 1.5]);

subplot(4,1,4);
plot(t, bipolar, 'LineWidth', 1.5);
title('Bipolar AMI');
xlabel('Time (s)'); ylabel('Amplitude'); grid on; ylim([-1.5 1.5]);

%% Step 5: Power Spectral Density (PSD) Estimation (2x2 layout)
figure;
subplot(2,2,1);
pwelch(unipolar, [], [], [], Fs);
title('PSD of Unipolar NRZ');

subplot(2,2,2);
pwelch(polar, [], [], [], Fs);
title('PSD of Polar NRZ');

subplot(2,2,3);
pwelch(manchester, [], [], [], Fs);
title('PSD of Manchester Encoding');

subplot(2,2,4);
pwelch(bipolar, [], [], [], Fs);
title('PSD of Bipolar AMI');

sgtitle('Power Spectral Densities of Line Codes (2x2 Grid)');
