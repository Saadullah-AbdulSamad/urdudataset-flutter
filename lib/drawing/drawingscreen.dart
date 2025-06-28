import 'dart:math'; // Import the dart:math library
import 'package:flutter/material.dart';
import 'package:urdudatasetcollection/thankyou/thankyouscreen.dart';

class DrawingScreen extends StatefulWidget {
  const DrawingScreen({super.key, required this.userID});
  final String userID;

  @override
  State<DrawingScreen> createState() => _DrawingBoardState();
}

class _DrawingBoardState extends State<DrawingScreen> {
  List<DataPoint> dataEntries = []; // List to store points for current drawing.
  List<int> stamps = [];
  Map<String, List<List<DataPoint>>> letterPointsMap =
      {}; // Map to store Urdu letters with their data values.
  String words2 = 'Single alphabet words';
  List<String> wordsDone = [];
  List<String> urduLetters = ["خربوزہ", "خط", "خبری"];

  int currentLetterIndex = 0; // Index of the current letter.
  bool showError = false; // Flag to show error when no drawing is made.

  final GlobalKey _drawingKey = GlobalKey(); // Key for the drawing container.

  // Random function to select a random word from the given list
  String rand(List<String> words) {
    final random = Random();
    return words[random.nextInt(words.length)];
  }

  late String? words1 = words2;
  void resetDrawing() {
    setState(() {
      dataEntries.clear(); // Clear current drawing points.
      showError = false; // Reset error flag when the drawing is reset.
    });
  }

  int currentRepetition = 0; // Counter for repetitions of the current word

  void nextLetter() {
    setState(() {
      if (dataEntries.isEmpty) {
        // If no points are drawn, show an error message.
        showError = true;
      } else {
        dataEntries.sort((a, b) => a.temporal.compareTo(b.temporal));
        final firstStamp = dataEntries[0].temporal;

        for (var entry in dataEntries) {
          entry.temporal -= firstStamp;
        }

        // Store the current letter's points in the map
        if (!letterPointsMap.containsKey(urduLetters[currentLetterIndex])) {
          letterPointsMap[urduLetters[currentLetterIndex]] = [];
        }
        letterPointsMap[urduLetters[currentLetterIndex]]!
            .add(List.from(dataEntries));

        dataEntries.clear(); // Clear the current points for the next drawing
        currentRepetition++; // Increment the repetition counter

        if (currentRepetition >= 5) {
          // If the current word is completed 5 times, move to the next word
          currentRepetition = 0; // Reset the repetition counter
          if (currentLetterIndex < urduLetters.length - 1) {
            currentLetterIndex++; // Move to the next word
          } else {
            // When all words are completed, navigate to the thank you screen
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

        showError = false; // Reset the error flag
      }
    });
  }

  void resetIndexForWords(String? selectedWords) {
    setState(() {
      // Reset the current letter index based on the selected word type
      if (selectedWords == 'Single alphabet words') {
        currentLetterIndex =
            0; // Reset to first index for single alphabet words
      } else if (selectedWords == 'Double alphabet words') {
        currentLetterIndex =
            0; // Reset to first index for double alphabet words
      } else if (selectedWords == 'Triple alphabet words') {
        currentLetterIndex =
            0; // Reset to first index for triple alphabet words
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
                urduLetters[currentLetterIndex],
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
          ListTile(
            leading: ElevatedButton(
              onPressed: resetDrawing,
              child: const Text("Erase"),
            ),
            trailing: wordsDone.length > 9 && words1 != 'Single alphabet words'
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
          ),
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: ElevatedButton(
              onPressed: dataEntries.isEmpty ? null : nextLetter,
              child: const Text(
                  "Next Letter"), // Disable button if no points are drawn
            ),
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
