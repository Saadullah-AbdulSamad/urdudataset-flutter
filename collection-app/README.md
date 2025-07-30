
# Urdu Handwriting Collection App

A Flutter app for collecting handwritten Urdu samples, supporting research and dataset creation for Urdu handwriting recognition.

## Features
- Collects single-letter, two-letter, and three-letter Urdu words
- Handwriting input via custom canvas
- Stores data in Firebase Firestore
- Urdu font support (Nastaleeq)
- Simple, session-based contributor workflow

## Getting Started

### Prerequisites
- Flutter SDK (3.5.4 or newer)
- Android Studio or Android toolchain (required to build Android apps)
- Android device or emulator (recommended)
- Firebase project (Firestore enabled)

### Installation
1. Clone the repository:
   ```bash
   git clone https://github.com/Saadullah-AbdulSamad/urdudataset-flutter.git
   cd urdudataset-flutter/collection-app
   ```
2. Install dependencies:
   ```bash
   flutter pub get
   ```
3. Firebase is already configured for this app. If you wish to use your own Firebase project, some modifications will be required; guidance can be found on online forums or in the [official Firebase docs](https://firebase.google.com/docs/flutter/setup).
4. Run the app:
   ```bash
   flutter run
   ```

## Project Structure
- `lib/main.dart` — App entry point, routing, Firebase initialization
- `lib/form/` — Contributor info and word selection screens
- `lib/drawing/` — Handwriting canvas and data capture
- `lib/thankyou/` — Submission and Firestore upload logic
- `lib/welcomescreen/` — Welcome and splash screen
- `assets/fonts/` — Urdu font (Jameel Noori Nastaleeq)

## Data Format
- Each handwriting sample is a list of points:
  - `dx`, `dy`: coordinates
  - `timestamp`: milliseconds since stroke start
- Data is uploaded to Firestore as structured JSON

## Usage
1. Launch the app
2. Enter contributor info
3. Select a word/letter
4. Write on the canvas
5. Submit sample to Firestore

## Contributing
Pull requests and suggestions are welcome. Please open issues for bugs or feature requests.

## License
For research and educational use. Please attribute if used in publications or projects.
