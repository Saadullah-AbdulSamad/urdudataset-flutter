import 'dart:math'; // Import the dart:math library
import 'package:flutter/material.dart';
import 'package:urdudatasetcollection/thankyou/thankyouscreen.dart';

class DrawingScreen extends StatefulWidget {
  const DrawingScreen({super.key, required this.userID, required this.words});
  final String userID;
  final String? words;

  @override
  State<DrawingScreen> createState() => _DrawingBoardState();
}

class _DrawingBoardState extends State<DrawingScreen> {
  List<DataPoint> dataEntries = []; // List to store points for current drawing.
  List<int> stamps = [];
  Map<String, List<DataPoint>> letterPointsMap =
      {}; // Map to store Urdu letters with their data values.

  List<String> wordsDone = [];
  List<String> urduLetters = [
    "ا",
    "ب",
    "ت",
    "ث",
    "ج",
    "چ",
    "ح",
    "خ",
    "د",
    "ڈ",
    "ر",
    "ڑ",
    "ز",
    "ژ",
    "س",
    "ش",
    "ص",
    "ض",
    "ط",
    "ظ",
    "ع",
    "غ",
    "ف",
    "ق",
    "ک",
    "گ",
    "ل",
    "م",
    "ن",
    "ں",
    "و",
    "ہ",
    "ھ",
    "ی",
    "ے"
  ];

  List<String> urduThreeLetterWords = [
    "آئی",
    "آئس",
    "آقا",
    "آمد",
    "آفت",
    "آلہ",
    "آلو",
    "آدم",
    "آفس",
    "آخر",
    "اٹک",
    "ایک",
    "اتق",
    "الت",
    "الو",
    "الگ",
    "امن",
    "امت",
    "اہم",
    "الو",
    "بدن",
    "بٹن",
    "بہن",
    "بہت",
    "بند",
    "بعد",
    "برج",
    "بلد",
    "بہر",
    "بچت",
    "پین",
    "پتہ",
    "پلک",
    "پاک",
    "پیم",
    "چمک",
    "چپل",
    "چمن",
    "چنک",
    "چلا",
    "چکن",
    "چند",
    "چور",
    "چون",
    "چیر",
    "چیر",
    "چیل",
    "چیک",
    "چہر",
    "چرک",
    "چڑھ",
    "حلف",
    "حجر",
    "خوف",
    "ختم",
    "خاک",
    "دکن",
    "درج",
    "درب",
    "دفن",
    "دھو",
    "دھن",
    "دعا",
    "ذوق",
    "رات",
    "رزق",
    "روی",
    "روس",
    "زلف",
    "سال",
    "سک",
    "سوک",
    "شمس",
    "شاک",
    "شہر",
    "شجر",
    "شدت",
    "ضبط",
    "صبر",
    "صحف",
    "صفا",
    "صوت",
    "صلح",
    "صوم",
    "صدر",
    "صدق",
    "صیت",
    "طبع",
    "ظفر",
    "عقل",
    "علم",
    "علی",
    "عشق",
    "عمل",
    "عمر",
    "عطر",
    "عہد",
    "عجز",
    "غزل",
    "غلط",
    "غیر",
    "فتح",
    "فکر",
    "فوج",
    "فضل",
    "قضا",
    "قتل",
    "کچھ",
    "کچک",
    "کشت",
    "کرم",
    "کرن",
    "کلی",
    "کود",
    "کون",
    "کہر",
    "کوچ",
    "لکھ",
    "لمح",
    "لہر",
    "لوک",
    "مال",
    "مالی",
    "مدد",
    "ملک",
    "نذر",
    "نقد",
    "نظر",
    "نگر",
    "نمک",
    "نیٹ",
    "نون",
    "نہر",
    "نور",
    "ورق",
    "وطن",
    "ورک",
    "یوں",
  ];

  List<String> urduTwoLetterWords = [
    "آس",
    "آپ",
    "آم",
    "آن",
    "آہ",
    "اب",
    "ابا",
    "ابو",
    "ات",
    "ان",
    "او",
    "اک",
    "اہ",
    "با",
    "بر",
    "بس",
    "بد",
    "بھ",
    "بو",
    "بی",
    "پر",
    "پن",
    "پو",
    "پی",
    "پا",
    "تا",
    "تب",
    "تر",
    "تو",
    "ٹپ",
    "ٹی",
    "جا",
    "جب",
    "جر",
    "جل",
    "جو",
    "جی",
    "چا",
    "چھ",
    "چی",
    "خد",
    "خر",
    "خو",
    "دا",
    "در",
    "دو",
    "دی",
    "ڈب",
    "ڈھ",
    "ڈو",
    "را",
    "رب",
    "رو",
    "ری",
    "زا",
    "زر",
    "زی",
    "سا",
    "سر",
    "سو",
    "سی",
    "شا",
    "شر",
    "شی",
    "فا",
    "فر",
    "فو",
    "فی",
    "قا",
    "قر",
    "کس",
    "کہ",
    "کو",
    "کی",
    "لا",
    "لب",
    "لو",
    "لی",
    "ما",
    "مر",
    "مو",
    "می",
    "نا",
    "نب",
    "نو",
    "نی",
    "وا",
    "وج",
    "ور",
    "وہ",
    "وی",
    "ہا",
    "ہر",
    "ہی",
    "یہ"
  ];

  int currentLetterIndex = 0; // Index of the current letter.
  bool showError = false; // Flag to show error when no drawing is made.

  final GlobalKey _drawingKey = GlobalKey(); // Key for the drawing container.

  // Random function to select a random word from the given list
  String rand(List<String> words) {
    final random = Random();
    return words[random.nextInt(words.length)];
  }

  void resetDrawing() {
    setState(() {
      dataEntries.clear(); // Clear current drawing points.
      showError = false; // Reset error flag when the drawing is reset.
    });
  }

  void nextLetter() {
    setState(() {
      if (dataEntries.isEmpty) {
        // If no points are drawn, show error message.
        showError = true;
      } else {
        dataEntries.sort((a, b) => a.temporal.compareTo(b.temporal));

        final firstStamp = dataEntries[0].temporal;
        for (int i = 0; i < dataEntries.length; i++) {
          dataEntries[i].temporal = dataEntries[i].temporal - firstStamp;
        }

        // Store the current letter's points in the map.
        letterPointsMap[widget.words == 'Single alphabet words'
            ? urduLetters[currentLetterIndex]
            : widget.words == 'Triple alphabet words'
                ? urduThreeLetterWords[currentLetterIndex]
                : widget.words == 'Double alphabet words'
                    ? urduTwoLetterWords[currentLetterIndex]
                    : ''] = List.from(dataEntries);
        if (widget.words == 'Double alphabet words') {
          wordsDone.add(urduTwoLetterWords[currentLetterIndex]);
        }
        if (widget.words == 'Triple alphabet words') {
          wordsDone.add(urduThreeLetterWords[currentLetterIndex]);
        }
        dataEntries.clear(); // Clear current points for the next letter.

        if (widget.words == 'Single alphabet words' &&
            currentLetterIndex < urduLetters.length - 1) {
          currentLetterIndex++; // Increment only if it's within the bounds of the list.
          showError = false; // Reset error flag if the letter has been drawn.
        } else {
          if (widget.words == 'Double alphabet words' &&
              wordsDone.length <= urduTwoLetterWords.length) {
            var proposedStr = rand(urduTwoLetterWords);
            while (wordsDone.contains(proposedStr)) {
              proposedStr = rand(urduTwoLetterWords);
            }
            currentLetterIndex = urduTwoLetterWords.indexOf(proposedStr);
          } else {
            if (widget.words == 'Triple alphabet words' &&
                wordsDone.length <= urduThreeLetterWords.length) {
              var proposedStr = rand(urduThreeLetterWords);
              while (wordsDone.contains(proposedStr)) {
                proposedStr = rand(urduThreeLetterWords);
              }
              currentLetterIndex = urduThreeLetterWords.indexOf(proposedStr);
            } else {
              // When all letters are completed, navigate to the thank you screen.
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ThankyouScreen(
                    data: letterPointsMap,
                    userID: widget.userID,
                  ),
                ),
              );
            }
          }
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 40),
          // Display current Urdu letter or word.
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                " لکھیں",
                style: TextStyle(
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Nastaleeq',
                  color: Colors.black,
                ),
              ),
              Text(
                widget.words == 'Single alphabet words'
                    ? urduLetters[currentLetterIndex]
                    : widget.words == 'Triple alphabet words'
                        ? urduThreeLetterWords[
                            currentLetterIndex] // Random 3-letter word
                        : widget.words == 'Double alphabet words'
                            ? urduTwoLetterWords[
                                currentLetterIndex] // Random 2-letter word
                            : '',
                style: const TextStyle(
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Nastaleeq',
                    color: Colors.red),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Center(
            child: Container(
              key: _drawingKey,
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.black, width: 2),
              ),
              child: GestureDetector(
                onPanUpdate: (details) {
                  RenderBox renderBox = _drawingKey.currentContext!
                      .findRenderObject() as RenderBox;
                  Offset localPosition =
                      renderBox.globalToLocal(details.globalPosition);

                  // Ensure touch is within the container bounds.
                  if (localPosition.dx >= 0 &&
                      localPosition.dx <= renderBox.size.width &&
                      localPosition.dy >= 0 &&
                      localPosition.dy <= renderBox.size.height) {
                    setState(() {
                      dataEntries.add(DataPoint(
                          spatial: localPosition,
                          temporal: DateTime.now().millisecondsSinceEpoch));
                    });
                  }
                },
                onPanEnd: (details) {
                  setState(() {
                    dataEntries.add(DataPoint(
                        spatial: Offset.zero,
                        temporal: DateTime.now().millisecondsSinceEpoch));
                  });
                },
                child: ClipRect(
                  child: CustomPaint(
                    painter: DrawingPainter(
                        dataEntries.map((entry) => entry.spatial).toList()),
                  ),
                ),
              ),
            ),
          ),
          // Display error message if no drawing is made.
          if (showError)
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Please draw something before moving to the next letter.',
                style: TextStyle(color: Colors.red, fontSize: 16),
              ),
            ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: resetDrawing,
                child: const Text("Erase"),
              ),
              const SizedBox(width: 20),
              ElevatedButton(
                onPressed: dataEntries.isEmpty ? null : nextLetter,
                child: const Text(
                    "Next Letter"), // Disable button if no points are drawn
              ),
              const SizedBox(width: 20),
              wordsDone.length > 9 && widget.words != 'Single alphabet words'
                  ? ElevatedButton(
                      onPressed: dataEntries.isEmpty
                          ? () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ThankyouScreen(
                                      data: letterPointsMap,
                                      userID: widget.userID),
                                ),
                              );
                            }
                          : null,
                      child: const Text(
                          "Finish"), // Disable button if no points are drawn
                    )
                  : const Text(''),
            ],
          ),
        ],
      ),
    );
  }
}

class DrawingPainter extends CustomPainter {
  final List<Offset> points;

  DrawingPainter(this.points);

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.black
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 3.0;

    for (int i = 0; i < points.length - 1; i++) {
      if (points[i] != Offset.zero && points[i + 1] != Offset.zero) {
        canvas.drawLine(points[i], points[i + 1], paint);
      }
    }
  }

  @override
  bool shouldRepaint(DrawingPainter oldDelegate) => true;
}
