import 'package:flutter/material.dart';
import '../../../widgets/mobile_widgets.dart';
import '../staff/staff_student_detail_screen.dart';

/// Staff Home tab — coach dashboard with alerts, quick actions, and
/// at-risk students. Matches `StaffHomeScreen` from the prototype.
class StaffHomeScreen extends StatelessWidget {
  /// Called when the user taps an at-risk row or a "View all" button — opens
  /// the student detail. Provided as a callback so the parent owning the
  /// staff tab navigation can decide whether to drill in.
  final VoidCallback? onOpenStudent;

  /// Switch to another tab in the staff scaffold (e.g. taps on "Generate QR"
  /// take you to the QR tab). The parent's tab controller listens.
  final ValueChanged<String>? onSwitchTab;

  const StaffHomeScreen({
    super.key,
    this.onOpenStudent,
    this.onSwitchTab,
  });

  void _openStudent(BuildContext context) {
    if (onOpenStudent != null) {
      onOpenStudent!();
      return;
    }
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => const StaffStudentDetailScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.bg,
      child: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildHeader(),
            Transform.translate(
              offset: const Offset(0, -8),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _buildAlertBanner(),
                    const SectionLabel('Quick actions'),
                    _buildQuickActions(),
                    SectionLabel(
                      'Needs attention',
                      trailing: TextButton(
                        onPressed: () {},
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                          minimumSize: const Size(0, 0),
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        child: const Text(
                          'View all',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: AppColors.primary,
                          ),
                        ),
                      ),
                    ),
                    _buildAtRiskList(context),
                    const SectionLabel("Today's schedule"),
                    _buildScheduleCard(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.fromLTRB(22, 64, 22, 24),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [AppColors.primary, AppColors.primaryDark],
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: const [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Good morning, Lauryn',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    letterSpacing: -0.5,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Coach · Dallas LC · 24 students',
                  style: TextStyle(
                    color: Color(0xC7FFFFFF),
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          Avatar(initials: 'LG', color: AppColors.success, size: 42),
        ],
      ),
    );
  }

  Widget _buildAlertBanner() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.warnBg,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFF8B568)),
      ),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: const BoxDecoration(
              color: AppColors.orange,
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: const Icon(
              Icons.warning_amber_rounded,
              color: Colors.white,
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '3 students need attention',
                  style: TextStyle(
                    fontSize: 13.5,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF7A4A0E),
                  ),
                ),
                SizedBox(height: 1),
                Text(
                  'Low contract points or 2+ absences this week',
                  style: TextStyle(
                    fontSize: 12,
                    color: Color(0xCC7A4A0E),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          const Icon(Icons.chevron_right, size: 18, color: Color(0xFF7A4A0E)),
        ],
      ),
    );
  }

  Widget _buildQuickActions() {
    return Row(
      children: [
        Expanded(
          child: _QuickAction(
            icon: Icons.calendar_today_outlined,
            label: 'Attendance',
            color: AppColors.primary,
            onTap: () => onSwitchTab?.call('staff-attendance'),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: _QuickAction(
            icon: Icons.qr_code,
            label: 'Generate QR',
            color: AppColors.success,
            onTap: () => onSwitchTab?.call('staff-qr'),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: _QuickAction(
            icon: Icons.people_outline,
            label: 'Roster',
            color: AppColors.warn,
            onTap: () => onSwitchTab?.call('staff-roster'),
          ),
        ),
      ],
    );
  }

  Widget _buildAtRiskList(BuildContext context) {
    final rows = [
      const _AtRiskRow(
        initials: 'MR',
        name: 'Maya Robinson',
        pathway: 'App Development',
        issue: '2 absences this week',
        issueColor: AppColors.danger,
      ),
      const _AtRiskRow(
        initials: 'TC',
        name: 'Tomas Chen',
        pathway: 'Cybersecurity',
        issue: '94 pts · below threshold',
        issueColor: AppColors.danger,
      ),
      const _AtRiskRow(
        initials: 'JD',
        name: 'Jordan Dawson',
        pathway: 'App Development',
        issue: '1 tardy this week',
        issueColor: AppColors.warn,
        isLast: true,
      ),
    ];
    return AppCard(
      padding: EdgeInsets.zero,
      child: Column(
        children: [
          for (final r in rows)
            InkWell(
              onTap: () => _openStudent(context),
              borderRadius: BorderRadius.zero,
              child: r,
            ),
        ],
      ),
    );
  }

  Widget _buildScheduleCard() {
    return AppCard(
      padding: const EdgeInsets.all(14),
      child: IntrinsicHeight(
        child: Row(
          children: [
            Container(
              width: 4,
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(999),
              ),
            ),
            const SizedBox(width: 12),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Cohort huddle',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: AppColors.text900,
                    ),
                  ),
                  SizedBox(height: 2),
                  Text(
                    '9:00 AM · Room 204 · 24 students',
                    style: TextStyle(
                      fontSize: 12,
                      color: AppColors.text500,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            const Pill(
              label: 'NEXT',
              bg: AppColors.purpleSoft,
              color: AppColors.primary,
            ),
          ],
        ),
      ),
    );
  }
}

class _QuickAction extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback? onTap;

  const _QuickAction({
    required this.icon,
    required this.label,
    required this.color,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding: const EdgeInsets.all(12),
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              // ignore: deprecated_member_use
              color: color.withOpacity(0.09),
              borderRadius: BorderRadius.circular(11),
            ),
            alignment: Alignment.center,
            child: Icon(icon, size: 18, color: color),
          ),
          const SizedBox(height: 6),
          Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              color: AppColors.text900,
              letterSpacing: -0.1,
              height: 1.25,
            ),
          ),
        ],
      ),
    );
  }
}

class _AtRiskRow extends StatelessWidget {
  final String initials;
  final String name;
  final String pathway;
  final String issue;
  final Color issueColor;
  final bool isLast;

  const _AtRiskRow({
    required this.initials,
    required this.name,
    required this.pathway,
    required this.issue,
    required this.issueColor,
    this.isLast = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(14, 12, 14, 12),
      decoration: BoxDecoration(
        border: isLast
            ? null
            : const Border(
                bottom: BorderSide(color: AppColors.borderLight),
              ),
      ),
      child: Row(
        children: [
          Avatar(initials: initials, color: AppColors.purpleSoft, size: 40),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: AppColors.text900,
                  ),
                ),
                Text(
                  pathway,
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.text500,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          Text(
            issue,
            textAlign: TextAlign.right,
            style: TextStyle(
              fontSize: 11.5,
              fontWeight: FontWeight.w700,
              color: issueColor,
            ),
          ),
          const SizedBox(width: 6),
          const Icon(Icons.chevron_right, size: 16, color: AppColors.text400),
        ],
      ),
    );
  }
}
