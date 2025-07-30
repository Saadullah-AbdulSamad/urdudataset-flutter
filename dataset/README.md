# Urdu Handwriting Dataset

This directory contains the Urdu handwriting dataset and a compilation tool. The dataset consists of handwritten Urdu text samples collected through our Flutter mobile application.

## 📁 Directory Contents

- **`dataset.zip`** - The compiled Urdu handwriting dataset containing individual JSON files for each word
- **`urdu-dataset-access-key.zip`** - Encrypted ZIP file containing the Firebase service account key for accessing the Firestore database (read-only).
  > **Password:** `P@ssw0rd`
- **`urdu_dataset_compiler.ipynb`** - Jupyter notebook for extracting and compiling the dataset from Firebase

## 📊 Dataset Overview

The dataset contains handwritten samples of:

- **Single letters** - Individual Urdu characters
- **2-letter words** - Two-character Urdu words
- **3-letter words** - Three-character Urdu words

### Data Source

- **Collection Method**: Flutter mobile application
- **Storage**: Firebase Firestore database
- **Data Version**: Version 2 (latest)

## 🎯 Dataset Structure

The `dataset.zip` file contains:

```
dataset/
├── ا.json        # Handwriting samples for letter "ا"
├── آم.json       # Handwriting samples for word "آم"
├── عطر.json      # Handwriting samples for word "عطر"
├── ...
└── ے.json       # Handwriting samples for letter "ے"
```

Each JSON file contains an array of handwriting samples:

```json
[
  [
    {
      "dx": 197.18446350097656,
      "dy": 80.82937622070312,
      "timestamp": 0
    },
    {
      "dx": 197.68377685546875,
      "dy": 82.82815551757812,
      "timestamp": 59
    },
    {
      "dx": 199.68099975585938,
      "dy": 93.32174682617188,
      "timestamp": 75
    },
    "...more stroke points..."
  ],
  [
    {
      "dx": 234.7548828125,
      "dy": 48.54290771484375,
      "timestamp": 0
    },
    "...more stroke points..."
  ],
  "...more samples..."
]
```

## 🚀 Usage

### Option 1: Use Pre-compiled Dataset

1. Extract `dataset.zip`
2. Access individual JSON files for each word
3. Use the data for your machine learning models or research

### Option 2: Compile Fresh Dataset

1. Open `urdu_dataset_compiler.ipynb` in Jupyter Notebook or Google Colab
2. Follow the step-by-step instructions in the notebook
3. The notebook will generate a fresh `dataset.zip` file

## 🛠️ Technical Requirements

### For Using Pre-compiled Dataset

- Any programming language with JSON support
- UTF-8 text encoding support for Urdu characters

### For Running the Compiler Notebook

- **Python 3.7+**
- **Required packages**:
  ```bash
  pip install firebase-admin
  ```
- **Optional** (for local development):
  ```bash
  pip install jupyter notebook
  ```

## 📋 Dataset Applications

This dataset is suitable for:

- **Machine Learning**: Training Urdu handwriting recognition models
- **Computer Vision**: Studying handwritten character patterns
- **Natural Language Processing**: Analyzing Urdu text structure
- **Educational Research**: Understanding handwriting variations
- **Mobile App Development**: Testing OCR applications

## ⚠️ Important Notes

### Urdu Text Encoding

- All text is stored in **UTF-8 encoding**
- Ensure your development environment supports **RTL (Right-to-Left)** text rendering
- You may encounter display issues in some terminals or IDEs, but data integrity remains intact

### File Naming

- JSON files are named using Urdu characters
- Some file systems may have encoding limitations
- Data content is always preserved regardless of display issues

## 🔐 Access & Authentication

The included `urdu-dataset-access-key.json` provides:

- **Read-only access** to the Firestore database
- **Public access** for research and development purposes
- **No write permissions** - dataset is protected from modifications

## 📝 Data Format Details

Each handwriting sample contains:

- **dx**: X-coordinate of touch/stylus point (float)
- **dy**: Y-coordinate of touch/stylus point (float)
- **timestamp**: Time offset in milliseconds from stroke start (integer)

Each JSON file contains multiple handwriting samples as arrays of stroke points, representing different users' handwritten versions of the same word or letter.

## 🤝 Contributing

To contribute to the dataset:

1. Use the Flutter mobile application to submit handwriting samples
2. Data is automatically stored in the Firebase database
3. Run the compiler notebook to include new data

## 📞 Support

For questions or issues:

- Check the notebook documentation for detailed usage instructions
- Ensure proper UTF-8 and Urdu font support in your environment
- Verify Firebase connectivity if recompiling the dataset

## 📄 License

This dataset is provided for research and educational purposes. Please ensure appropriate attribution when using this data in publications or projects.

---

**Last Updated**: Dataset Version 2  
**Compiler**: `urdu_dataset_compiler.ipynb`  
**Format**: JSON files in UTF-8 encoding

