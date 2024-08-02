<p><strong>Function Definition:</strong></p>
<p>The function <code>jpegcomp</code> is designed to compress an image using JPEG compression. It takes two inputs:
<ul>
    <li><code>I1</code>: The image to be compressed.</li>
    <li><code>qual</code>: The quality factor for compression (ranging from 0 to 100).</li>
</ul>
The function outputs two results:
<ul>
    <li><code>compressed</code>: The compressed version of the image.</li>
    <li><code>ratio</code>: The compression ratio indicating how much the image size has been reduced.</li>
</ul>
</p>

<p><strong>Image Preprocessing:</strong></p>
<p>If the input image is in RGB format (i.e., it has three color channels), it is converted to grayscale. This step simplifies the compression process because JPEG compression typically works on grayscale images or single color channels.</p>
<p>The image is then saved as a JPEG file named <code>'my_image.jpg'</code>. This step prepares the image for further processing.</p>

<p><strong>Image Resizing:</strong></p>
<p>The dimensions of the image are checked to ensure they are divisible by 8. JPEG compression works on 8x8 blocks, so if the image dimensions are not divisible by 8, it is resized to the nearest dimensions that are. This resizing is necessary to make sure each block of the image can be processed correctly.</p>

<p><strong>Compute File Size:</strong></p>
<p>The size of the saved image (<code>'my_image.jpg'</code>) is retrieved. This size is used to calculate the compression ratio later by comparing it with the size of the compressed image.</p>

<p><strong>DCT and Quantization:</strong></p>
<p>The image pixel values are adjusted (shifted) to center them around zero. This adjustment helps in the Discrete Cosine Transform (DCT) process.</p>
<p>The DCT is applied to 8x8 blocks of the image. This transforms the spatial domain data into frequency domain data.</p>
<p>The DCT coefficients are then quantized using a quantization matrix. The quantization process reduces the precision of the DCT coefficients, which is a key step in compressing the image. The degree of quantization depends on the quality factor provided.</p>

<p><strong>Huffman Encoding and Decoding:</strong></p>
<p>Huffman coding is used to encode the quantized DCT coefficients. This is a lossless compression method that replaces common values with shorter codes and less common values with longer codes.</p>
<p>After encoding, the coefficients are decoded to reconstruct the image. This step involves applying the inverse DCT to convert the frequency domain data back to the spatial domain.</p>

<p><strong>Compute Compression Ratio:</strong></p>
<p>The final compression ratio is calculated by comparing the original image size with the compressed image size. This ratio helps to evaluate the effectiveness of the compression.</p>
