# Project Summary: Image Frequency Domain Analysis and Focus Metric Determination

## Objective
The project involved transforming images to the frequency domain, applying noise reduction techniques, and evaluating image sharpness. MATLAB was used to complete the tasks, and the results are summarized below.

## 1. Frequency Domain Transformation and Noise Reduction
**Images Processed:**

- **Image 1:** Original and frequency domain transformation displayed. Noise was reduced by zeroing specific frequency components, and the results were transformed back to the spatial domain.
- **Image 2:** Converted to grayscale and noise reduction was applied using a fraction of frequency components. The filtered image was then displayed.
- **Image 3:** Noise reduction involved zeroing specific frequencies and visualizing the results in both the frequency domain and spatial domain.

**Low-Pass Filtering:**

- For each image, a Gaussian low-pass filter was applied in the frequency domain to reduce high-frequency noise. Both the original and filtered images were displayed for comparison.

## 2. Image Sharpness Evaluation
**Sharpness Assessment:**

- Sharpness was evaluated using the Laplacian operator to calculate the variance of the filtered image.
- For two sets of images (Tokyo and Damavand), the best-focused image was identified based on the highest sharpness metric.

## Results
- **Image Frequency Domain Analysis:** The transformed images and their frequency domain representations demonstrated the effects of FFT on image data. Noise reduction techniques improved image clarity by selectively zeroing out noise frequencies.
- **Low-Pass Filtering:** The Gaussian filter effectively reduced high-frequency noise, resulting in smoother images.
- **Sharpness Evaluation:** The images with the highest variance in the Laplacian-filtered images were identified as the sharpest. The best-focused images were found for both Tokyo and Damavand sets.
