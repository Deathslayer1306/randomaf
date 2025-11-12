% DSSS Demonstration Script
clc; clear; close all;
%% Parameters
dataLength = 10; % Number of data bits
chipRate = 8; % Chips per bit
Fs = 1000; % Sampling frequency for plotting
%% 1. Generate Binary Data Sequence
data = randi([0 1], 1, dataLength);
data_bipolar = 2*data - 1; % Convert to bipolar (-1, 1)
%% 2. Generate PN Sequence
pn_seq = randi([0 1], 1, dataLength * chipRate);
pn_bipolar = 2*pn_seq - 1;
%% 3. Spread the Data
spread_data = repelem(data_bipolar, chipRate) .* pn_bipolar;
%% 4. Time-Domain Plots
t_data = linspace(0, dataLength, dataLength * chipRate);
figure;
subplot(4,1,1);
stairs(repelem(data_bipolar, chipRate), 'LineWidth', 1.5);
title('Original Data (Bipolar)');
ylim([-1.5 1.5]); grid on;
subplot(4,1,2);
stairs(pn_bipolar, 'LineWidth', 1.5);
title('PN Sequence (Bipolar)');
ylim([-1.5 1.5]); grid on;
subplot(4,1,3);
stairs(spread_data, 'LineWidth', 1.5);
title('DSSS Signal (Spread Data)');
ylim([-1.5 1.5]); grid on;
%% 5. Frequency-Domain Plots
NFFT = 1024;
f = linspace(-Fs/2, Fs/2, NFFT);
data_fft = abs(fftshift(fft(repelem(data_bipolar, chipRate), NFFT)));
pn_fft = abs(fftshift(fft(pn_bipolar, NFFT)));
spread_fft = abs(fftshift(fft(spread_data, NFFT)));
figure;
plot(f, data_fft, 'r', 'LineWidth', 1.2); hold on;
plot(f, pn_fft, 'g', 'LineWidth', 1.2);
plot(f, spread_fft, 'b', 'LineWidth', 1.2);
legend('Data', 'PN Sequence', 'Spread Signal');
title('Frequency Domain Representation');
xlabel('Frequency (Hz)');
ylabel('Magnitude');
grid on;
%% 6. Despreading and Data Recovery
recovered = spread_data .* pn_bipolar;
recovered_bits = reshape(recovered, chipRate, []);
recovered_data = sum(recovered_bits) > 0;
disp('Original Data:');
disp(data);
disp('Recovered Data:');
disp(recovered_data);
%% Plot Recovered Data
figure(1);
subplot(4,1,4)
stairs(repelem(2*recovered_data - 1, chipRate), 'LineWidth', 1.5);
title('Recovered Data (Bipolar)');
ylim([-1.5 1.5]); grid on