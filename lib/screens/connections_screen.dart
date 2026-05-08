import 'package:flutter/material.dart';

class ConnectionsScreen extends StatefulWidget {
  const ConnectionsScreen({super.key});

  @override
  State<ConnectionsScreen> createState() => _ConnectionsScreenState();
}

class _ConnectionsScreenState extends State<ConnectionsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0EFF5),
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            Expanded(child: _buildBody()),
          ],
        ),
      ),
    );
  }

  // ─── HEADER ───────────────────────────────────────────────
  Widget _buildHeader() {
    return Container(
      color: const Color(0xFF4A2C8F),
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Connections',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold)),
          const SizedBox(height: 14),
          // Search bar
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.15),
              borderRadius: BorderRadius.circular(24),
            ),
            child: const Row(
              children: [
                Icon(Icons.search, color: Colors.white70, size: 18),
                SizedBox(width: 8),
                Text('Search students, alumni, staff...',
                    style: TextStyle(color: Colors.white70, fontSize: 14)),
              ],
            ),
          ),
          const SizedBox(height: 12),
          // Tabs
          TabBar(
            controller: _tabController,
            indicatorColor: const Color(0xFFE8533F),
            indicatorWeight: 3,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white54,
            labelStyle:
            const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            unselectedLabelStyle: const TextStyle(fontSize: 14),
            tabs: const [
              Tab(text: 'People'),
              Tab(text: 'Groups'),
              Tab(text: 'Alumni'),
            ],
          ),
        ],
      ),
    );
  }

  // ─── BODY ─────────────────────────────────────────────────
  Widget _buildBody() {
    return TabBarView(
      controller: _tabController,
      children: [
        _buildPeopleTab(),
        _buildComingSoon('Groups'),
        _buildComingSoon('Alumni'),
      ],
    );
  }

  Widget _buildPeopleTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Create group chat banner
          _buildGroupChatBanner(),
          const SizedBox(height: 20),

          // Your Cohort section
          _buildSectionLabel('YOUR COHORT — DALLAS LC: Ignite'),
          const SizedBox(height: 10),
          _buildPersonCard('CB', 'Chris Bunny', 'App Development',
              'Student', isConnected: true),
          const SizedBox(height: 10),
          _buildPersonCard('MY', 'Milena Yamane', 'Information Technology',
              'Student', isConnected: false),
          const SizedBox(height: 20),

          // Staff section
          _buildSectionLabel('STAFF'),
          const SizedBox(height: 10),
          _buildPersonCard('LB', 'Lauryn Brown', 'Program Manage...',
              'Staff', isConnected: true, avatarColor: const Color(0xFF34A853)),
          const SizedBox(height: 10),
          _buildPersonCard('Ep', 'Emily Peery', 'Student Services...',
              'Staff', isConnected: true, avatarColor: const Color(0xFF34A853)),
          const SizedBox(height: 20),

          // Alumni section
          _buildSectionLabel('ALUMNI NEAR YOU'),
          const SizedBox(height: 10),
          _buildPersonCard('JM', 'Jamie Monroe', 'Software Eng · Dallas',
              'Alumni', isConnected: false, avatarColor: const Color(0xFF4A9BE8)),
          const SizedBox(height: 10),
          _buildPersonCard('SR', 'Sam Rivera', 'IT Analyst · Dallas',
              'Alumni', isConnected: false, avatarColor: const Color(0xFF4A9BE8)),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildGroupChatBanner() {
    return Container(
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
            child: const Icon(Icons.group_add, color: Colors.white, size: 22),
          ),
          const SizedBox(width: 14),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Create a group chat',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.bold)),
                SizedBox(height: 2),
                Text('Study groups, cohort chats, and more',
                    style: TextStyle(color: Colors.white70, fontSize: 12)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionLabel(String label) {
    return Text(label,
        style: const TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.8,
            color: Colors.grey));
  }

  Widget _buildPersonCard(
      String initials,
      String name,
      String subtitle,
      String roleLabel, {
        bool isConnected = false,
        Color avatarColor = const Color(0xFFD0CCEC),
      }) {
    // For students use a light purple avatar, staff/alumni use their passed color
    final bool isStudent = roleLabel == 'Student';
    final Color bgColor =
    isStudent ? const Color(0xFFD0CCEC) : avatarColor;
    final Color textColor =
    isStudent ? const Color(0xFF4A2C8F) : Colors.white;

    // Role badge colors
    Color roleBg;
    Color roleText;
    if (roleLabel == 'Staff') {
      roleBg = const Color(0xFFE0F4E8);
      roleText = const Color(0xFF34A853);
    } else if (roleLabel == 'Alumni') {
      roleBg = const Color(0xFFE0EEF8);
      roleText = const Color(0xFF4A9BE8);
    } else {
      roleBg = const Color(0xFFEEEBF8);
      roleText = const Color(0xFF4A2C8F);
    }

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 8,
              offset: const Offset(0, 2))
        ],
      ),
      child: Row(
        children: [
          // Avatar
          CircleAvatar(
            radius: 22,
            backgroundColor: bgColor,
            child: Text(initials,
                style: TextStyle(
                    color: textColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 14)),
          ),
          const SizedBox(width: 12),
          // Name + subtitle
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name,
                    style: const TextStyle(
                        fontSize: 15, fontWeight: FontWeight.w600)),
                const SizedBox(height: 2),
                Text(subtitle,
                    style: const TextStyle(fontSize: 12, color: Colors.grey)),
              ],
            ),
          ),
          const SizedBox(width: 8),
          // Role badge
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: roleBg,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(roleLabel,
                style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: roleText)),
          ),
          const SizedBox(width: 8),
          // Action button
          isConnected
              ? ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF4A2C8F),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(
                  horizontal: 14, vertical: 8),
              minimumSize: Size.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              textStyle: const TextStyle(
                  fontSize: 12, fontWeight: FontWeight.bold),
            ),
            child: const Text('Message'),
          )
              : OutlinedButton(
            onPressed: () {},
            style: OutlinedButton.styleFrom(
              foregroundColor: const Color(0xFF4A2C8F),
              side: const BorderSide(color: Color(0xFF4A2C8F)),
              padding: const EdgeInsets.symmetric(
                  horizontal: 14, vertical: 8),
              minimumSize: Size.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              textStyle: const TextStyle(
                  fontSize: 12, fontWeight: FontWeight.bold),
            ),
            child: const Text('Connect'),
          ),
        ],
      ),
    );
  }

  Widget _buildComingSoon(String tab) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.construction, size: 40, color: Colors.grey),
          const SizedBox(height: 12),
          Text('$tab coming soon',
              style: const TextStyle(color: Colors.grey, fontSize: 16)),
        ],
      ),
    );
  }
}