import 'dart:async';
import 'package:flutter/material.dart';
import '../../../widgets/mobile_widgets.dart';

/// Staff QR tab — shows a (decorative) check-in QR that auto-refreshes every
/// 5 minutes. Real implementation would generate signed time-bound tokens.
class StaffQRScreen extends StatefulWidget {
  const StaffQRScreen({super.key});

  @override
  State<StaffQRScreen> createState() => _StaffQRScreenState();
}

class _StaffQRScreenState extends State<StaffQRScreen> {
  int _seconds = 287;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (!mounted) return;
      setState(() {
        _seconds = _seconds <= 1 ? 300 : _seconds - 1;
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mm = (_seconds ~/ 60).toString();
    final ss = (_seconds % 60).toString().padLeft(2, '0');
    return Container(
      color: AppColors.bg,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const PhoneHeader(title: 'Check-in QR'),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.only(bottom: 24),
              child: Transform.translate(
                offset: const Offset(0, -12),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _buildQrCard(mm, ss),
                      const SectionLabel('Just checked in'),
                      _buildRecentList(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQrCard(String mm, String ss) {
    return AppCard(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          // LIVE pill
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              color: AppColors.successBg,
              borderRadius: BorderRadius.circular(999),
            ),
            child: const Text(
              '● LIVE · STUDENTS CAN SCAN',
              style: TextStyle(
                color: AppColors.success,
                fontSize: 11,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.4,
              ),
            ),
          ),
          const SizedBox(height: 18),
          // QR
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: AppColors.borderLight),
            ),
            child: const SizedBox(
              width: 220,
              height: 220,
              child: CustomPaint(painter: _QrPatternPainter()),
            ),
          ),
          const SizedBox(height: 18),
          const Text(
            'Auto-refreshes in',
            style: TextStyle(
              fontSize: 13,
              color: AppColors.text500,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            '$mm:$ss',
            style: const TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w800,
              color: AppColors.text900,
              letterSpacing: -1,
              fontFeatures: [FontFeature.tabularFigures()],
            ),
          ),
          const SizedBox(height: 14),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.bg,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: const [
                _SessionRow(label: 'Session', value: 'Cohort huddle'),
                SizedBox(height: 6),
                _SessionRow(label: 'Date / time', value: 'May 14 · 9:00 AM'),
                SizedBox(height: 6),
                _SessionRow(label: 'Location', value: 'Dallas LC · Room 204'),
              ],
            ),
          ),
          const SizedBox(height: 16),
          // Regenerate (outlined)
          InkWell(
            onTap: () => setState(() => _seconds = 300),
            borderRadius: BorderRadius.circular(12),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 18),
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.primary, width: 1.5),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.refresh, size: 16, color: AppColors.primary),
                  SizedBox(width: 6),
                  Text(
                    'Regenerate now',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: AppColors.primary,
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

  Widget _buildRecentList() {
    const recents = [
      _Recent(name: 'Aisha Kone', time: 'Just now', initials: 'AK'),
      _Recent(name: 'Camila Reyes', time: '1 min ago', initials: 'CR'),
      _Recent(name: 'Devon Park', time: '2 min ago', initials: 'DP'),
    ];
    return AppCard(
      padding: EdgeInsets.zero,
      child: Column(
        children: [
          for (var i = 0; i < recents.length; i++)
            Container(
              padding: const EdgeInsets.fromLTRB(14, 10, 14, 10),
              decoration: BoxDecoration(
                border: i < recents.length - 1
                    ? const Border(
                        bottom: BorderSide(color: AppColors.borderLight),
                      )
                    : null,
              ),
              child: Row(
                children: [
                  Avatar(
                    initials: recents[i].initials,
                    color: AppColors.purpleSoft,
                    size: 32,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      recents[i].name,
                      style: const TextStyle(
                        fontSize: 13.5,
                        fontWeight: FontWeight.w600,
                        color: AppColors.text900,
                      ),
                    ),
                  ),
                  Text(
                    recents[i].time,
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppColors.text500,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    width: 8,
                    height: 8,
                    decoration: const BoxDecoration(
                      color: AppColors.success,
                      shape: BoxShape.circle,
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

class _SessionRow extends StatelessWidget {
  final String label;
  final String value;
  const _SessionRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.alphabetic,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            color: AppColors.text500,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(width: 12),
        Flexible(
          child: Text(
            value,
            textAlign: TextAlign.right,
            style: const TextStyle(
              fontSize: 12,
              color: AppColors.text900,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    );
  }
}

class _Recent {
  final String name;
  final String time;
  final String initials;
  const _Recent({
    required this.name,
    required this.time,
    required this.initials,
  });
}

/// Paints a decorative QR-looking grid. NOT a scannable code — for visual
/// only. Replace with a real QR-encoder package (e.g. `qr_flutter`) when
/// wiring up real check-in tokens.
class _QrPatternPainter extends CustomPainter {
  const _QrPatternPainter();

  @override
  void paint(Canvas canvas, Size size) {
    // Map a 168x168 logical grid to whatever size we're given.
    final scale = size.width / 168;
    final paintBlack = Paint()..color = const Color(0xFF18181F);

    // White background.
    canvas.drawRect(
      Rect.fromLTWH(0, 0, size.width, size.height),
      Paint()..color = Colors.white,
    );

    // Data cells (skip the three corner finder regions).
    for (var i = 0; i < 21; i++) {
      for (var j = 0; j < 21; j++) {
        final inTopLeftFinder = i < 7 && j < 7;
        final inTopRightFinder = i < 7 && j > 13;
        final inBottomLeftFinder = i > 13 && j < 7;
        if (inTopLeftFinder || inTopRightFinder || inBottomLeftFinder) {
          continue;
        }
        if (((i * 13 + j * 7) % 5) > 2) {
          canvas.drawRect(
            Rect.fromLTWH(j * 8.0 * scale, i * 8.0 * scale,
                7 * scale, 7 * scale),
            paintBlack,
          );
        }
      }
    }

    // Three finder squares (top-left, top-right, bottom-left).
    _drawCornerSquare(canvas, paintBlack, 0, 0, scale);
    _drawCornerSquare(canvas, paintBlack, 113, 0, scale);
    _drawCornerSquare(canvas, paintBlack, 0, 113, scale);
  }

  void _drawCornerSquare(
    Canvas canvas,
    Paint blackPaint,
    double x,
    double y,
    double scale,
  ) {
    // Outer
    canvas.drawRect(
      Rect.fromLTWH(x * scale, y * scale, 55 * scale, 55 * scale),
      blackPaint,
    );
    // White interior
    canvas.drawRect(
      Rect.fromLTWH(
          (x + 8) * scale, (y + 8) * scale, 39 * scale, 39 * scale),
      Paint()..color = Colors.white,
    );
    // Inner solid
    canvas.drawRect(
      Rect.fromLTWH((x + 16) * scale, (y + 16) * scale,
          23 * scale, 23 * scale),
      blackPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
