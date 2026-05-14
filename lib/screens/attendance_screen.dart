import 'package:flutter/material.dart';
import 'package:flutter_app/screens/qr_scanner_screen.dart';

import '../config/app_config.dart';

class AttendanceScreen extends StatelessWidget {
  const AttendanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0EFF5),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(context),
              _buildStatGrid(),
              _buildWeeklyHistory(),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  // ─── HEADER with QR button ────────────────────────────────
  Widget _buildHeader(BuildContext context) {
    return Container(
      width: double.infinity,
      color: const Color(0xFF4A2C8F),
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Attendance',
            style: TextStyle(
                color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          // QR scan button
          if (AppConfig.enableQRScanner)
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const QrScannerScreen()));
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                decoration: BoxDecoration(
                  color: const Color(0xFFE8533F),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Icon(Icons.qr_code_scanner,
                          color: Colors.white, size: 22),
                    ),
                    const SizedBox(width: 14),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Scan check-in QR code',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold)),
                          SizedBox(height: 2),
                          Text("Opens camera to scan today's code",
                              style: TextStyle(color: Colors.white70, fontSize: 12)),
                        ],
                      ),
                    ),
                    const Icon(Icons.chevron_right, color: Colors.white),
                  ],
                ),
              ),
            )
          else
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              decoration: BoxDecoration(
                color: Colors.grey.shade400,
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Row(
                children: [
                  Icon(Icons.qr_code_scanner, color: Colors.white, size: 22),
                  SizedBox(width: 14),
                  Text('QR scanning unavailable in simulator',
                      style: TextStyle(color: Colors.white, fontSize: 14)),
                ],
              ),
            ),
        ],
      ),
    );
  }

  // ─── 2x2 STAT GRID ───────────────────────────────────────
  Widget _buildStatGrid() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            children: [
              _buildStatCard('16/18', 'Days present'),
              const SizedBox(width: 12),
              _buildStatCard('2 left', 'PTO remaining'),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              _buildStatCard('1', 'Late arrivals'),
              const SizedBox(width: 12),
              _buildStatCard('89%', 'Attendance rate'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String value, String label) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.04),
                blurRadius: 8,
                offset: const Offset(0, 2))
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(value,
                style: const TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF4A2C8F))),
            const SizedBox(height: 4),
            Text(label,
                style:
                const TextStyle(fontSize: 13, color: Colors.grey)),
          ],
        ),
      ),
    );
  }

  // ─── WEEKLY HISTORY ───────────────────────────────────────
  Widget _buildWeeklyHistory() {
    final weeks = [
      {
        'label': 'Week 18 · Apr 28 – May 2',
        'badge': 'Full',
        'badgeColor': const Color(0xFF34A853),
        'days': ['P', 'P', 'P', 'P', 'P'],
      },
      {
        'label': 'Week 17 · Apr 21 – Apr 25',
        'badge': '1 Late',
        'badgeColor': const Color(0xFFE8A838),
        'days': ['P', 'L', 'P', 'P', 'P'],
      },
      {
        'label': 'Week 16 · Apr 14 – Apr 18',
        'badge': '1 Absent',
        'badgeColor': const Color(0xFFE8533F),
        'days': ['P', 'A', 'P', 'P', 'R'],
      },
      {
        'label': 'Week 15 · Apr 8 – Apr 12',
        'badge': '2 Absent',
        'badgeColor': const Color(0xFFE8533F),
        'days': ['A', 'A', 'P', 'P', 'R'],
      },
      {
        'label': 'Week 16 · Apr 8 – Apr 12',
        'badge': '2 Absent',
        'badgeColor': const Color(0xFFE8533F),
        'days': ['A', 'A', 'P', 'P', '-'],
      },
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('WEEKLY HISTORY',
              style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.8,
                  color: Colors.grey)),
          const SizedBox(height: 10),
          ...weeks.map((w) => _buildWeekCard(
            w['label'] as String,
            w['badge'] as String,
            w['badgeColor'] as Color,
            w['days'] as List<String>,
          )),
        ],
      ),
    );
  }

  Widget _buildWeekCard(
      String label, String badge, Color badgeColor, List<String> days) {
    const dayNames = ['MON', 'TUE', 'WED', 'THU', 'FRI'];

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 8,
              offset: const Offset(0, 2))
        ],
      ),
      child: Column(
        children: [
          // Week label + badge
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(label,
                  style: const TextStyle(
                      fontSize: 15, fontWeight: FontWeight.bold)),
              Container(
                padding:
                const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: badgeColor.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(badge,
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: badgeColor)),
              ),
            ],
          ),
          const SizedBox(height: 14),
          // Day dots
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(5, (i) {
              return _buildDayDot(dayNames[i], days[i]);
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildDayDot(String dayName, String status) {
    Color dotColor;
    String label;

    switch (status) {
      case 'P':
        dotColor = const Color(0xFF4A2C8F);
        label = '✓';
        break;
      case 'L':
        dotColor = const Color(0xFFE8A838);
        label = 'L';
        break;
      case 'A':
        dotColor = const Color(0xFFE8533F);
        label = 'A';
        break;
      case 'R': // remote / other
        dotColor = const Color(0xFF9E9E9E);
        label = 'R';
        break;
      default:
        dotColor = Colors.grey.shade300;
        label = '-';
    }

    return Column(
      children: [
        Text(dayName,
            style: const TextStyle(
                fontSize: 11, color: Colors.grey, fontWeight: FontWeight.w500)),
        const SizedBox(height: 6),
        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(shape: BoxShape.circle, color: dotColor),
          alignment: Alignment.center,
          child: Text(label,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.bold)),
        ),
      ],
    );
  }
}