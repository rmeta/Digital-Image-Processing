function [compressed, ratio] = jpegcomp(I1, qual)
    I = I1;
    imwrite(I1, 'my_image.jpg');
    if ndims(I1) == 3
        % Convert RGB image to grayscale
        I1 = rgb2gray(I1);
        imwrite(I1, 'my_image.jpg');
    end


    if mod(size(I1, 1), 8) ~= 0 || mod(size(I1, 2), 8) ~= 0
        % Resize the image to the nearest size that is divisible by 8
        I1 = imresize(I1, floor(size(I1)/8)*8);
    end
    
    file_info2 = dir('my_image.jpg');
    file_size2 = file_info2.bytes;
   

    [row coln]= size(I1);

    I1= double(I1);
    %---------------------------------------------------------
    % Subtracting each image pixel value by 128 
    %--------------------------------------------------------
    I1 = I1 - 128*ones(row, coln);

    %quality = input('What quality of compression you require - ');
    quality = qual;

    %----------------------------------------------------------
    % Quality Matrix Formulation
    %----------------------------------------------------------
    Q50 = [ 16 11 10 16 24 40 51 61;
         12 12 14 19 26 58 60 55;
         14 13 16 24 40 57 69 56;
         14 17 22 29 51 87 80 62; 
         18 22 37 56 68 109 103 77;
         24 35 55 64 81 104 113 92;
         49 64 78 87 103 121 120 101;
         72 92 95 98 112 100 103 99];
   
    % Quality scaling factor
    if quality < 50
        scale = floor(5000 / quality);
    else
        scale = 200 - 2 * quality;
    end
   
    % Scale the base matrix based on the quality factor
    QX = floor((scale * Q50 + 50) / 100);
   
    % Ensure that the matrix elements are within the valid range (1 to 255)
    QX = max(1, min(QX, 255));





    dct_restored = zeros(row,coln);
    QX = double(QX);

    DCT_matrix8 = dct(eye(8));
    iDCT_matrix8 = DCT_matrix8'; 



    for i1=[1:8:row]
        for i2=[1:8:coln]
            zBLOCK=I1(i1:i1+7,i2:i2+7);
            win1=DCT_matrix8*zBLOCK*iDCT_matrix8;
            dct_domain(i1:i1+7,i2:i2+7)=win1;
        end
    end


    %quantization
    for i1=[1:8:row]
        for i2=[1:8:coln]
            win1 = dct_domain(i1:i1+7,i2:i2+7);
            win2=round(win1./QX);
            dct_quantized(i1:i1+7,i2:i2+7)=win2;
        end
    end


    sum = 0;
    % Build the Huffman dictionary
    for i1=[1:8:row]
        for i2=[1:8:coln]
            win2 = dct_quantized(i1:i1+7,i2:i2+7);
            win3 = zigzagi(win2);
            % Calculate the unique symbols and their probabilities
            symbols = unique(win3);
            probabilities = histcounts(win3, length(symbols)) / numel(win3);
            dict = huffmandict(symbols, probabilities);
            % Encode the array using Huffman coding
            encoded = huffmanenco(win3, dict);
            sum = sum + numel(encoded);
            [ro, co] = size(win2);
            S = [ro co];
            decoded_Y = huffmandeco(encoded, dict);
            % Reshape the decoded image to its original size
            decoded_Y = reshape(decodeZigzag(decoded_Y, ro, co), S);
            w3 = decoded_Y.*QX;
            w2= round(round(iDCT_matrix8*w3*DCT_matrix8,1));
            w1 = w2+128;
            dct_restored(i1:i1+7,i2:i2+7)=w1;
        end
    end




    I2=dct_restored;
    K=mat2gray(I2);
    
    
    imwrite(K, 'my_image_resized.jpg');

    % Get the size of the saved file
    file_info = dir('my_image_resized.jpg');
    file_size = file_info.bytes;

    
 

    % Display the file size
    disp(['File size: ' num2str(file_size) ' bytes']);
    disp(['File size origin: ' num2str(file_size2) ' bytes']);
    
  
    % Compute the compression ratio
    originalSize = numel(I1);
    compressedSize = numel(K);
    ratio = file_size2/file_size;
    %----------------------------------------------------------
    %Display of Results
    %----------------------------------------------------------
    %figure(1);imshow(K)%title('restored image from dct');
    % Display the compression ratio
    compressed = K;
    %disp("Compression Ratio: " + compressionRatio);

    % Display the original and decoded images
    %figure;
    %subplot(1, 2, 1);
    %imshow(QI);
    %title('Original Image');


    %sample = unique(y)
    %prob = sample/numel(y)
    %dict_Y = huffmandict(sample,prob);


    function out = zigzagi(in)
    % Initialize variables
    %----------------------------------
    h = 1;
    v = 1;
    vmin = 1;
    hmin = 1;
    vmax = size(in, 1);
    hmax = size(in, 2);
    i = 1;

    % Main loop
    %----------------------------------
    out = zeros(1, vmax * hmax);
    while ((v <= vmax) && (h <= hmax))
        if (mod(h + v, 2) == 0)                 % going up
            if (v == vmin)
                out(i) = in(v, h);              % if we got to the first line
                if (h == hmax)
                    v = v + 1;
                else
                    h = h + 1;
                end;
                i = i + 1;
            elseif ((h == hmax) && (v < vmax))   % if we got to the last column
                out(i) = in(v, h);
                v = v + 1;
                i = i + 1;
            elseif ((v > vmin) && (h < hmax))    % all other cases
                out(i) = in(v, h);
                v = v - 1;
                h = h + 1;
                i = i + 1;
            end;
        else                                    % going down
            if ((v == vmax) && (h <= hmax))      % if we got to the last line
                out(i) = in(v, h);
                h = h + 1;
                i = i + 1;
            elseif (h == hmin)                  % if we got to the first column
                out(i) = in(v, h);
                if (v == vmax)
                    h = h + 1;
                else
                    v = v + 1;
                end;
                i = i + 1;
            elseif ((v < vmax) && (h > hmin))    % all other cases
                out(i) = in(v, h);
                v = v + 1;
                h = h - 1;
                i = i + 1;
            end;
        end;
        if ((v == vmax) && (h == hmax))          % bottom right element
            out(i) = in(v, h);
            break
        end;
    end;
    end

    function decodedMatrix = decodeZigzag(zigzagVector, numRows, numCols)
        % Decodes the zigzag vector and reshapes it to the original matrix
        % zigzagVector: zigzag vector
        % numRows: number of rows in the original matrix
        % numCols: number of columns in the original matrix
        % decodedMatrix: reshaped matrix

        decodedMatrix = zeros(numRows, numCols);
        v_max = numRows;
        h_max = numCols;
        i = 1;
        v = 1;
        h = 1;

        while i <= length(zigzagVector)
            if mod((h + v), 2) == 0  % going up
                if v == 1
                    decodedMatrix(v, h) = zigzagVector(i);  % first line
                    if h == h_max
                        v = v + 1;
                    else
                        h = h + 1;
                    end
                    i = i + 1;
                elseif (h == h_max) && (v < v_max)  % last column
                    decodedMatrix(v, h) = zigzagVector(i);
                    v = v + 1;
                    i = i + 1;
                elseif (v > 1) && (h < h_max)  % all other cases
                    decodedMatrix(v, h) = zigzagVector(i);
                    v = v - 1;
                    h = h + 1;
                    i = i + 1;
                end
            else  % going down
                if (v == v_max) && (h <= h_max)  % last line
                    decodedMatrix(v, h) = zigzagVector(i);
                    h = h + 1;
                    i = i + 1;
                elseif h == 1  % first column
                    decodedMatrix(v, h) = zigzagVector(i);
                    if v == v_max
                        h = h + 1;
                    else
                        v = v + 1;
                    end
                    i = i + 1;
                elseif (v < v_max) && (h > 1)  % all other cases
                    decodedMatrix(v, h) = zigzagVector(i);
                    v = v + 1;
                    h = h - 1;
                    i = i + 1;
                end
            end

            if (v == v_max) && (h == h_max)  % bottom right element
                decodedMatrix(v, h) = zigzagVector(i);
                break;
            end
        end
    end
end


