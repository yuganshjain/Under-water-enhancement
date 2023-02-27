# Under-water-enhancement
1. To further enhance underwater images, we can apply a method called color correction. Underwater images tend to have a blue or green tint due to the absorption and scattering of light by water. Color correction can help to restore the natural colors in the image.
Code – newclahe.m (color correction using the gray world assumption)

Note that the color correction method used in this code assumes that the average values of the R, G, and B channels should be equal, which may not always be the case. Other color correction methods can be used depending on the specific characteristics of the underwater image.
2.two additional methods for underwater image enhancement: newclahe1.m
This code includes four different methods for underwater image enhancement:
Method 1: CLAHE in HSV color space. This method enhances the contrast of the image by applying CLAHE to the V channel of the HSV color space.
Method 2: Adaptive gamma correction in LAB color space. This method corrects for the color shift caused by absorption and scattering of light in water by applying adaptive gamma correction to the L channel of the LAB color space.
Method 3: Color correction using gray world assumption. This method corrects the color balance of the image using the gray world assumption, which assumes that on average, the world is gray and that the three color channels should have the same mean intensity.
Method 4: Histogram equalization in RGB color space. This method enhances the contrast of the image by applying histogram equal


3.This code applies CLAHE on LAB, HSV, and RGB color spaces, and calculates the contrast gain between the original and processed images. The contrast gain values are plotted in a bar graph for comparison.
(newclahe2.m)

4. This code loads an underwater image, applies CLAHE to enhance contrast, then applies Joint CLAHE to further enhance contrast. Finally, it corrects color using the gray world assumption. The oldresults function is used to compare the original image to the enhanced image.
that incorporates both CLAHE and Joint CLAHE:
