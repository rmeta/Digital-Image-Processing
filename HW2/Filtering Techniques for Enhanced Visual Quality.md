<h2>Image Processing and Histogram Equalization</h2>
<p>In this section, we read an image, convert it to grayscale, and perform histogram equalization.</p>

<pre><code>
% Read and process the image
Img = imread('C:\\Users\\armita\\Desktop\\AnalogScan.jpg'); % Load the image
i = 255 - Img; % Invert the image colors
y = im2double(i); % Convert the image to double precision
figure(1);
imshow(y); % Display the inverted image

gray = 0.2989 * y(:,:,1) + 0.5870 * y(:,:,2) + 0.1140 * y(:,:,3); % Convert to grayscale
figure(2);
imshow(gray); % Display the grayscale image

ipict = (Img(:,:,1) + Img(:,:,2) + Img(:,:,3)) / 3; % Average the RGB channels
figure(3);
imshow(ipict); % Display the average image

figure(4);
imhist(gray); % Display the histogram of the grayscale image

figure(5);
imhist(ipict); % Display the histogram of the average image

figure(6);
a = histeq(gray); % Apply histogram equalization to the grayscale image
imshow(a); % Display the equalized grayscale image

figure(7);
imhist(a); % Display the histogram of the equalized grayscale image

figure(8);
b = histeq(ipict); % Apply histogram equalization to the average image
imshow(b); % Display the equalized average image

figure(9);
imhist(b); % Display the histogram of the equalized average image
</code></pre>

<h2>Histogram Analysis of Multiple Images</h2>
<p>This section analyzes the histograms of several images by reading them and plotting their histograms.</p>

<pre><code>
clc;
clear;
close all;

subplot(2,3,1);
I1 = imread('C:\\Users\\armita\\Desktop\\1008_IM-0009-2001.dcm.png'); % Load the first image
y = im2double(I1); % Convert to double precision
imhist(y); % Display the histogram

subplot(2,3,2);
I2 = imread('C:\\Users\\armita\\Desktop\\1012_IM-0013-1001.dcm.png'); % Load the second image
a = im2double(I2); % Convert to double precision
imhist(a); % Display the histogram

subplot(2,3,3);
I3 = imread('C:\\Users\\armita\\Desktop\\1014_IM-0013-1001.dcm.png'); % Load the third image
b = im2double(I3); % Convert to double precision
imhist(b); % Display the histogram

subplot(2,3,4);
I4 = imread('C:\\Users\\armita\\Desktop\\1028_IM-0022-1001.dcm.png'); % Load the fourth image
c = im2double(I4); % Convert to double precision
imhist(c); % Display the histogram

subplot(2,3,5);
I5 = imread('C:\\Users\\armita\\Desktop\\1053_IM-0040-1001.dcm.png'); % Load the fifth image
d = im2double(I5); % Convert to double precision
imhist(y); % Display the histogram

subplot(2,3,6);
I6 = imread('C:\\Users\\armita\\Desktop\\1056_IM-0040-1003.dcm.png'); % Load the sixth image
e = im2double(I6); % Convert to double precision
imhist(e); % Display the histogram
</code></pre>

<h2>Histogram Equalization and Filtering</h2>
<p>This section applies histogram equalization to several images and then performs filtering.</p>

<pre><code>
figure(2);
subplot(2,3,1);
Y = histeq(y); % Apply histogram equalization to the first image
gray = 0.2989 * Y(:,:,1) + 0.5870 * Y(:,:,2) + 0.1140 * Y(:,:,3); % Convert to grayscale
imshow(gray); % Display the grayscale image

subplot(2,3,2);
A = histeq(a); % Apply histogram equalization to the second image
gray1 = 0.2989 * A(:,:,1) + 0.5870 * A(:,:,2) + 0.1140 * A(:,:,3); % Convert to grayscale
imshow(gray1); % Display the grayscale image

subplot(2,3,3);
B = histeq(b); % Apply histogram equalization to the third image
gray2 = 0.2989 * B(:,:,1) + 0.5870 * B(:,:,2) + 0.1140 * B(:,:,3); % Convert to grayscale
imshow(gray2); % Display the grayscale image

subplot(2,3,4);
C = histeq(c); % Apply histogram equalization to the fourth image
gray3 = 0.2989 * C(:,:,1) + 0.5870 * C(:,:,2) + 0.1140 * C(:,:,3); % Convert to grayscale
imshow(gray3); % Display the grayscale image

subplot(2,3,5);
D = histeq(d); % Apply histogram equalization to the fifth image
gray4 = 0.2989 * D(:,:,1) + 0.5870 * D(:,:,2) + 0.1140 * D(:,:,3); % Convert to grayscale
imshow(gray4); % Display the grayscale image

subplot(2,3,6);
E = histeq(e); % Apply histogram equalization to the sixth image
gray5 = 0.2989 * E(:,:,1) + 0.5870 * E(:,:,2) + 0.1140 * E(:,:,3); % Convert to grayscale
imshow(gray5); % Display the grayscale image
</code></pre>

<h2>Filtering and Equalization</h2>
<p>This section applies filtering and equalization processes to the images and their histograms.</p>

<pre><code>
figure;
subplot(2,3,1);
imhist(y); % Display the histogram of the original image
title("raw image");

y_gray = 0.2989 * y(:,:,1) + 0.5870 * y(:,:,2) + 0.1140 * y(:,:,3); % Convert to grayscale
subplot(2,3,2);
imhist(y_gray); % Display the histogram of the grayscale image
title("gray image");

subplot(2,3,3);
y_filtered = y_gray;
y_filtered = medfilt2(y_filtered, [5,5]); % Apply median filtering
y_filtered(y_filtered < 0.09) = 0; % Thresholding
imhist(y_filtered); % Display the histogram of the filtered image
title("filtered image");

subplot(2,3,4);
y_equalized = histeq(y_filtered); % Apply histogram equalization
imhist(y_equalized); % Display the histogram of the equalized image
title("equalized image");

subplot(2,3,5);
y_filtered_eq = y_equalized;
y_filtered_eq = medfilt2(y_filtered_eq, [5,5]); % Apply median filtering again
imhist(y_filtered_eq); % Display the histogram of the filtered and equalized image
title("filtered and equalized image");

subplot(2,3,6);
y_2eq_filtered = histeq(y_filtered_eq); % Apply histogram equalization again
imhist(y_2eq_filtered); % Display the histogram of the final image
title("final image");

figure;
subplot(2,3,1);
imshow(y); % Display the original image
title("raw image");

subplot(2,3,2);
imshow(y_gray); % Display the grayscale image
title("gray image");

subplot(2,3,3);
imshow(y_filtered); % Display the filtered image
title("filtered image");

subplot(2,3,4);
imshow(y_equalized); % Display the equalized image
title("equalized image");

subplot(2,3,5);
imshow(y_filtered_eq); % Display the filtered and equalized image
title("filtered and equalized image");

subplot(2,3,6);
imshow(y_2eq_filtered); % Display the final image
title("final image");
</code></pre>

<h2>Additional Image Processing and Equalization</h2>
<p>This section repeats similar processing steps for different images.</p>

<pre><code>
figure;
subplot(2,3,1);
imhist(a); % Display the histogram of the original image
title("raw image");

a_gray = 0.2989 * a(:,:,1) + 0.5870 * a(:,:,2) + 0.1140 * a(:,:,3); % Convert to grayscale
subplot(2,3,2);
imhist(a_gray); % Display the histogram of the grayscale image
title("gray image");

subplot(2,3,3);
a_filtered = a_gray;
a_filtered = medfilt2(a_filtered, [5,5]); % Apply median filtering
imhist(a_filtered); % Display the histogram of the filtered image
title("filtered image");

subplot(2,3,4);
a_equalized = histeq(a_filtered); % Apply histogram equalization
imhist(a_equalized); % Display the histogram of the equalized image
title("equalized image");

subplot(2,3,5);
a_filtered_eq = a_equalized;
a_filtered_eq = medfilt2(a_filtered_eq, [5,5]); % Apply median filtering again
imhist(a_filtered_eq); % Display the histogram of the filtered and equalized image
title("filtered and equalized image");

subplot(2,3,6);
a_2eq_filtered = histeq(a_filtered_eq); % Apply histogram equalization again
imhist(a_2eq_filtered); % Display the histogram of the final image
title("final image");
</code></pre>

</body>
</html>
