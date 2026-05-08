import 'package:flutter/material.dart';

class ConnectionsScreen extends StatelessWidget {
  const ConnectionsScreen({super.key});

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
              _buildSearchBar(),
              _buildSection('STAFF & MENTORS', _getStaff()),
              _buildSection('MY COHORT', _getPeers()),
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
          Text('Connections',
              style: TextStyle(
                  color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
          SizedBox(height: 4),
          Text('Dallas Learning Community',
              style: TextStyle(color: Colors.white70, fontSize: 13)),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 8)
          ],
        ),
        child: const Row(
          children: [
            Icon(Icons.search, color: Colors.grey, size: 20),
            SizedBox(width: 10),
            Text('Search connections...',
                style: TextStyle(color: Colors.grey, fontSize: 14)),
          ],
        ),
      ),
    );
  }

  // ── Moved to methods so they're not const-field violations ──

  List<Map<String, dynamic>> _getStaff() => [
    {'name': 'Ms. Rivera',   'role': 'Program Manager',  'initials': 'MR', 'color': const Color(0xFF4A2C8F)},
    {'name': 'Mr. Thompson', 'role': 'Tech Instructor',  'initials': 'MT', 'color': const Color(0xFFE8533F)},
    {'name': 'Dr. Patel',    'role': 'Career Coach',     'initials': 'DP', 'color': const Color(0xFFE8A838)},
  ];

  List<Map<String, dynamic>> _getPeers() => [
    {'name': 'Aaliyah Johnson', 'role': 'Peer · Software Track',    'initials': 'AJ', 'color': const Color(0xFF4A2C8F)},
    {'name': 'Marcus Williams', 'role': 'Peer · IT Support Track',  'initials': 'MW', 'color': const Color(0xFFE8533F)},
    {'name': 'Priya Nair',      'role': 'Peer · Data Track',        'initials': 'PN', 'color': const Color(0xFF34A853)},
    {'name': 'Devon Clark',     'role': 'Peer · Software Track',    'initials': 'DC', 'color': const Color(0xFFE8A838)},
    {'name': 'Jasmine Torres',  'role': 'Peer · IT Support Track',  'initials': 'JT', 'color': const Color(0xFF4A9BE8)},
  ];

  Widget _buildSection(String title, List<Map<String, dynamic>> people) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.8,
                  color: Colors.grey)),
          const SizedBox(height: 10),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 8)
              ],
            ),
            child: Column(
              children: people.asMap().entries.map((entry) {
                final p = entry.value;
                return _buildPersonRow(
                  p['name'] as String,
                  p['role'] as String,
                  p['initials'] as String,
                  p['color'] as Color,
                  isLast: entry.key == people.length - 1,
                );
              }).toList(),
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildPersonRow(String name, String role, String initials, Color color,
      {bool isLast = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        border: isLast
            ? null
            : const Border(bottom: BorderSide(color: Color(0xFFF0F0F0))),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 20,
            backgroundColor: color,
            child: Text(initials,
                style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 13)),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name,
                    style: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.w600)),
                Text(role,
                    style:
                    const TextStyle(fontSize: 12, color: Colors.grey)),
              ],
            ),
          ),
          Icon(Icons.chevron_right, color: Colors.grey.shade400),
        ],
      ),
    );
  }
}