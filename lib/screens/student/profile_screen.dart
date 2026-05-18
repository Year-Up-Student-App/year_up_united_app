import 'package:flutter/material.dart';
import '../../widgets/mobile_widgets.dart';

/// Student profile screen — reached from the More sheet or the Home avatar.
/// Matches the ProfileScreen from the prototype: centered avatar hero,
/// program-status grid, coach card, about-me text, personal info,
/// program info, then a big "Edit profile" button.
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            PhoneHeader(
              title: 'My Profile',
              onBack: () => Navigator.of(context).pop(),
              trailing: _gearButton(),
            ),
            // Centered avatar block, continues the purple gradient.
            Transform.translate(
              offset: const Offset(0, -8),
              child: _buildAvatarBlock(),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 14, 16, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SectionLabel('Program status'),
                  _buildStatusGrid(),
                  const SectionLabel('My coach'),
                  _buildCoachCard(),
                  const SectionLabel('About me'),
                  _buildAboutCard(),
                  const SectionLabel('Personal info'),
                  _buildPersonalInfo(),
                  const SectionLabel('Program info'),
                  _buildProgramInfo(),
                  const SizedBox(height: 20),
                  _buildEditButton(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _gearButton() {
    return InkWell(
      onTap: () {},
      borderRadius: BorderRadius.circular(999),
      child: Container(
        width: 36,
        height: 36,
        decoration: const BoxDecoration(
          color: Color(0x2EFFFFFF),
          shape: BoxShape.circle,
        ),
        alignment: Alignment.center,
        child: const Icon(Icons.settings_outlined,
            size: 18, color: Colors.white),
      ),
    );
  }

  Widget _buildAvatarBlock() {
    return Container(
      padding: const EdgeInsets.fromLTRB(22, 0, 22, 28),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [AppColors.primary, AppColors.primaryDark],
        ),
      ),
      child: Column(
        children: const [
          Avatar(initials: 'JD', color: AppColors.accent, size: 88),
          SizedBox(height: 10),
          Text(
            'Jordan Dawson',
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.w800,
              letterSpacing: -0.4,
            ),
          ),
          SizedBox(height: 2),
          Text(
            'App Development · Dallas LC',
            style: TextStyle(
              color: Color(0xCCFFFFFF), // 80% white
              fontSize: 13.5,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 12),
          Wrap(
            spacing: 6,
            children: [
              Pill(
                label: 'they/them',
                bg: Color(0x2EFFFFFF),
                color: Colors.white,
              ),
              Pill(
                label: 'Training phase',
                bg: Color(0x2EFFFFFF),
                color: Colors.white,
              ),
              Pill(
                label: 'Week 18',
                bg: Color(0x2EFFFFFF),
                color: Colors.white,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatusGrid() {
    return Column(
      children: const [
        Row(
          children: [
            Expanded(
              child: StatusTile(
                label: 'Contract points',
                value: '247 / 250',
                tone: AppColors.success,
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: StatusTile(
                label: 'EPIC plan',
                value: 'None active',
                tone: AppColors.text500,
              ),
            ),
          ],
        ),
        SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: StatusTile(
                label: 'Attendance',
                value: '96%',
                tone: AppColors.success,
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: StatusTile(
                label: 'WBE status',
                value: 'In progress',
                tone: AppColors.primary,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildCoachCard() {
    return AppCard(
      padding: const EdgeInsets.all(14),
      child: Row(
        children: [
          const Avatar(
            initials: 'LG',
            color: AppColors.successBg,
            size: 48,
          ),
          const SizedBox(width: 12),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Lauryn Garcia',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: AppColors.text900,
                  ),
                ),
                SizedBox(height: 1),
                Text(
                  'Coach · Dallas LC',
                  style: TextStyle(
                    fontSize: 12.5,
                    color: AppColors.text500,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          _coachActionButton(Icons.chat_bubble_outline),
          const SizedBox(width: 6),
          _coachActionButton(Icons.mail_outline),
        ],
      ),
    );
  }

  Widget _coachActionButton(IconData icon) {
    return InkWell(
      onTap: () {},
      borderRadius: BorderRadius.circular(999),
      child: Container(
        width: 36,
        height: 36,
        decoration: const BoxDecoration(
          color: AppColors.surfaceAlt,
          shape: BoxShape.circle,
        ),
        alignment: Alignment.center,
        child: Icon(icon, size: 18, color: AppColors.text700),
      ),
    );
  }

  Widget _buildAboutCard() {
    return const AppCard(
      padding: EdgeInsets.all(14),
      child: Text(
        'Career-changer from food service into tech. Mom of two, weekend coder, '
        'loves building small apps that solve everyday problems for my '
        'community. Working towards a junior dev role on a friendly team.',
        style: TextStyle(
          fontSize: 13.5,
          color: AppColors.text700,
          height: 1.55,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildPersonalInfo() {
    return const AppCard(
      padding: EdgeInsets.zero,
      child: Column(
        children: [
          InfoRow(
            icon: Icons.person_outline,
            label: 'Legal name',
            value: 'Jordan Avery Dawson',
          ),
          InfoRow(
            icon: Icons.location_on_outlined,
            label: 'Location',
            value: 'Mesquite, TX',
          ),
          InfoRow(
            icon: Icons.phone_outlined,
            label: 'Phone',
            value: '(•••) ••• 2841',
          ),
          InfoRow(
            icon: Icons.link,
            label: 'LinkedIn',
            value: 'linkedin.com/in/jordan-dawson',
            isLast: true,
          ),
        ],
      ),
    );
  }

  Widget _buildProgramInfo() {
    return const AppCard(
      padding: EdgeInsets.zero,
      child: Column(
        children: [
          InfoRow(
            icon: Icons.work_outline,
            label: 'Pathway',
            value: 'Application Development',
          ),
          InfoRow(
            icon: Icons.business_outlined,
            label: 'Learning Community',
            value: 'Dallas LC',
          ),
          InfoRow(
            icon: Icons.people_outline,
            label: 'Cohort',
            value: "Spring '26",
          ),
          InfoRow(
            icon: Icons.calendar_today_outlined,
            label: 'Start date',
            value: 'Jan 6, 2026',
            isLast: true,
          ),
        ],
      ),
    );
  }

  Widget _buildEditButton() {
    return InkWell(
      onTap: () {},
      borderRadius: BorderRadius.circular(14),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 18),
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              // ignore: deprecated_member_use
              color: AppColors.primary.withOpacity(0.25),
              blurRadius: 16,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.edit_outlined, color: Colors.white, size: 18),
            SizedBox(width: 8),
            Text(
              'Edit profile',
              style: TextStyle(
                color: Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
