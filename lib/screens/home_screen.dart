import 'package:flutter/material.dart';
import 'package:flutter_app/services/api_service.dart';

const _primary = Color(0xFF3D1D8C);
const _primaryDark = Color(0xFF2B1167);
const _accent = Color(0xFFF25C3E);
const _orange = Color(0xFFF8941F);

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Map<String, dynamic>? student;

  @override
  void initState() {
    super.initState();
    _loadStudent();
  }

  Future<void> _loadStudent() async {
    final data = await ApiService.getStudent(1);
    setState(() {
      student = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F9),
      body: Column(
        children: [
          _buildHeader(),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildProgressCard(),
                  _buildSectionLabel('Upcoming & To-Dos'),
                  _buildTodoCard(
                    month: 'MAY', day: '8',
                    title: 'Weekly contract review',
                    subtitle: 'Today · 2:00 PM',
                    tag: 'To-do',
                    tagBg: const Color(0xFFFFE2DC),
                    tagText: const Color(0xFFE55738),
                    stripe: _primary,
                    dateBg: _primary,
                  ),
                  _buildTodoCard(
                    month: 'MAY', day: '9',
                    title: 'Professional skills workshop',
                    subtitle: 'Thu · 10:00 AM',
                    tag: 'Event',
                    tagBg: const Color(0xFFFFE9CE),
                    tagText: const Color(0xFFC97A12),
                    stripe: _orange,
                    dateBg: _orange,
                  ),
                  _buildTodoCard(
                    month: 'MAY', day: '10',
                    title: 'Submit reflection journal',
                    subtitle: 'Fri · Due by 5 PM',
                    tag: 'To-do',
                    tagBg: const Color(0xFFFFE2DC),
                    tagText: const Color(0xFFE55738),
                    stripe: _primary,
                    dateBg: _primary,
                  ),
                  _buildSectionLabel('Announcements'),
                  _buildAnnouncementCard(),
                  const SizedBox(height: 8),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    final firstName = student?['firstName'] ?? '';
    final lastName = student?['lastName'] ?? '';
    final initials = firstName.isNotEmpty && lastName.isNotEmpty
        ? '${firstName[0]}${lastName[0]}'
        : '??';
    final lcName = student?['learningCommunity']?['name'] ?? 'Loading...';

    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [_primary, _primaryDark],
        ),
      ),
      padding: const EdgeInsets.fromLTRB(22, 56, 22, 28),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  student == null
                      ? 'Good morning 👋'
                      : 'Good morning, $firstName 👋',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 26,
                    fontWeight: FontWeight.w700,
                    letterSpacing: -0.5,
                    height: 1.15,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  '$lcName · Week 18',
                  style: const TextStyle(
                    color: Color(0xBFFFFFFF),
                    fontSize: 13.5,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          CircleAvatar(
            radius: 21,
            backgroundColor: _accent,
            child: Text(
              initials,
              style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProgressCard() {
    return Container(
      margin: const EdgeInsets.only(top: 0, bottom: 0),
      transform: Matrix4.translationValues(0, -8, 0),
      padding: const EdgeInsets.fromLTRB(18, 18, 18, 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 8,
              offset: const Offset(0, 2)),
          BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 32,
              offset: const Offset(0, 12)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                'PROGRAM PROGRESS',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.88,
                  color: Color(0xFF7A7A86),
                ),
              ),
              Text(
                '62%',
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: _primary),
              ),
            ],
          ),
          const SizedBox(height: 8),
          const Text(
            'Training Phase — 18 of 29 weeks',
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: Color(0xFF18181F),
                letterSpacing: -0.2),
          ),
          const SizedBox(height: 14),
          ClipRRect(
            borderRadius: BorderRadius.circular(999),
            child: Container(
              height: 8,
              color: const Color(0xFFF0F0F4),
              child: FractionallySizedBox(
                widthFactor: 1.0,
                child: LayoutBuilder(
                  builder: (_, constraints) => Stack(
                    children: [
                      ShaderMask(
                        shaderCallback: (rect) => const LinearGradient(
                          colors: [_primary, _accent],
                        ).createShader(rect),
                        child: Container(
                          width: constraints.maxWidth * 0.62,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              _buildStatBox('18 wks', 'Training complete'),
              const SizedBox(width: 10),
              _buildStatBox('11 wks', 'Until WBE phase'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatBox(String value, String label) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.fromLTRB(14, 12, 14, 12),
        decoration: BoxDecoration(
          color: const Color(0xFFF0F0F4),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              value,
              style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: _primary,
                  letterSpacing: -0.3),
            ),
            const SizedBox(height: 2),
            Text(label,
                style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFF7A7A86),
                    fontWeight: FontWeight.w500)),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionLabel(String label) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(4, 16, 4, 12),
      child: Text(
        label.toUpperCase(),
        style: const TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.88,
          color: Color(0xFF7A7A86),
        ),
      ),
    );
  }

  Widget _buildTodoCard({
    required String month,
    required String day,
    required String title,
    required String subtitle,
    required String tag,
    required Color tagBg,
    required Color tagText,
    required Color stripe,
    required Color dateBg,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 6,
              offset: const Offset(0, 1))
        ],
      ),
      clipBehavior: Clip.hardEdge,
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(width: 4, color: stripe),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(14, 12, 14, 12),
                child: Row(
                  children: [
                    Container(
                      width: 46,
                      height: 46,
                      decoration: BoxDecoration(
                          color: dateBg,
                          borderRadius: BorderRadius.circular(11)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            month,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 9,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 0.5,
                            ),
                          ),
                          Text(
                            day,
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                                height: 1.05),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            title,
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF18181F),
                              letterSpacing: -0.1,
                              height: 1.25,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            subtitle,
                            style: const TextStyle(
                                fontSize: 12.5,
                                color: Color(0xFF7A7A86),
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                          color: tagBg,
                          borderRadius: BorderRadius.circular(999)),
                      child: Text(tag,
                          style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                              color: tagText)),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAnnouncementCard() {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 4,
              offset: const Offset(0, 1))
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 5),
            child: Container(
              width: 7,
              height: 7,
              decoration: const BoxDecoration(
                  color: _accent, shape: BoxShape.circle),
            ),
          ),
          const SizedBox(width: 10),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'New WBE placements posted',
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF18181F)),
                ),
                SizedBox(height: 4),
                Text(
                  'Check the internship board — 12 new positions added this week.',
                  style: TextStyle(
                      fontSize: 13,
                      color: Color(0xFF7A7A86),
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
