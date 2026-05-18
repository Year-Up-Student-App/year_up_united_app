import 'package:flutter/material.dart';
import '/widgets/mobile_widgets.dart';

/// Student Connections tab — search, cohort, staff, and alumni sections.
class ConnectionsScreen extends StatelessWidget {
  const ConnectionsScreen({super.key});

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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SectionLabel(
                    'Your cohort',
                    trailing: _countLabel('24 people'),
                  ),
                  _cohortCard(),
                  const SectionLabel('Staff'),
                  _staffCard(),
                  const SectionLabel('Alumni near you'),
                  _alumniCard(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 54, 20, 20),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [AppColors.primary, AppColors.primaryDark],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Connections',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w800,
              letterSpacing: -0.4,
            ),
          ),
          const SizedBox(height: 14),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
              boxShadow: [
                BoxShadow(
                  // ignore: deprecated_member_use
                  color: Colors.black.withOpacity(0.08),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: const Row(
              children: [
                Icon(Icons.search, size: 18, color: AppColors.text400),
                SizedBox(width: 10),
                Text(
                  'Search students, staff, alumni',
                  style: TextStyle(
                    color: AppColors.text400,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _countLabel(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 12,
        color: AppColors.text500,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  Widget _cohortCard() {
    return AppCard(
      padding: EdgeInsets.zero,
      child: Column(
        children: const [
          _PersonRow(
            initials: 'MR',
            name: 'Maya Robinson',
            subtitle: 'App Development · Wk 18',
            avatarBg: AppColors.purpleSoft,
            connected: true,
          ),
          _PersonRow(
            initials: 'TC',
            name: 'Tomas Chen',
            subtitle: 'Cybersecurity · Wk 18',
            avatarBg: AppColors.purpleSoft,
          ),
          _PersonRow(
            initials: 'AK',
            name: 'Aisha Kone',
            subtitle: 'App Development · Wk 18',
            avatarBg: AppColors.purpleSoft,
            connected: true,
            isLast: true,
          ),
        ],
      ),
    );
  }

  Widget _staffCard() {
    return AppCard(
      padding: EdgeInsets.zero,
      child: Column(
        children: const [
          _PersonRow(
            initials: 'LG',
            name: 'Coach Lauryn Garcia',
            subtitle: 'Your coach',
            avatarBg: AppColors.successBg,
            connected: true,
            isCoach: true,
          ),
          _PersonRow(
            initials: 'DW',
            name: 'Diana Wright',
            subtitle: 'Program Manager',
            avatarBg: AppColors.successBg,
            connectColor: AppColors.success,
            isLast: true,
          ),
        ],
      ),
    );
  }

  Widget _alumniCard() {
    return AppCard(
      padding: EdgeInsets.zero,
      child: Column(
        children: const [
          _PersonRow(
            initials: 'JM',
            name: 'Jameel McCoy',
            subtitle: "Cybersecurity · '23 · Capital One",
            avatarBg: AppColors.infoBg,
            connectColor: AppColors.info,
          ),
          _PersonRow(
            initials: 'SL',
            name: 'Sofia Liang',
            subtitle: "App Dev · '24 · Bank of America",
            avatarBg: AppColors.infoBg,
            connectColor: AppColors.info,
          ),
          _PersonRow(
            initials: 'RP',
            name: 'Raymond Park',
            subtitle: "IT · '22 · AT&T",
            avatarBg: AppColors.infoBg,
            connectColor: AppColors.info,
            isLast: true,
          ),
        ],
      ),
    );
  }
}

class _PersonRow extends StatelessWidget {
  final String initials;
  final String name;
  final String subtitle;
  final Color avatarBg;
  final bool connected;
  final bool isCoach;
  final bool isLast;
  final Color connectColor;

  const _PersonRow({
    required this.initials,
    required this.name,
    required this.subtitle,
    required this.avatarBg,
    this.connected = false,
    this.isCoach = false,
    this.isLast = false,
    this.connectColor = AppColors.primary,
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
          Avatar(initials: initials, color: avatarBg, size: 40),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        name,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 14.5,
                          fontWeight: FontWeight.w700,
                          color: AppColors.text900,
                        ),
                      ),
                    ),
                    if (isCoach) ...[
                      const SizedBox(width: 6),
                      const Pill(
                        label: 'COACH',
                        bg: AppColors.successBg,
                        color: AppColors.success,
                      ),
                    ],
                  ],
                ),
                const SizedBox(height: 1),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.text500,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          connected
              ? const Pill(label: 'Connected')
              : _buildConnectButton(connectColor),
        ],
      ),
    );
  }

  Widget _buildConnectButton(Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(999),
      ),
      child: const Text(
        'Connect',
        style: TextStyle(
          color: Colors.white,
          fontSize: 11,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
