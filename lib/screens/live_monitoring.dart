import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

class LiveMonitoringScreen extends StatefulWidget {
  const LiveMonitoringScreen({super.key});

  @override
  State<LiveMonitoringScreen> createState() => _LiveMonitoringScreenState();
}

class _LiveMonitoringScreenState extends State<LiveMonitoringScreen> {
  CameraController? _controller;
  List<CameraDescription>? cameras;

  @override
  void initState() {
    super.initState();
    initCamera();
  }

  Future<void> initCamera() async {
    cameras = await availableCameras();

    _controller = CameraController(
      cameras![1], // front camera (change to 0 if error)
      ResolutionPreset.medium,
      enableAudio: false,
    );

    await _controller!.initialize();

    if (mounted) setState(() {});
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D0F1A),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [

              // 🔴 TOP BAR
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Live Monitoring",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close, color: Colors.white),
                    onPressed: () => Navigator.pop(context),
                  )
                ],
              ),

              const SizedBox(height: 20),

              // ✅ STATUS SECTION
              _statusSection(),

              const SizedBox(height: 40),

              // 🎥 CAMERA FACE BOX
              Container(
                width: 200,
                height: 280,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.greenAccent, width: 3),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: _controller == null || !_controller!.value.isInitialized
                    ? const Center(child: CircularProgressIndicator())
                    : ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: CameraPreview(_controller!),
                      ),
              ),

              const Spacer(),

              // 🔴 BOTTOM BUTTONS
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      onPressed: () => Navigator.pop(context),
                      child: const Text("Stop Monitoring"),
                    ),
                  ),
                  const SizedBox(width: 10),
                  FloatingActionButton(
                    backgroundColor: Colors.yellow,
                    onPressed: () {},
                    child: const Icon(Icons.call, color: Colors.black),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ✅ STATUS BOX (JOINED)
  Widget _statusSection() {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF1A1C2E),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.blueAccent),
      ),
      child: Row(
        children: [

          // LEFT
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Row(
                    children: [
                      Icon(Icons.remove_red_eye, size: 16, color: Colors.green),
                      SizedBox(width: 6),
                      Text("Eye Status",
                          style: TextStyle(color: Colors.grey)),
                    ],
                  ),
                  SizedBox(height: 5),
                  Text("Eyes Open",
                      style: TextStyle(
                          color: Colors.greenAccent,
                          fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          ),

          // DIVIDER
          Container(width: 1, height: 50, color: Colors.grey),

          // RIGHT
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Row(
                    children: [
                      Icon(Icons.circle, size: 8, color: Colors.green),
                      SizedBox(width: 6),
                      Text("Fatigue Score",
                          style: TextStyle(color: Colors.grey)),
                    ],
                  ),
                  SizedBox(height: 5),
                  Text("10%",
                      style: TextStyle(
                          color: Colors.greenAccent,
                          fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}