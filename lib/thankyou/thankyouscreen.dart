import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:urdudatasetcollection/form/formscreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ThankyouScreen extends StatefulWidget {
  const ThankyouScreen({super.key, required this.data, required this.userID});
  final Map<String, List<Offset>> data;
  final String userID;

  @override
  State<ThankyouScreen> createState() => _ThankyouScreenState();
}

class _ThankyouScreenState extends State<ThankyouScreen> {
  bool drawingComplete = false; // To simulate the drawing completion
  bool isSaving = false; // To simulate saving process
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  // Function to simulate drawing completion
  Future<void> markDrawingComplete() async {
    setState(() {
      isSaving = true; // Start saving process
    });
    if (kDebugMode) {
      print("ID: ${widget.userID}");
    }
    try {
      var convertedData = widget.data.map((title, points) => MapEntry(title,
          points.map((point) => {"dx": point.dx, "dy": point.dy}).toList()));
      // Add the map to a Firestore collection
      await firestore
          .collection("dataset")
          .add({"userID": widget.userID, "data": convertedData});
      if (kDebugMode) {
        print("Data added successfully!");
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error adding data: $e");
      }
    }
    setState(() {
      drawingComplete = true;
    });

    // Display the thank you message for 2 seconds, then navigate to FormScreen
    Future.delayed(const Duration(seconds: 2), () {
      // Navigate to FormScreen and remove all previous screens from the stack
      if (!mounted) return;
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
            builder: (context) =>
                const FormScreen()), // Replace with your home screen widget
        (Route<dynamic> route) => false, // This removes all previous routes
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Thank You"),
        backgroundColor: Colors.black87,
      ),
      body: Center(
        child: drawingComplete
            ? const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.check_circle_outline,
                    color: Colors.green,
                    size: 100.0,
                  ),
                  SizedBox(height: 20),
                  Text(
                    "تمام اردو حروف کامیابی کے ساتھ محفوظ ہو گئے ہیں!",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20),
                  Text(
                    "شکریہ! آپ کی محنت کا شکریہ ادا کرتے ہیں",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueAccent,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  isSaving
                      ? const CircularProgressIndicator(
                          color: Colors.black87,
                        )
                      : Container(),
                  const SizedBox(height: 20),
                  const Text(
                    "آپ کا اردو حروف کی ڈرائنگ محفوظ ہونے کا انتظار کر رہے ہیں...",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueAccent,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: markDrawingComplete,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 50, vertical: 15),
                      textStyle: const TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    child: const Text("محفوظ کریں"),
                  ),
                ],
              ),
      ),
    );
  }
}
