import 'package:flutter/material.dart';

class AttendanceScreen extends StatelessWidget {
  const AttendanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              _buildSummaryCards(),
              _buildAttendanceLog(),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      color: const Color(0xFF4A2C8F),
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text('Attendance',
              style: TextStyle(
                  color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
          SizedBox(height: 4),
          Text('Spring 2026 · Week 18',
              style: TextStyle(color: Colors.white70, fontSize: 13)),
        ],
      ),
    );
  }

  Widget _buildSummaryCards() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          _buildStatCard('97%', 'Attendance\nRate', const Color(0xFF4A2C8F)),
          const SizedBox(width: 12),
          _buildStatCard('1', 'Absences', const Color(0xFFE8533F)),
          const SizedBox(width: 12),
          _buildStatCard('2', 'Tardies', const Color(0xFFE8A838)),
        ],
      ),
    );
  }

  Widget _buildStatCard(String value, String label, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 8)],
        ),
        child: Column(
          children: [
            Text(value,
                style: TextStyle(
                    fontSize: 22, fontWeight: FontWeight.bold, color: color)),
            const SizedBox(height: 4),
            Text(label,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 11, color: Colors.grey)),
          ],
        ),
      ),
    );
  }

  Widget _buildAttendanceLog() {
    final records = [
      {'date': 'May 7', 'day': 'Wed', 'status': 'present', 'note': 'On time'},
      {'date': 'May 6', 'day': 'Tue', 'status': 'tardy', 'note': '8 min late'},
      {'date': 'May 5', 'day': 'Mon', 'status': 'present', 'note': 'On time'},
      {'date': 'May 2', 'day': 'Fri', 'status': 'present', 'note': 'On time'},
      {'date': 'May 1', 'day': 'Thu', 'status': 'excused', 'note': 'Doctor appt.'},
      {'date': 'Apr 30', 'day': 'Wed', 'status': 'present', 'note': 'On time'},
      {'date': 'Apr 28', 'day': 'Mon', 'status': 'absent', 'note': 'Unexcused'},
      {'date': 'Apr 25', 'day': 'Fri', 'status': 'present', 'note': 'On time'},
      {'date': 'Apr 24', 'day': 'Thu', 'status': 'tardy', 'note': '15 min late'},
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('RECENT ATTENDANCE',
              style: TextStyle(
                  fontSize: 11, fontWeight: FontWeight.w700,
                  letterSpacing: 0.8, color: Colors.grey)),
          const SizedBox(height: 10),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 8)],
            ),
            child: Column(
              children: records.asMap().entries.map((entry) {
                final r = entry.value;
                return _buildRow(r['date']!, r['day']!, r['status']!, r['note']!,
                    isLast: entry.key == records.length - 1);
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRow(String date, String day, String status, String note,
      {bool isLast = false}) {
    final Map<String, dynamic> config = switch (status) {
      'present' => {'color': const Color(0xFF34A853), 'icon': Icons.check_circle, 'label': 'Present'},
      'absent'  => {'color': const Color(0xFFE8533F), 'icon': Icons.cancel,       'label': 'Absent'},
      'tardy'   => {'color': const Color(0xFFE8A838), 'icon': Icons.watch_later,  'label': 'Tardy'},
      'excused' => {'color': const Color(0xFF4A9BE8), 'icon': Icons.info,         'label': 'Excused'},
      _         => {'color': Colors.grey,             'icon': Icons.help,         'label': 'Unknown'},
    };

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        border: isLast ? null : const Border(bottom: BorderSide(color: Color(0xFFF0F0F0))),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 52,
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(date, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
              Text(day, style: const TextStyle(fontSize: 11, color: Colors.grey)),
            ]),
          ),
          const SizedBox(width: 12),
          Icon(config['icon'] as IconData, color: config['color'] as Color, size: 20),
          const SizedBox(width: 10),
          Expanded(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(config['label'] as String,
                  style: TextStyle(
                      fontSize: 14, fontWeight: FontWeight.w600, color: config['color'] as Color)),
              Text(note, style: const TextStyle(fontSize: 12, color: Colors.grey)),
            ]),
          ),
        ],
      ),
    );
  }
}