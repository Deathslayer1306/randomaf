pkg load image;
clc; clear; close all;
path = "C:/Users/Mihir/Downloads/OneDrive_2026-02-09/Sample images/lena.tif";

img = imread(path);
if size(img, 3) == 3
    img = rgb2gray(img);
end

img_plus  = imadd(img, 40);
img_minus = imsubtract(img, 40);

subplot(2,3,1);
imshow(img);
title("Original");
subplot(2,3,2);
imshow(img_plus);
title("Bright (+40)");
subplot(2,3,3);
imshow(img_minus);
title("Dark (-40)");

subplot(2,3,4);
imhist(img);
title("Original Hist");
subplot(2,3,5);
imhist(img_plus);
title("Bright Hist");
subplot(2,3,6);
imhist(img_minus);
title("Dark Hist");

pkg load image;
clc; clear; close all;


I = imread("C:/Users/Admin/Downloads/OneDrive_2026-02-09/Sample images/lena.tif");
if size(I, 3) == 3
    I = rgb2gray(I);
end
I = double(I);
I_high = I * 1.5;
I_low  = I * 0.6;
I_high = uint8(min(real(I_high), 255));
I_low  = uint8(real(I_low));

subplot(2,2,1); imshow(I_high); title("High Contrast (1.5x)");
subplot(2,2,2); imshow(I_low);  title("Low Contrast (0.6x)");

subplot(2,2,3); imhist(I_high); title("Expanded Histogram");
subplot(2,2,4); imhist(I_low);  title("Compressed Histogram");




I = imread("C:/Users/Admin/Downloads/OneDrive_2026-02-09/Sample images/lena.tif");
if size(I, 3) == 3, I = rgb2gray(I);
   end

if prctile(I(:), 75) < 100
    disp("Image identified as DULL. Applying enhancement...");

    I_enh = immultiply(I, 1.5);
else
    disp("Image is bright enough. Applying subtle adjustment.");
    I_enh = immultiply(I, 1.1);
end
figure;
subplot(2,2,1); imshow(I);     title("Original (Dull)");
subplot(2,2,2); imshow(I_enh); title("Enhanced (Multiplication)");



subplot(2,2,3); imhist(I);     title("Original: Narrow/Dark Hist");
subplot(2,2,4); imhist(I_enh); title("Enhanced: Stretched Hist");
