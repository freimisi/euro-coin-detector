# 💰 Euro Coin Detection and Classification

Detecting and classifying **euro coins** in images using **geometric calibration** techniques for accurate measurement of coin diameters.

> 🔍 Built as part of the “Computer Vision and Image Processing” course @ LUT University 
> 👨‍💻 Contributors: Omer AHMED, Mihaly FREI

<p align="center">
  <img src="https://img.shields.io/badge/Made%20With-MATLAB-blue?style=for-the-badge&logo=matlab&logoColor=white">
</p>

---

## 🖼️ Project Overview

This project focuses on **detecting** and **classifying** **euro coins** from images using **geometric calibration**. By leveraging a checkerboard pattern, the pixel measurements are converted to real-world units, allowing for accurate determination of coin diameters. The process involves image preprocessing, segmentation, geometric calibration, and classification based on known coin sizes.

---

## 🧪 Dataset

- **Measurement images:** showing multiple euro coins, including a black and white checker board.
- **Calibration images**
  - Dark images
  - Bias images
  - Flat images

> ⚠️ Dataset not included due to licensing.  

---

## 🧪 Methodology
1.	**Image Processing:** Converts input images to HSV, applies adaptive histogram equalization, and uses edge detection techniques.
2.	**Geometric Calibration:** Utilizes the checkerboard pattern to calibrate pixel-to-mm conversion.
3.	**Coin Classification:** Measures coin diameters, compares with known euro coin sizes, and classifies accordingly.

---

## 📊 Results
-	✅ Accuracy: 82% on average across 12 measurement images
-	📉 Challenges:  
	•	Misclassification of coins placed too close together.  
	•	Issues with dark perimeter of €2 coins affecting segmentation.
 
---

## 💡 Future Work
-	Enhance segmentation for coins placed close to one another.
-	Improve detection of coins with darker perimeters (like the €2 coin).
-	Experiment with machine learning-based approaches for more robust classification.

---

## 📁 Project Structure
📦 euro-coin-classifier/  
├── **testing.m:** testing the implementation; estimates euro coins and calculates accuracy  
├── **batch_test.m:** same as testing.m but for all the measurement images  
├── **estim_coins.m:** main function for estimating euro coins; encompasses all the other functions   
├── **process_image.m:** pre-processes the image   
├── **calibrate_pixel_to_mm.m:** finds the conversion factor from pixels to mm  
├── **classify_coins.m:** classifies the coins on the image  
└── **compute_accuracy.m:** computes the accuracy of the estimation, given the ground truth information    
