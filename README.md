# Fovea and Optic Disc Localization in Retinal Images

This MATLAB project automatically detects **fovea** and **optic disc** locations in retinal fundus images. It is based on intensity analysis, morphological operations, and histogram processing, and achieves coordinate-level localization suitable for medical image analysis tasks.

## 🔬 Overview

- **Input**: Retinal images (.jpg) from the IDRiD dataset  
- **Output**: CSV files with coordinates of detected:
  - Fovea center
  - Optic disc center

## 📂 Folder Structure

```
Image_Pros_Project/
│
├── Testing_Set/                   # Input images (retinal scans)
├── main.m                         # Main detection script
├── calculate_f1_fovea.m          # Evaluation script (F1 score for fovea)
├── calculate_od.m                # Evaluation script (F1 score for optic disc)
├── IDRiD_Fovea_Center_Testing... # Ground truth fovea labels
├── IDRiD_OD_Center_Testing...    # Ground truth optic disc labels
├── fovea_coordinates.csv         # Output: Detected fovea points
├── optic_disc_coordinates.csv    # Output: Detected optic disc points
└── BIM472_Optic Disc and Fovea...# Project report PDF
```

## ⚙️ How It Works

### Optic Disc Detection
- CLAHE-enhanced red channel
- Gaussian filtering
- Intensity thresholding
- Region properties (area, eccentricity) to isolate the optic disc

### Fovea Detection
- Morphological operations (opening + closing)
- Histogram-based intensity enhancement
- ROI-based darkest point extraction

## 🧪 Evaluation

You can evaluate detection accuracy using:
- `calculate_f1_fovea.m` for fovea
- `calculate_od.m` for optic disc

Each compares predictions to ground truth and computes:
- **Precision**
- **Recall**
- **F1 Score**

## ✅ Dependencies

- MATLAB R2024b (tested)
- Image Processing Toolbox

## 📌 Acknowledgments

- Dataset: **IDRiD - Indian Diabetic Retinopathy Image Dataset**
- Paper Reference: *Detection and Localization of Fovea in Retinal Images (KM Asim et al.)*

## 👤 Author

Gizem Tuğuz  
[GitHub Profile](https://github.com/gizemtuguz)

---

🧠 *This project was developed for the BIM472 Image Processing course.*
