clc;
clearvars;
X= [1 2 3 4 5 6 7]
prob= [ 0.4 0.25 0.15 0.1 0.05 0.03 0.02]
[dict, avglen]= huffmandict(X, prob)
H = -sum(prob.*log2(prob))
fprintf("Code Efficiency= %.4f \n",H/avglen);

encodedData = huffmanenco(X, dict);
decodedData = huffmandeco(encodedData, dict);
isequal(X, decodedData)
