import 'dart:async';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:flutter_tts/flutter_tts.dart';

import '../services/fatigue_detector_service.dart';
import '../widgets/fatigue_gauge.dart';
import '../widgets/status_section.dart';

class LiveMonitoringScreen extends StatefulWidget {
  const LiveMonitoringScreen({super.key});

  @override
  State<LiveMonitoringScreen> createState() => _LiveMonitoringScreenState();
}

class _LiveMonitoringScreenState extends State<LiveMonitoringScreen>
    with WidgetsBindingObserver {
  CameraController? _controller;
  List<CameraDescription>? cameras;
  final FatigueDetectorService _detectorService = FatigueDetectorService();
  final FlutterTts flutterTts = FlutterTts();

  bool isProcessing = false;
  DateTime? lastProcessed;

  int frameSkip = 0;

  // 👁️ Eye detection
  bool eyesClosed = false;
  int closedEyeFrames = 0;

  // 👄 Yawn detection
  bool yawning = false;
  int yawnFrames = 0;

  // ⚡ Fatigue
  String fatigueStatus = "Normal";

  // ⏱️ Timer
  DateTime? eyesClosedStart;
  DateTime? yawnStart;
  bool alertShown = false;

  Timer? timer;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    initCamera();

    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      checkEyeClosure();
    });
  }

  Future<void> initCamera() async {
    cameras = await availableCameras();

    final frontCamera = cameras!.firstWhere(
      (c) => c.lensDirection == CameraLensDirection.front,
    );

    _controller = CameraController(
      frontCamera,
      ResolutionPreset.low,
      enableAudio: false,
      imageFormatGroup: ImageFormatGroup.nv21,
    );

    await _controller!.initialize();

    _controller!.startImageStream(processCameraImage);

    if (!mounted) return;
    setState(() {});
  }

  /// 🔥 ML PROCESS - delegated to FatigueDetectorService
  Future<void> processCameraImage(CameraImage image) async {
    if (isProcessing) return;

    frameSkip++;
    if (frameSkip % 3 != 0) return;

    final now = DateTime.now();
    if (lastProcessed != null &&
        now.difference(lastProcessed!).inMilliseconds < 700) {
      return;
    }

    lastProcessed = now;
    isProcessing = true;

    try {
      final result = await _detectorService.detectFromCameraImage(image);

      if (result.faceFound) {
        final left = result.leftEyeOpenProb;
        final right = result.rightEyeOpenProb;

        if (left < 0.6 && right < 0.6) {
          closedEyeFrames++;
        } else {
          closedEyeFrames = 0;
        }

        eyesClosed = closedEyeFrames > 2;

        if (result.yawning) {
          yawnFrames++;
        } else {
          yawnFrames = 0;
        }

        yawning = yawnFrames > 1;
      } else {
        eyesClosed = false;
        yawning = false;
        closedEyeFrames = 0;
        yawnFrames = 0;
      }

      if (mounted) setState(() {});
    } catch (e) {
      debugPrint('ML ERROR: $e');
    }

    isProcessing = false;
  }

  /// 🔥 FATIGUE + ALERT LOGIC USING EYE + YAWN DETECTION
  void checkEyeClosure() {
    if (!mounted) return;

    final DateTime now = DateTime.now();

    if (eyesClosed) {
      eyesClosedStart ??= now;
    } else {
      eyesClosedStart = null;
    }

    if (yawning) {
      yawnStart ??= now;
    } else {
      yawnStart = null;
    }

    final Duration eyeDuration = eyesClosedStart == null
        ? Duration.zero
        : now.difference(eyesClosedStart!);
    final Duration yawnDuration = yawnStart == null
        ? Duration.zero
        : now.difference(yawnStart!);

    final bool sleepy =
        eyeDuration.inSeconds >= 5 ||
        (eyesClosed && yawnDuration.inSeconds >= 2) ||
        yawnDuration.inSeconds >= 4;
    final bool drowsy = eyesClosed || yawning;

    setState(() {
      if (sleepy) {
        fatigueStatus = "Sleepy 😴";
      } else if (drowsy) {
        fatigueStatus = "Drowsy 😐";
      } else {
        fatigueStatus = "Normal 😊";
      }
    });

    if (sleepy && !alertShown) {
      alertShown = true;

      debugPrint("ALERT TRIGGERED");

      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) return;
        showAlert();
        speakAlert();
      });
    }

    if (!sleepy) {
      alertShown = false;
    }
  }

  // yawning detection moved into FatigueDetectorService

  /// 🔊 VOICE ALERT
  Future<void> speakAlert() async {
    await flutterTts.setLanguage("en-US");
    await flutterTts.setSpeechRate(0.5);
    await flutterTts.speak(
      "Driver wake up. You appear tired. Please stay alert.",
    );
  }

  /// 🚨 ALERT UI (SAFE)
  void showAlert() {
    if (!mounted) return;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        backgroundColor: Colors.black,
        title: const Text("Wake Up!", style: TextStyle(color: Colors.red)),
        content: const Text(
          "You look drowsy. Please stay alert!",
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              alertShown = false;
            },
            child: const Text("OK", style: TextStyle(color: Colors.green)),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    timer?.cancel();
    _controller?.dispose();
    _detectorService.dispose();
    flutterTts.stop();
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Live Monitoring",
                    style: TextStyle(color: Colors.white),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close, color: Colors.white),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              StatusSection(
                eyesClosed: eyesClosed,
                fatigueStatus: fatigueStatus,
              ),

              const SizedBox(height: 40),

              FatigueGauge(
                fatigueStatus: fatigueStatus,
                eyesClosed: eyesClosed,
              ),

              if (_controller != null && _controller!.value.isInitialized)
                Offstage(
                  offstage: true,
                  child: SizedBox(
                    width: 1,
                    height: 1,
                    child: CameraPreview(_controller!),
                  ),
                ),

              const Spacer(),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      onPressed: () => Navigator.pop(context),
                      child: const Text("Stop Monitoring"),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _statusSection() {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF1A1C2E),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.blueAccent),
      ),
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Eye Status",
                    style: TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    eyesClosed ? "Closed 🔴" : "Open 🟢",
                    style: TextStyle(
                      color: eyesClosed ? Colors.red : Colors.greenAccent,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),

          Container(width: 1, height: 50, color: Colors.grey),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Fatigue Status",
                    style: TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    fatigueStatus,
                    style: TextStyle(
                      color: fatigueStatus.contains("Normal")
                          ? Colors.green
                          : fatigueStatus.contains("Drowsy")
                          ? Colors.orange
                          : Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  double _fatigueLevel() {
    if (fatigueStatus.contains("Sleepy")) return 0.9;
    if (fatigueStatus.contains("Drowsy")) return 0.55;
    return 0.15;
  }

  Color _fatigueColor() {
    if (fatigueStatus.contains("Sleepy")) return Colors.redAccent;
    if (fatigueStatus.contains("Drowsy")) return Colors.orangeAccent;
    return Colors.greenAccent;
  }

  Widget _fatigueGaugeSection() {
    final double level = _fatigueLevel();
    final Color levelColor = _fatigueColor();

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 20),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1C2E),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: levelColor.withValues(alpha: 0.55), width: 2),
      ),
      child: Column(
        children: [
          const Text(
            "Fatigue Gauge",
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 18),
          SizedBox(
            width: 175,
            height: 175,
            child: Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: 175,
                  height: 175,
                  child: CircularProgressIndicator(
                    value: 1,
                    strokeWidth: 14,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      Colors.white.withValues(alpha: 0.12),
                    ),
                    backgroundColor: Colors.transparent,
                  ),
                ),
                SizedBox(
                  width: 175,
                  height: 175,
                  child: CircularProgressIndicator(
                    value: level,
                    strokeWidth: 14,
                    valueColor: AlwaysStoppedAnimation<Color>(levelColor),
                    backgroundColor: Colors.transparent,
                  ),
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "${(level * 100).round()}%",
                      style: TextStyle(
                        color: levelColor,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      eyesClosed ? "Eyes Closed" : "Eyes Open",
                      style: const TextStyle(color: Colors.white70),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            "Eye detection is running in background",
            style: TextStyle(color: Colors.white54, fontSize: 12),
          ),
        ],
      ),
    );
  }
}
