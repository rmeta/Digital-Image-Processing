Img=imread('C:\Users\armita\Desktop\AnalogScan.jpg');
i=255-Img;
y=im2double(i);
figure(1);
imshow( y );

gray = 0.2989 * y(:,:,1) + 0.5870 * y(:,:,2) + 0.1140 * y(:,:,3);
figure(2);
imshow( gray );

ipict = (Img(:,:,1) + Img(:,:,2) + Img(:,:,3))/3;
figure(3);
imshow( ipict);

figure(4);
imhist(gray);

figure(5);
imhist(ipict);

figure(6)
a = histeq(gray)
imshow(a)

figure(7)
imhist(a);

figure(8)
b = histeq(ipict)
imshow(b)

figure(9)
imhist(b);