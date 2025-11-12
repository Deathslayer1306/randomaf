%% --- Step 1: Input Message ---
msg = 'SOURAV 3023149 20/09/25';

symbols = unique(msg);
freq = histc(double(msg), double(symbols));  % Frequency of each symbol

%% --- Step 2: Huffman Encoding ---
[dict, avglen] = huffmandict(num2cell(symbols), freq / sum(freq));
msgCell = num2cell(msg);
huffEnc = huffmanenco(msgCell, dict);

% Compression statistics
orig_bits = length(msg) * 8;   % ASCII = 8 bits per character
comp_bits = length(huffEnc);
compression_ratio = orig_bits / comp_bits;

fprintf('Original length: %d bits\n', orig_bits);
fprintf('Huffman encoded length: %d bits\n', comp_bits);
fprintf('Compression Ratio: %.2f\n\n', compression_ratio);

%% --- Step 3: Hamming (7,4) Encoding ---
padLen = mod(4 - mod(length(huffEnc), 4), 4);
huffEncPadded = [huffEnc zeros(1, padLen)];

% Generator matrix for (7,4) Hamming code
G = [1 0 0 0 1 1 0;
     0 1 0 0 1 0 1;
     0 0 1 0 0 1 1;
     0 0 0 1 1 1 1];

hammingEnc = [];
for i = 1:4:length(huffEncPadded)
    dataBits = huffEncPadded(i:i+3);
    codeword = mod(dataBits * G, 2);
    hammingEnc = [hammingEnc codeword];
end

%% --- Step 4–6: Channel Simulation & BER Calculation ---
% Parity check matrix (H) for (7,4) Hamming code
H = [1 0 1 0 1 0 1;
     0 1 1 0 0 1 1;
     0 0 0 1 1 1 1];

pVals = [0.001 0.006 0.011 0.016 0.021 0.026 0.031 0.036 0.041 0.046];
ber_before = zeros(size(pVals));
ber_after = zeros(size(pVals));

for k = 1:length(pVals)
    p = pVals(k);

    % Binary Symmetric Channel (simulate bit flips)
    rxBits = mod(hammingEnc + (rand(size(hammingEnc)) < p), 2);

    % Hamming Decoding
    decodedBits = [];
    for i = 1:7:length(rxBits)
        r = rxBits(i:i+6);
        syndrome = mod(H * r', 2)';

        if any(syndrome)
            [~, errPos] = ismember(syndrome, H', 'rows');
            if errPos > 0
                r(errPos) = mod(r(errPos) + 1, 2); % Correct the bit
            end
        end
        decodedBits = [decodedBits r(1:4)];
    end

    % Remove padding
    decodedBits = decodedBits(1:end - padLen);

    % BER Calculation
    ber_before(k) = mean(hammingEnc ~= rxBits);   % before correction
    ber_after(k)  = mean(huffEnc ~= decodedBits); % after correction
end

%% --- Step 7: Decode Huffman Data Back to Message ---
decodedCell = huffmandeco(decodedBits, dict);
decodedMsg = cell2mat(decodedCell);

%% --- Step 8: Display Results ---
fprintf('Original Message: %s\n', msg);
fprintf('Decoded Message : %s\n\n', decodedMsg);

%% --- Step 9: Plot BER Graph ---
figure;
plot(pVals, ber_before, '-o', 'LineWidth', 2); hold on;
plot(pVals, ber_after, '-s', 'LineWidth', 2);
xlabel('Error Probability (p)');
ylabel('Bit Error Rate (BER)');
legend('Before Correction', 'After Correction');
title('BER vs Channel Error Probability');
grid on;
