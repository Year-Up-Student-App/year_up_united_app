import 'package:flutter/material.dart';

// This is a StatelessWidget — like a Java class with no changing fields
// We use StatelessWidget when the screen doesn't need to update itself
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Scaffold is the base "page" widget — every screen has one
    // Think of it like the outer shell of your screen
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),

      // The body is everything visible on screen
      body: SafeArea(
        // SafeArea keeps content away from the camera notch & status bar
        child: SingleChildScrollView(
          // SingleChildScrollView makes the whole page scrollable
          child: Column(
            // Column stacks widgets vertically, like a vertical LinearLayout in Android
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),        // purple top section
              _buildProgressCard(),  // program progress card
              _buildTodosSection(),  // upcoming & to-dos
              _buildAnnouncements(), // announcements
              const SizedBox(height: 20), // bottom padding
            ],
          ),
        ),
      ),

    );
  }

  // ─── HEADER ───────────────────────────────────────────────
  Widget _buildHeader() {
    return Container(
      width: double.infinity, // stretch to full width
      color: const Color(0xFF4A2C8F), // purple
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 24),
      child: Row(
        // Row lays things out horizontally
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Left side: greeting text
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                'Good morning, Jordan 👋',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 4), // tiny vertical gap
              Text(
                'Dallas Learning Community · Week 18',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 13,
                ),
              ),
            ],
          ),

          // Right side: avatar circle with initials
          CircleAvatar(
            radius: 22,
            backgroundColor: const Color(0xFFE8533F), // orange-red
            child: const Text(
              'JD',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ─── PROGRESS CARD ────────────────────────────────────────
  Widget _buildProgressCard() {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12), // rounded corners
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // "PROGRAM PROGRESS" label + percentage
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                'PROGRAM PROGRESS',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.8,
                  color: Colors.grey,
                ),
              ),
              Text(
                '62%',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),

          const Text(
            'Training Phase — 18 of 29 weeks',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 10),

          // Progress bar
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: 0.62, // 62% — this is a number between 0.0 and 1.0
              minHeight: 8,
              backgroundColor: Colors.grey.shade200,
              valueColor: const AlwaysStoppedAnimation<Color>(
                Color(0xFFE8533F), // orange-red bar
              ),
            ),
          ),
          const SizedBox(height: 14),

          // Two stat boxes side by side
          Row(
            children: [
              _buildStatBox('18 wks', 'Training complete'),
              const SizedBox(width: 12),
              _buildStatBox('11 wks', 'Until WBE phase'),
            ],
          ),
        ],
      ),
    );
  }

  // Reusable small stat box — this is like a helper method in Java
  Widget _buildStatBox(String value, String label) {
    return Expanded(
      // Expanded makes both boxes share the available space equally
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: const Color(0xFFF0EDFA), // light purple tint
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              value,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF4A2C8F),
              ),
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }

  // ─── TO-DOS SECTION ───────────────────────────────────────
  Widget _buildTodosSection() {
    // Our todo data — later this will come from a real API
    final todos = [
      {
        'month': 'MAY',
        'day': '8',
        'title': 'Weekly contract review',
        'subtitle': 'Today · 2:00 PM',
        'tag': 'To-do',
        'tagColor': Color(0xFFE8533F),
        'accentColor': Color(0xFF4A2C8F),
      },
      {
        'month': 'MAY',
        'day': '9',
        'title': 'Professional skills workshop',
        'subtitle': 'Thu · 10:00 AM',
        'tag': 'Event',
        'tagColor': Color(0xFFE8A838),
        'accentColor': Color(0xFFE8A838),
      },
      {
        'month': 'MAY',
        'day': '10',
        'title': 'Submit reflection journal',
        'subtitle': 'Fri · Due by 5 PM',
        'tag': 'To-do',
        'tagColor': Color(0xFFE8533F),
        'accentColor': Color(0xFF4A2C8F),
      },
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'UPCOMING & TO-DOS',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.8,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 10),

          // Loop through todos and build a card for each
          // .map() is like Java's stream().map()
          ...todos.map((todo) => _buildTodoCard(todo)),
        ],
      ),
    );
  }

  Widget _buildTodoCard(Map<String, dynamic> todo) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Colored date box on the left
          Container(
            width: 44,
            padding: const EdgeInsets.symmetric(vertical: 8),
            decoration: BoxDecoration(
              color: todo['accentColor'] as Color,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              children: [
                Text(
                  todo['month'] as String,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 9,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.5,
                  ),
                ),
                Text(
                  todo['day'] as String,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),

          // Title + subtitle in the middle
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  todo['title'] as String,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  todo['subtitle'] as String,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),

          // Tag badge on the right
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: (todo['tagColor'] as Color).withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              todo['tag'] as String,
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: todo['tagColor'] as Color,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ─── ANNOUNCEMENTS ────────────────────────────────────────
  Widget _buildAnnouncements() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'ANNOUNCEMENTS',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.8,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.04),
                  blurRadius: 6,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Red dot indicator
                Container(
                  margin: const EdgeInsets.only(top: 5, right: 8),
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'New WBE placements posted',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Check the internship board — 12 new positions ...',
                        style: TextStyle(fontSize: 13, color: Colors.grey),
                      ),
                    ],
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