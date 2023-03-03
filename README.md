# Under-water-enhancement
1. To further enhance underwater images, we can apply a method called color correction. Underwater images tend to have a blue or green tint due to the absorption and scattering of light by water. Color correction can help to restore the natural colors in the image.
Code – newclahe.m (color correction using the gray world assumption)

Note that the color correction method used in this code assumes that the average values of the R, G, and B channels should be equal, which may not always be the case. Other color correction methods can be used depending on the specific characteristics of the underwater image.


2. Two additional methods for underwater image enhancement: newclahe1.m
This code includes four different methods for underwater image enhancement:

Method 1: CLAHE in HSV color space. This method enhances the contrast of the image by applying CLAHE to the V channel of the HSV color space.

Method 2: Adaptive gamma correction in LAB color space. This method corrects for the color shift caused by absorption and scattering of light in water by applying adaptive gamma correction to the L channel of the LAB color space.

Method 3: Color correction using gray world assumption. This method corrects the color balance of the image using the gray world assumption, which assumes that on average, the world is gray and that the three color channels should have the same mean intensity.

Method 4: Histogram equalization in RGB color space. This method enhances the contrast of the image by applying histogram equal



3. This code applies CLAHE on LAB, HSV, and RGB color spaces, and calculates the contrast gain between the original and processed images. The contrast gain values are plotted in a bar graph for comparison.
(newclahe2.m)



4. This code loads an underwater image, applies CLAHE to enhance contrast, then applies Joint CLAHE to further enhance contrast. Finally, it corrects color using the gray world assumption. The oldresults function is used to compare the original image to the enhanced image.
that incorporates both CLAHE and Joint CLAHE: (newsclahe3.m)

5. In this modified code, I added an interpolation step to further enhance the image. The interpolation step involves resizing the image using bicubic interpolation to a desired output size. Bicubic interpolation is a high-quality interpolation technique that can preserve sharp edges and fine details in the image. The output size is defined as [720 1280], which is a common size for high-definition video.
After the interpolation step, the results are displayed using four figures: the original image, the image enhanced with CLAHE, the color-corrected image, and the interpolated image. Finally, the oldresults function is used to compare the original image to the interpolated image.
(newclahe4.m)


6. This code first applies the same CLAHE and color correction techniques as before to enhance the underwater image. Then, it applies a fusion-based technique to further enhance the image. This technique involves converting the image to grayscale, applying a Laplacian filter to extract edges, applying an Unsharp Mask filter to sharpen the edges, and then adding the sharpened edges back to the original image. The resulting image is then displayed alongside the original image and the previously-enhanced images using the imshow function. The oldresults function is still included to compare the results with the original image. (newclahe5.m)

7. Note that I added an additional figure to display the USM-enhanced image, and I modified the joint CLAHE section to use the YCbCr color space instead of the HSV color space used in the original code. The new code should display five figures: the original image, the CLAHE-enhanced image, the USM-enhanced image, the joint CLAHE-enhanced image, and the color-corrected image. (newclahe6.m)
