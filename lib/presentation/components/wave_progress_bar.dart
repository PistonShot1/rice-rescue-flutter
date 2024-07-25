import 'package:flutter/material.dart';
import 'dart:async';

class WaveformProgressbar extends StatefulWidget {
  final Color color;
  final Color progressColor;
  final double progress;
  final ValueChanged<double>? onTap;

  const WaveformProgressbar({
    Key? key,
    required this.color,
    required this.progressColor,
    required this.progress,
    this.onTap,
  }) : super(key: key);

  @override
  _WaveformProgressbarState createState() => _WaveformProgressbarState();
}

class _WaveformProgressbarState extends State<WaveformProgressbar> {
  late Timer _timer;
  double _currentProgress = 0.0;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _currentProgress = (_currentProgress + 0.1) % 1.0;
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 30,
      child: Center(
        child: WaveformPainter(
          color: widget.color,
          progressColor: widget.progressColor,
          progress: _currentProgress,
          onTap: widget.onTap,
        ),
      ),
    );
  }
}

class WaveformPainter extends StatelessWidget {
  final Color color;
  final Color progressColor;
  final double progress;
  final ValueChanged<double>? onTap;

  const WaveformPainter({
    Key? key,
    required this.color,
    required this.progressColor,
    required this.progress,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _WaveformPainter(
        color: color,
        progressColor: progressColor,
        progress: progress,
      ),
    );
  }
}

class _WaveformPainter extends CustomPainter {
  final Color color;
  final Color progressColor;
  final double progress;

  _WaveformPainter({
    required this.color,
    required this.progressColor,
    required this.progress,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final backgroundPaint = Paint()..color = color;
    final progressPaint = Paint()..color = progressColor;

    // Draw background
    canvas.drawRect(
        Rect.fromLTWH(0, 0, size.width, size.height), backgroundPaint);

    // Draw progress
    final progressWidth = size.width * progress;
    canvas.drawRect(
        Rect.fromLTWH(0, 0, progressWidth, size.height), progressPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
