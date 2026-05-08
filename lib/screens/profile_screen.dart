import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

    @override
    Widget build(BuildContext context) {
        return Scaffold(
                backgroundColor: const Color(0xFFF5F5F5),
                body: SafeArea(
                child: SingleChildScrollView(
                child: Column(
                children: [
        _buildProfileHeader(),
                _buildMenuSection('PROGRAM', [
                        {'icon': Icons.bar_chart, 'label': 'My Progress', 'color': '4A2C8F'},
        {'icon': Icons.emoji_events, 'label': 'Achievements', 'color': 'E8A838'},
        {'icon': Icons.work_outline, 'label': 'WBE Placements', 'color': '34A853'},
              ]),
        _buildMenuSection('RESOURCES', [
                {'icon': Icons.menu_book, 'label': 'Student Handbook', 'color': '4A2C8F'},
        {'icon': Icons.help_outline, 'label': 'FAQ / Support', 'color': '4A9BE8'},
        {'icon': Icons.calendar_month, 'label': 'Program Calendar', 'color': 'E8A838'},
              ]),
        _buildMenuSection('ACCOUNT', [
                {'icon': Icons.notifications_outlined, 'label': 'Notifications', 'color': '4A2C8F'},
        {'icon': Icons.settings_outlined, 'label': 'Settings', 'color': '757575'},
        {'icon': Icons.logout, 'label': 'Sign Out', 'color': 'E8533F'},
              ]),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
    }

    Widget _buildProfileHeader() {
        return Container(
                width: double.infinity,
                color: const Color(0xFF4A2C8F),
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 30),
                child: Column(
                children: [
          const CircleAvatar(
                radius: 36,
                backgroundColor: Color(0xFFE8533F),
                child: Text('JD',
                style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 22)),
          ),
          const SizedBox(height: 12),
          const Text('Jordan Davis',
                style: TextStyle(
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          const Text('Software Development Track',
                style: TextStyle(color: Colors.white70, fontSize: 13)),
          const SizedBox(height: 12),
        Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.15),
                borderRadius: BorderRadius.circular(20),
            ),
        child: const Text('Dallas · Spring 2026 Cohort',
                style: TextStyle(color: Colors.white, fontSize: 12)),
          ),
        ],
      ),
    );
    }

    Widget _buildMenuSection(String title, List<Map<String, dynamic>> items) {
        return Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
        Text(title,
                style: const TextStyle(
                fontSize: 11, fontWeight: FontWeight.w700,
                letterSpacing: 0.8, color: Colors.grey)),
          const SizedBox(height: 8),
        Container(
                decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 8)],
            ),
        child: Column(
                children: items.asMap().entries.map((entry) {
        final item = entry.value;
        return _buildMenuItem(
                item['icon'] as IconData,
                item['label'] as String,
                Color(int.parse('FF${item['color']}', radix: 16)),
        isLast: entry.key == items.length - 1,
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
    }

    Widget _buildMenuItem(IconData icon, String label, Color color,
    {bool isLast = false}) {
        return Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
                border: isLast ? null : const Border(bottom: BorderSide(color: Color(0xFFF0F0F0))),
      ),
        child: Row(
                children: [
        Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
            ),
        child: Icon(icon, color: color, size: 18),
          ),
          const SizedBox(width: 14),
        Expanded(
                child: Text(label,
                style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500)),
          ),
        Icon(Icons.chevron_right, color: Colors.grey.shade400),
        ],
      ),
    );
    }
}