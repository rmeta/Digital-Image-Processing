clc;
clear;
close all;
%%

subplot(2,3,1)
I1=imread('C:\Users\armita\Desktop\1008_IM-0009-2001.dcm.png');
y=im2double(I1);
imhist(y);

subplot(2,3,2)
I2=imread('C:\Users\armita\Desktop\1012_IM-0013-1001.dcm.png');
a=im2double(I2);
imhist(a);

subplot(2,3,3)
I3=imread('C:\Users\armita\Desktop\1014_IM-0013-1001.dcm.png');
b=im2double(I3);
imhist(b);

subplot(2,3,4)
I4=imread('C:\Users\armita\Desktop\1028_IM-0022-1001.dcm.png');
c=im2double(I4);
imhist(c);


subplot(2,3,5)
I5=imread('C:\Users\armita\Desktop\1053_IM-0040-1001.dcm.png');
d=im2double(I5);
imhist(y);

subplot(2,3,6)
I6=imread('C:\Users\armita\Desktop\1056_IM-0040-1003.dcm.png');
e=im2double(I6);
imhist(e);
%%

figure(2)
subplot(2,3,1)
Y = histeq(y);
gray = 0.2989 * Y(:,:,1) + 0.5870 * Y(:,:,2) + 0.1140 * Y(:,:,3);
imshow(gray);

subplot(2,3,2)
A = histeq(a);
gray1 = 0.2989 * A(:,:,1) + 0.5870 * A(:,:,2) + 0.1140 * A(:,:,3);
imshow(gray1);

subplot(2,3,3)
B = histeq(b);
gray2 = 0.2989 * B(:,:,1) + 0.5870 * B(:,:,2) + 0.1140 * B(:,:,3);
imshow(gray2);

subplot(2,3,4)
C = histeq(c);
gray3 = 0.2989 * C(:,:,1) + 0.5870 * C(:,:,2) + 0.1140 * C(:,:,3);
imshow(gray3);

subplot(2,3,5)
D = histeq(d);
gray4 = 0.2989 * D(:,:,1) + 0.5870 * D(:,:,2) + 0.1140 * D(:,:,3);
imshow(gray4);

subplot(2,3,6)
E = histeq(e);
gray5 = 0.2989 * E(:,:,1) + 0.5870 * E(:,:,2) + 0.1140 * E(:,:,3);
imshow(gray5);
%%
figure(3)
subplot(2,3,1)
imshow(y)

subplot(2,3,2)
imshow(a)

subplot(2,3,3)
imshow(b)

subplot(2,3,4)
imshow(c)

subplot(2,3,5)
imshow(d)

subplot(2,3,6)
imshow(e)
%%
figure;
subplot(2,3,1);
imhist(y);
title("raw image");

y_gray = 0.2989 * y(:,:,1) + 0.5870 * y(:,:,2) + 0.1140 * y(:,:,3);
subplot(2,3,2);
imhist(y_gray);
title("gray image");

subplot(2,3,3);
y_filtered = y_gray;
y_filtered = medfilt2(y_filtered,[5,5]);
y_filtered(y_filtered<0.09) = 0;
imhist(y_filtered);
title("filtered image");

subplot(2,3,4);
y_equalized = histeq(y_filtered);
imhist(y_equalized);
title("equalized image");

subplot(2,3,5);
y_filtered_eq = y_equalized;
y_filtered_eq = medfilt2(y_filtered_eq,[5,5]);
imhist(y_filtered_eq);
title("filtered and equalized image");


subplot(2,3,6);
y_2eq_filtered = histeq(y_filtered_eq);
imhist(y_2eq_filtered);
title("final image");
%%
figure;
subplot(2,3,1);
imshow(y);
title("raw image");

subplot(2,3,2);
imshow(y_gray);
title("gray image");

subplot(2,3,3);
imshow(y_filtered);
title("filtered image");

subplot(2,3,4);
imshow(y_equalized);
title("equalized image");

subplot(2,3,5);
imshow(y_filtered_eq);
title("filtered and equalized image");

subplot(2,3,6);
imshow(y_2eq_filtered);
title("final image");
%%
figure;
subplot(2,3,1);
imhist(a);
title("raw image");

a_gray = 0.2989 * a(:,:,1) + 0.5870 * a(:,:,2) + 0.1140 * a(:,:,3);
subplot(2,3,2);
imhist(a_gray);
title("gray image");

subplot(2,3,3);
a_filtered = a_gray;
a_filtered = medfilt2(a_filtered,[5,5]);
%a_filtered(a_filtered<0.09) = 0;
imhist(a_filtered);
title("filtered image");

subplot(2,3,4);
a_equalized = histeq(a_filtered);
imhist(a_equalized);
title("equalized image");

subplot(2,3,5);
a_filtered_eq = a_equalized;
a_filtered_eq = imadjust(a_filtered_eq,[],[],.7);
imhist(a_filtered_eq);
title("filtered and equalized image");


subplot(2,3,6);
%a_2eq_filtered = imerode(a_filtered_eq, true(30));
a_2eq_filtered = histeq(a_filtered_eq);
a_2eq_filtered  = medfilt2(a_2eq_filtered ,[15,15]);
imhist(a_2eq_filtered);
title("final image");

figure;
subplot(2,3,1);
imshow(a);
title("raw image");

subplot(2,3,2);
imshow(a_gray);
title("gray image");

subplot(2,3,3);
imshow(a_filtered);
title("filtered image");

subplot(2,3,4);
imshow(a_equalized);
title("equalized image");

subplot(2,3,5);
imshow(a_filtered_eq);
title("filtered and equalized image");

subplot(2,3,6);
imshow(a_2eq_filtered);
title("final image");
%%
figure;
subplot(2,3,1);
imhist(b);
title("raw image");

b_gray = 0.2989 * b(:,:,1) + 0.5870 * b(:,:,2) + 0.1140 * b(:,:,3);
subplot(2,3,2);
imhist(b_gray);
title("gray image");

subplot(2,3,3);
a_filtered = b_gray;
a_filtered = imerode(a_filtered, true(4));
%a_filtered(a_filtered<0.09) = 0;
imhist(a_filtered);
title("filtered image");

subplot(2,3,4);
a_equalized = histeq(a_filtered);
imhist(a_equalized);
title("equalized image");

subplot(2,3,5);
a_filtered_eq = a_equalized;
a_filtered_eq = medfilt2(a_filtered_eq);
a_filtered_eq(a_filtered_eq<0.09) = 0;
a_filtered_eq = imadjust(a_filtered_eq,[],[],1.3);
imhist(a_filtered_eq);
title("filtered and equalized image");


subplot(2,3,6);
b_2eq_filtered = histeq(a_filtered_eq);
b_2eq_filtered = imadjust(b_2eq_filtered,[],[],1.5);
%b_2eq_filtered = adapthisteq(a_filtered_eq,'NumTiles',[6 6],'ClipLimit',0.009);
imhist(b_2eq_filtered);
title("final image");

figure;
subplot(2,3,1);
imshow(b);
title("raw image");

subplot(2,3,2);
imshow(b_gray);
title("gray image");

subplot(2,3,3);
imshow(a_filtered);
title("filtered image");

subplot(2,3,4);
imshow(a_equalized);
title("equalized image");

subplot(2,3,5);
imshow(a_filtered_eq);
title("filtered and equalized image");

subplot(2,3,6);
imshow(b_2eq_filtered);
title("final image");
%%
figure;
subplot(2,3,1);
imhist(c);
title("raw image");

y_gray = 0.2989 * c(:,:,1) + 0.5870 * c(:,:,2) + 0.1140 * c(:,:,3);
subplot(2,3,2);
imhist(y_gray);
title("gray image");

subplot(2,3,3);
y_filtered = y_gray;
y_filtered = medfilt2(y_filtered,[5,5]);
y_filtered(y_filtered<0.09) = 0;
imhist(y_filtered);
title("filtered image");

subplot(2,3,4);
y_equalized = histeq(y_filtered);
imhist(y_equalized);
title("equalized image");

subplot(2,3,5);
y_filtered_eq = y_equalized;
y_filtered_eq = medfilt2(y_filtered_eq,[7,7]);
imhist(y_filtered_eq);
title("filtered and equalized image");


subplot(2,3,6);
a_2eq_filtered = histeq(y_filtered_eq);
a_2eq_filtered = imadjust(a_2eq_filtered,[],[],1.2);
imhist(a_2eq_filtered);
title("final image");

figure;
subplot(2,3,1);
imshow(c);
title("raw image");

subplot(2,3,2);
imshow(y_gray);
title("gray image");

subplot(2,3,3);
imshow(y_filtered);
title("filtered image");

subplot(2,3,4);
imshow(y_equalized);
title("equalized image");

subplot(2,3,5);
imshow(y_filtered_eq);
title("filtered and equalized image");

subplot(2,3,6);
imshow(a_2eq_filtered);
title("final image");
%%
figure;
subplot(2,3,1);
imhist(d);
title("raw image");

d_gray = 0.2989 * d(:,:,1) + 0.5870 * d(:,:,2) + 0.1140 * d(:,:,3);
subplot(2,3,2);
imhist(d_gray);
title("gray image");

subplot(2,3,3);
d_filtered = d_gray;
d_filtered = imerode(d_filtered, true(9));

imhist(d_filtered);
title("filtered image");

subplot(2,3,4);
d_equalized = histeq(d_filtered);
imhist(d_equalized);
title("equalized image");

subplot(2,3,5);
d_filtered_eq = d_equalized;
d_filtered_eq = imadjust(d_filtered_eq,[],[],0.7);
d_filtered_eq(d_filtered_eq<0.15) = 0;
imhist(d_filtered_eq);
title("filtered and equalized image");


subplot(2,3,6);
d_2eq_filtered = histeq(d_filtered_eq);
d_2eq_filtered = imdilate(d_2eq_filtered, true(10));
imhist(d_2eq_filtered);
title("final image");

figure;
subplot(2,3,1);
imshow(d);
title("raw image");

subplot(2,3,2);
imshow(d_gray);
title("gray image");

subplot(2,3,3);
imshow(d_filtered);
title("filtered image");

subplot(2,3,4);
imshow(d_equalized);
title("equalized image");

subplot(2,3,5);
imshow(d_filtered_eq);
title("filtered and equalized image");

subplot(2,3,6);
imshow(d_2eq_filtered);
title("final image");
%%
figure;
subplot(2,3,1);
imhist(e);
title("raw image");

e_gray = 0.2989 * e(:,:,1) + 0.5870 * e(:,:,2) + 0.1140 * e(:,:,3);
subplot(2,3,2);
imhist(e_gray);
title("gray image");

subplot(2,3,3);
y_filtered = e_gray;
y_filtered = medfilt2(y_filtered,[5,5]);
y_filtered(y_filtered<0.09) = 0;
imhist(y_filtered);
title("filtered image");

subplot(2,3,4);
e_equalized = histeq(y_filtered);
imhist(e_equalized);
title("equalized image");

subplot(2,3,5);
e_filtered_eq = e_equalized;
e_filtered_eq = medfilt2(e_filtered_eq,[7,7]);
imhist(e_filtered_eq);
title("filtered and equalized image");


subplot(2,3,6);
%a_2eq_filtered = imerode(a_filtered_eq, true(30));
e_2eq_filtered = histeq(e_filtered_eq);
imhist(e_2eq_filtered);
title("final image");

figure;
subplot(2,3,1);
imshow(e);
title("raw image");

subplot(2,3,2);
imshow(e_gray);
title("gray image");

subplot(2,3,3);
imshow(y_filtered);
title("filtered image");

subplot(2,3,4);
imshow(e_equalized);
title("equalized image");

subplot(2,3,5);
imshow(e_filtered_eq);
title("filtered and equalized image");

subplot(2,3,6);
imshow(e_2eq_filtered);
title("final image");