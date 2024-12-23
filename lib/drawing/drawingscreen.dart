import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:urdudatasetcollection/thankyou/thankyouscreen.dart';

class DrawingScreen extends StatefulWidget {
  const DrawingScreen({super.key, required this.userID});
  final String userID;

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
            urduLetters[currentLetterIndex],
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
