clc;
clear;
close all;
%%
%read image-1
Im1=imread('C:\Users\armita\Desktop\1.png');
I1 = im2double(Im1);


Im2=imread('C:\Users\armita\Desktop\2.png');
%Im2 = (Im2(:,:,1) + Im2(:,:,2) + Im2(:,:,3))/3;
I2 = im2double(Im2);
I2 = rgb2gray(I2);

Im3=imread('C:\Users\armita\Desktop\donald.png');
%Im3 = (Im3(:,:,1) + Im3(:,:,2) + Im3(:,:,3))/3;
I3 = im2double(Im3);
I3 = rgb2gray(I3);
%%
%Transform time-domain data to the frequency domain-2
I1f = fft2(I1);
I1s = abs(I1f);
logf1 = log(1+ I1s);
shift1 = fftshift(logf1);

I2f = fft2(I2);
I2s = abs(I2f);
logf2 = log(1+ I2s);
shift2 = fftshift(logf2);

I3f = fft2(I3);
I3s = abs(I3f);
logf3 = log(1+ I3s);
shift3 = fftshift(logf3);
%%
%plot-3 
subplot(2,1,1)
imshow(I1)
title('original')
subplot(2,1,2)
imshow(shift1, [])
h = gca;
h.Visible = 'On';
title('FFT2 transform')
%subplot(3,1,3)
%bar(shift2)
%title('FFT shift')

figure(2)
subplot(2,1,1)
imshow(I2)
title('original')
subplot(2,1,2)
imshow(shift2, [])
h = gca;
h.Visible = 'On';
title('FFT2 transform')
%subplot(3,1,3)
%bar(shift2)
%title('FFT shift')

figure(3)
subplot(2,1,1)
imshow(I3)
title('original')
subplot(2,1,2)
imshow(shift3, [])
h = gca;
h.Visible = 'On';
title('FFT2 transform')
%subplot(3,1,3)
%bar(shift3)
%title('FFT shift')
%%
%noise reduction - pic1 - 4
four = fft2(I1); 
shif2 = fftshift(four);
for j = 115:125
    for n = 10:20
        shif2(n,j) = 0; 
    end
    for n = 95:105
        shif2(n,j) = 0; 
    end
    for n = 215:225
        shif2(n,j) = 0; 
    end
    for n = 275:285
        shif2(n,j) = 0; 
    end
    for n = 300:310
        shif2(n,j) = 0; 
    end
  end

back = real(ifft2(ifftshift(shif2)));
figure(4)
subplot(2,1,1)
imshow(I1)
title('original')
subplot(2,1,2)
imshow(back,[]);
%%
%noise reduction - pic2 - 4
four2 = fft2(I2); 

keep_fraction = 0.05

[r,c] = size(I2)
[r1,c1] = size(four2)
first=r*keep_fraction
second = r*(1-keep_fraction)
first = cast(first,"int8")
second = cast(second,"int8")
first1=c*keep_fraction

second1 = c*(1-keep_fraction)
first1 = cast(first1,"int8")
second1 = cast(second1,"int8")

for q = first:second
        four2(:,q) = 0; 
end

for s = first1:second1
        four2(s,:) = 0; 
end


back2 = real(ifft2((four2)));
figure(5)
subplot(2,1,1)
imshow(I2)
title('original')
subplot(2,1,2)
imshow(back2,[]);

figure;
imshow(back2,[]);
%%
%noise reduction - pic3 - 4
four3 = fft2(I3); 
four3  = fftshift(four3);

for j = 1:10
    for n = 10:20
        four3(n,j) = 0; 
    end
    for n = 85:93
        four3(n,j) = 0; 
    end
end

for j = 15:25
    for n = 210:220
        four3(n,j) = 0; 
    end
end

for j = 83:93
    for n = 12:22
        four3(n,j) = 0; 
    end
    for n = 85:95
        four3(n,j) = 0; 
    end
end

for j = 95:105
    for n = 210:220
        four3(n,j) = 0; 
    end
end

for j = 175:185
    for n = 55:65
        four3(n,j) = 0; 
    end
    for n = 270:280
        four3(n,j) = 0; 
    end
end

for j = 145:155
    for n = 230:240
        four3(n,j) = 0; 
    end
end

for j = 225:235
    for n = 220:230
        four3(n,j) = 0; 
    end
    for n = 70:80
        four3(n,j) = 0; 
    end
end

for j = 235:245
    for n = 200:210
        four3(n,j) = 0; 
    end
    for n = 270:280
        four3(n,j) = 0; 
    end
end

for j = 305:310
    for n = 72:82
        four3(n,j) = 0; 
    end
end

%// Change
back = real(ifft2(ifftshift(four3)));
figure(4)
subplot(2,1,1)
imshow(I3)
title('original')
subplot(2,1,2)
imshow(back,[]);
%%
% Saving the size of the input_image in pixels-
[m, n] = size(I1);

%centre
x = round(m/2)
y = round(n/2)

% Assign Cut-off Frequency  
fc = median(abs(I1(:)-median(I1(:))))/0.6745*100 

%kernel
H = zeros(m,n);
for i = 1:m
    for j = 1:n
        d = (i-x).^2 + (j-y).^2;
        H(i,j) = exp(-d/2/fc/fc);
    end
end


FT_img = fftshift(fft2(I1));
G = H.*FT_img;
output_image = abs(ifft2(G));
subplot(2, 1, 1), imshow(I1),
subplot(2, 1, 2), imshow(output_image, [ ]);
%%
[m, n] = size(I2);

%centre
x = round(m/2)
y = round(n/2)

% Assign Cut-off Frequency  
fc = median(abs(I2(:)-median(I2(:))))/0.6745*100 

%kernel
H = zeros(m,n);
for i = 1:m
    for j = 1:n
        d = (i-x).^2 + (j-y).^2;
        H(i,j) = exp(-d/2/fc/fc);
    end
end

FT_img = fftshift(fft2(I2));
G = H.*FT_img;
output_image = abs(ifft2(G));
subplot(2, 1, 1), imshow(I2),
subplot(2, 1, 2), imshow(output_image, [ ]);
%%
%i3
[m, n] = size(I3);

%centre
x = round(m/2)
y = round(n/2)

% Assign Cut-off Frequency  
fc = median(abs(I3(:)-median(I3(:))))/0.6745*100 

%kernel
H = zeros(m,n);
for i = 1:m
    for j = 1:n
        d = (i-x).^2 + (j-y).^2;
        H(i,j) = exp(-d/2/fc/fc);
    end
end

FT_img = fftshift(fft2(I3));
G = H.*FT_img;
output_image = abs(ifft2(G));
subplot(2, 1, 1), imshow(I3),
subplot(2, 1, 2), imshow(output_image, [ ]);
%%
%q2
%%tokyo

tokyo = get_sharpness('C:\\Users\\armita\\Desktop\\%d_blurred_tokyo.jpg');
fprintf('the best tokyo image is:')
find_best_focus(1, 41, tokyo)
%%
%%damavand

a = get_sharpness('C:\\Users\\armita\\Desktop\\%d_blurred_damavand.jpg');
fprintf('the best damavand image is:')
find_best_focus(1, 41, a)

%%
function best_focus = find_best_focus(left, right, get_sharpness)   
    while right ~= left        
        mid = round((left + right) / 2);
        mid_sharpness = get_sharpness(mid);
        if mid_sharpness < get_sharpness(mid - 1)            
            left = mid;
        elseif mid_sharpness < get_sharpness(mid + 1)            
            right = mid;
        else            
            break;
        end    
    end
    best_focus = (left + right) / 2;
end


function sharpness = get_sharpness(index)
    num_images=41
    for i = 1:num_images;
    filename = sprintf(index, i);
    img = imread(filename);
    gray_img = rgb2gray(img);
    laplacian_kernel = [0 1 0; 1 -4 1; 0 1 0];
    filtered_image = conv2(double(gray_img), laplacian_kernel, 'same');
    figure;
    imshow(filtered_image)
    sharpness(i) = var(filtered_image(:));     
    end
    figure;
    bar(sharpness);
    xlabel('Image Number');
    ylabel('Focus Metric');
    title('Focus Metrics for 41 Images');  
    [best_metric, best_index] = max(sharpness);
    fprintf('The image with the best focus is %d with a focus metric of %f.\n', best_index, best_metric);
end