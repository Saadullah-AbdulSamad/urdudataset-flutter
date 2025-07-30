import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:urdudatasetcollection/form/formscreen_compact.dart';

class DataPoint {
  final Offset spatial;
  int temporal;

  DataPoint({required this.spatial, required this.temporal});
}

class ThankyouScreen extends StatefulWidget {
  const ThankyouScreen({
    super.key,
    required this.data,
    required this.userID,
  });
  final Map<String, List<List<DataPoint>>> data;
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
      var convertedData = widget.data.map((title, pointsList) => MapEntry(
          title,
          pointsList.asMap().entries.map((entry) {
            return {
              'index': entry.key,
              'data': entry.value.map((point) {
                return {
                  "dx": point.spatial.dx,
                  "dy": point.spatial.dy,
                  "timestamp": point.temporal
                };
              }).toList()
            };
          }).toList()));
      // Add the map to a Firestore collection
      await firestore
          .collection("dataset")
          .add({"userID": widget.userID, "version": 2, "data": convertedData});
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

    // Display the thank you message for 10 seconds, then navigate to FormScreen
    Future.delayed(const Duration(seconds: 10), () {
      // Navigate to FormScreen and remove all previous screens from the stack
      if (!mounted) return;
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
            builder: (context) =>
                const CompactFormScreen()), // Replace with your home screen widget
        (Route<dynamic> route) => false, // This removes all previous routes
      );
    });
  }

  @override
  void initState() {
    super.initState();
    markDrawingComplete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Thank You"),
        backgroundColor: Colors.black87,
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          drawingComplete
              ? const Icon(
                  Icons.check_circle_outline,
                  color: Colors.green,
                  size: 100.0,
                )
              : const CircularProgressIndicator(
                  color: Colors.black87,
                ),
          const SizedBox(height: 20),
          const Text(
            "آپ کی پر خلوص کاوش کا شکریہ",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.green,
              fontFamily: 'Nastaleeq',
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          Text(
            !drawingComplete
                ? "آپ کی خوشخطی کو محفوظ کیا جا رہا ہے۔۔۔"
                : "آپ کی خوشخطی محفوظ کر لی گئی ہے۔",
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.blueAccent,
              fontFamily: 'Nastaleeq',
            ),
            textAlign: TextAlign.center,
          ),
        ],
      )),
    );
  }
}
