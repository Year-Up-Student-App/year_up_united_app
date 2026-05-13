import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0EFF5),
      appBar: AppBar(
        backgroundColor: const Color(0xFF4A2C8F), // same purple as header
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildProfileHeader(),
              const SizedBox(height: 20),
              _buildInfoCard(
                title: 'Personal info',
                children: [
                  _buildInfoRow('Full name', 'Kendall Dillon'),
                  _buildInfoRow('Pronouns', 'He/Him'),
                  _buildInfoRow('Location', 'Red Oak, TX'),
                  _buildInfoRow('Phone', '773-383-8814', muted: true),
                  _buildInfoRow('LinkedIn', 'linkedin.com/in/kendall-dillon',
                      isLink: true),
                ],
              ),
              const SizedBox(height: 12),
              _buildInfoCard(
                title: 'About me',
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 8),
                    child: Text(
                      'Motivated IT student passionate about network security and helping teams solve technical problems. Looking to grow in the cybersecurity space after WBE.',
                      style: TextStyle(fontSize: 14, color: Colors.black87, height: 1.5),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              _buildInfoCard(
                title: 'Skills',
                children: [
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      'Network Security',
                      'Python',
                      'Help Desk',
                      'Linux',
                      'Customer Service',
                      'Java',
                      'Flutter',
                      'Spring boot',
                      'Github',
                      'Communication Skills',
                      'Scrum Master'
                    ].map((s) => _buildSkillChip(s)).toList(),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              _buildInfoCard(
                title: 'Career goals',
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 8),
                    child: Text(
                      'Aiming for a Jr Software Developer role, or a Developer Security role after completing the YU program and WBE internship.',
                      style: TextStyle(fontSize: 14, color: Colors.black87, height: 1.5),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  // ─── PROFILE HEADER ───────────────────────────────────────
  Widget _buildProfileHeader() {
    return Container(
      width: double.infinity,
      color: const Color(0xFF4A2C8F),
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 28),
      child: Column(
        children: [
          // Avatar with edit icon
          Stack(
            children: [
              const CircleAvatar(
                radius: 42,
                backgroundColor: Color(0xFFE8533F),
                child: Text('KD',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 26)),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.all(6),
                  decoration: const BoxDecoration(
                    color: Color(0xFF4A2C8F),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.edit, color: Colors.white, size: 14),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Text('Kendall Dillon',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          const Text('he/him · Red Oak, TX',
              style: TextStyle(color: Colors.white70, fontSize: 13)),
          const SizedBox(height: 14),
          // Tag pills
          Wrap(
            spacing: 8,
            children: [
              _buildPill('Student', outline: true),
              _buildPill('App Dev Track', filled: true),
              _buildPill("Spring '26", outline: true),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPill(String label,
      {bool outline = false, bool filled = false}) {
    if (filled) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
        decoration: BoxDecoration(
          color: const Color(0xFFE8533F),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(label,
            style: const TextStyle(
                color: Colors.white,
                fontSize: 13,
                fontWeight: FontWeight.w600)),
      );
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white54),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(label,
          style: const TextStyle(color: Colors.white, fontSize: 13)),
    );
  }

  // ─── INFO CARD ────────────────────────────────────────────
  Widget _buildInfoCard(
      {required String title, required List<Widget> children}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold)),
              const Text('Edit',
                  style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF4A2C8F),
                      fontWeight: FontWeight.w600)),
            ],
          ),
          ...children,
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value,
      {bool muted = false, bool isLink = false}) {
    return Padding(
      padding: const EdgeInsets.only(top: 14),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style:
              const TextStyle(fontSize: 14, color: Colors.grey)),
          Text(value,
              style: TextStyle(
                  fontSize: 14,
                  color: isLink
                      ? const Color(0xFF4A9BE8)
                      : muted
                      ? Colors.grey
                      : Colors.black87,
                  fontWeight:
                  muted ? FontWeight.normal : FontWeight.w500)),
        ],
      ),
    );
  }

  Widget _buildSkillChip(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFFF0EDF8),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(label,
          style: const TextStyle(
              fontSize: 13,
              color: Color(0xFF4A2C8F),
              fontWeight: FontWeight.w500)),
    );
  }
}