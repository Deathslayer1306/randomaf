clear; clc; close all;
%% Step 1: Read Audio File
% Select an audio file interactively (no need to hardcode path)
[filename, pathname] = uigetfile({'*.mp3;*.wav', 'Audio Files (*.mp3, *.wav)'}, 'Select an audio file');
if isequal(filename,0)
    error('No file selected. Please choose an audio file.');
end
filePath = fullfile(pathname, filename);

% Renamed 'audio' to 'originalAudio' to resolve the naming conflict with the script 'audio.m'
[originalAudio, fs] = audioread(filePath);
originalAudio = mean(originalAudio, 2); % Convert to mono if stereo

% Limit to first 2 seconds for faster simulation
if length(originalAudio) >= fs*2
    originalAudio = originalAudio(1:fs*2);
end

fprintf('Audio file loaded: %s\n', filePath);
fprintf('Sampling Frequency: %d Hz\n', fs);

%% Step 2: Quantization Parameters
numBits = 16; % Quantization precision
minVal = min(originalAudio);
maxVal = max(originalAudio);
quantLevels = 2^numBits;

% Quantize the audio
audio_q = round((originalAudio - minVal) / (maxVal - minVal) * (quantLevels - 1));
audio_q = uint16(audio_q); % Ensure integer type for de2bi

%% Step 3: Channel Simulation Parameters
q_values = [0 0.0001 0.001 0.005 0.01 0.02]; % Bit error probabilities
MSE_values = zeros(size(q_values)); % To store computed MSE
bitsPerSymbol = numBits;

%% Step 4: Transmission and Error Simulation
for i = 1:length(q_values)
    q = q_values(i);
    fprintf('\nSimulating for q = %.4f ...\n', q);

    % Convert quantized values to binary stream
    binStream = de2bi(audio_q, bitsPerSymbol, 'left-msb');
    binStream = binStream(:); % Flatten to single column

    % Add random bit errors according to probability q (Binary Symmetric Channel)
    errorMask = rand(size(binStream)) < q;
    rxBinStream = xor(binStream, errorMask);

    % Convert binary stream back to integers
    rxBinMatrix = reshape(rxBinStream, [], bitsPerSymbol);
    rxIdx = bi2de(rxBinMatrix, 'left-msb');

    % Clip to valid quantization range
    rxIdx = min(max(rxIdx, 0), quantLevels - 1);

    % Map decoded indices back to quantized values
    audio_q_decoded = rxIdx;

    %% Step 5: Dequantization
    decodedAudio = (audio_q_decoded / (quantLevels - 1)) * (maxVal - minVal) + minVal;

    % Normalize to prevent clipping (optional safety step)
    decodedAudio = decodedAudio / max(abs(decodedAudio));

    %% Step 6: Compute Mean Squared Error (MSE)
    % MSE is calculated between the original audio and the decoded audio
    MSE_values(i) = mean((originalAudio - decodedAudio).^2);
    fprintf('MSE for q = %.4f is %.8f\n', q, MSE_values(i));
end

%% Step 7: Plot MSE vs Channel Error Probability
figure;
plot(q_values, MSE_values, '-o', 'LineWidth', 1.5);
xlabel('Channel Probability of Error (q)');
ylabel('Mean Squared Error (MSE)');
title('MSE vs Channel Error Probability (BSC Simulation)');
grid on;

%% Step 8: Save and Play Last Decoded Audio
audiowrite('decoded_audio.wav', decodedAudio, fs);
disp('✅ Decoded audio for last q value saved as "decoded_audio.wav".');

% Optional: Play original and decoded audio for comparison
choice = questdlg('Do you want to play original and decoded audio?', 'Audio Playback', 'Yes', 'No', 'No');
if strcmp(choice, 'Yes')
    disp('Playing Original Audio...');
    sound(originalAudio, fs);
    pause(length(originalAudio)/fs + 1);
    disp('Playing Decoded Audio...');
    sound(decodedAudio, fs);
end