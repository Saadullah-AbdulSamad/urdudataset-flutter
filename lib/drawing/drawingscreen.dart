import 'package:flutter/foundation.dart';
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
  List<Offset> points = []; // List to store points for current drawing.
  Map<String, List<Offset>> letterPointsMap =
      {}; // Map to store Urdu letters with their offset values.
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
    "آئی", "آئس", "آقا", "آمد", "آفت", "آلہ", "آلو", "آدم", "آفس", "آخر",
    "اٹک", "ایک", "اتق", "الت", "الو", "الگ", "امن", "امت", "اہم", "الو",
    "انکا", "بدن", "بد", "بٹن", "بچ", "بہن", "بج", "بہت", "بند", "بعد",
    "برج", "بلد", "بہر", "بچت", "پٹ", "پین", "پتہ", "پلک", "پر", "پاک",
    "پی", "پیم", "چمک", "چپل", "چمن", "چنک", "چلا", "چکن", "چند", "چور",
    "چون", "چیر", "چیر", "چیل", "چک", "چیک", "چہر", "چرک", "چڑھ", "حلف",
    "حل", "حر", "حجر", "خوف", "ختم", "خص", "خش", "خاک", "دکن", "درج",
    "درب", "درخت", "دماغ", "دفتر", "دفن", "دھو", "دھن", "دعا", "دش", "ذخ",
    "ذق", "ذوق", "رات", "رزق", "رک", "رل", "رہ", "روی", "رے", "روس",
    "زلف", "زلزلہ", "سا", "سر", "سی", "سو", "سال", "سک", "سوک", "شمس",
    "شاک", "شر", "شق", "شہر", "شجر", "شہرہ", "شدت", "ضبط", "صبر", "صحف",
    "صفا", "صوت", "صلح", "صوم", "صدر", "صدق", "صیت", "طب", "طبع", "ظفر",
    "عقل", "علم", "علی", "عشق", "عمل", "عمر", "عطر", "عہد", "عجز", "غزل",
    "غلط", "غف", "غیر", "فتح", "فکر", "فن", "فوج", "فضل", "ق", "قضا",
    "قتل", "کچھ", "کچک", "کشت", "کرم", "کرن", "کلی", "کن", "کود", "کون",
    "کونک", "کہر", "کوچ", "لکھ", "لمح", "لہر", "لوک", "مال", "مالی", "مدد",
    "مغرور", "ملک", "مل", "نذر", "نقد", "نگ", "نظر", "نگ", "نگر", "نمک",
    "نیٹ", "نو", "نون", "نہر", "نور", "ورق", "وق", "وطن", "وق", "ورک",
    "وسوسہ", "وظیفہ", "یق", "یوں", "یہاں", "یہ", "یو"
  ];
  List<String> urduTwoLetterWords = [
    "آس", "آپ", "آم", "آن", "آہ", "اب", "ابا", "ابو", "ات", "ان", "او",
    "اک", "اہ", "با", "بر", "بس", "بد", "بھ", "بو", "بی", "پر", "پن",
    "پو", "پی", "پا", "تا", "تب", "تر", "تو", "ٹپ", "ٹی", "جا", "جب",
    "جر", "جل", "جو", "جی", "چا", "چھ", "چی", "خد", "خر", "خو", "دا",
    "در", "دو", "دی", "ڈب", "ڈھ", "ڈو", "را", "رب", "رو", "ری", "زا",
    "زر", "زی", "سا", "سر", "سو", "سی", "شا", "شر", "شی", "فا", "فر",
    "فو", "فی", "قا", "قر", "کس", "کہ", "کو", "کی", "لا", "لب", "لو",
    "لی", "ما", "مر", "مو", "می", "نا", "نب", "نو", "نی", "وا", "وج",
    "ور", "وہ", "وی", "ہا", "ہر", "ہی", "یہ"
  ];



  int currentLetterIndex = 0; // Index of the current letter.
  bool showError = false; // Flag to show error when no drawing is made.

  final GlobalKey _drawingKey = GlobalKey(); // Key for the drawing container.

  void resetDrawing() {
    setState(() {
      points.clear(); // Clear current drawing points.
      showError = false; // Reset error flag when the drawing is reset.
    });
  }

  void nextLetter() {
    setState(() {
      if (points.isEmpty) {
        // If no points are drawn, show error message.
        showError = true;
      } else {
        // Store the current letter's points in the map.
        letterPointsMap[urduLetters[currentLetterIndex]] = List.from(points);
        points.clear(); // Clear current points for the next letter.

        if (currentLetterIndex < urduLetters.length - 1) {
          currentLetterIndex++; // Increment only if it's within the bounds of the list.
          showError = false; // Reset error flag if the letter has been drawn.
        } else {
          // Loop through the map and print the contents after the last letter.
          if (kDebugMode) {
            print("All letters have been written. Here are the stored points:");
          }
          // letterPointsMap.forEach((letter, points) {
          //   if (kDebugMode) {
          //     print("Letter: $letter, Points: $points");
          //   }
          // });

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
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 40),
          // Display current Urdu letter.
          Text(
            widget.words == '1 letter' ? urduLetters[currentLetterIndex] : widget.words == '3 letters' ? urduThreeLetterWords[currentLetterIndex] : widget.words=='2 letters'? urduTwoLetterWords[currentLetterIndex]:'',
            style: const TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
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
                      points.add(localPosition);
                    });
                  }
                },
                onPanEnd: (details) {
                  setState(() {
                    points.add(Offset.zero); // Add separator for strokes.
                  });
                },
                child: ClipRect(
                  child: CustomPaint(
                    painter: DrawingPainter(points),
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
                child: const Text("Reset"),
              ),
              const SizedBox(width: 20),
              ElevatedButton(
                onPressed: points.isEmpty ? null : nextLetter,
                child: const Text(
                    "Next Letter"), // Disable button if no points are drawn
              ),
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
