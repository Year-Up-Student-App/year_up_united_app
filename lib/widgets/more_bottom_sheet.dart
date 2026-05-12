import 'package:flutter/material.dart';
import 'auth_widgets.dart';

void showMoreBottomSheet(BuildContext context, {required VoidCallback onSignOut, required VoidCallback onViewProfile}) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (_) => _MoreSheet(onSignOut: onSignOut, onViewProfile: onViewProfile),
  );
}

class _MoreSheet extends StatelessWidget {
  final VoidCallback onSignOut;
  final VoidCallback onViewProfile;

  const _MoreSheet({required this.onSignOut, required this.onViewProfile});

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.88,
      minChildSize: 0.5,
      maxChildSize: 0.92,
      builder: (_, controller) => Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 40, offset: Offset(0, -10))],
        ),
        child: Column(
          children: [
            const SizedBox(height: 10),
            Center(
              child: Container(
                width: 36,
                height: 4,
                decoration: BoxDecoration(color: kGray300, borderRadius: BorderRadius.circular(999)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'More',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800, letterSpacing: -0.4, color: kGray900),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: Container(
                      width: 32,
                      height: 32,
                      decoration: const BoxDecoration(color: kGray100, shape: BoxShape.circle),
                      child: const Icon(Icons.close, size: 16, color: kGray700),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                controller: controller,
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 32),
                children: [
                  _buildProfileHeader(context),
                  const SizedBox(height: 4),
                  _buildSection('Account', [
                    _MoreItem(
                      icon: Icons.person_outline,
                      label: 'Profile & contact info',
                      sub: 'Name, phone, emergency contact',
                      onTap: () {},
                    ),
                    _MoreItem(
                      icon: Icons.notifications_outlined,
                      label: 'Notifications',
                      sub: 'Push, email & reminders',
                      onTap: () {},
                    ),
                    _MoreItem(
                      icon: Icons.lock_outline,
                      label: 'Password & security',
                      onTap: () {},
                    ),
                  ]),
                  _buildSection('Resources', [
                    _MoreItem(
                      icon: Icons.menu_book_outlined,
                      label: 'Learning hub',
                      sub: 'Curriculum, recordings, slides',
                      onTap: () {},
                    ),
                    _MoreItem(
                      icon: Icons.work_outline,
                      label: 'Career resources',
                      sub: 'Resume builder, interview prep',
                      onTap: () {},
                    ),
                    _MoreItem(
                      icon: Icons.school_outlined,
                      label: 'Alumni directory',
                      onTap: () {},
                    ),
                  ]),
                  _buildSection('Support', [
                    _MoreItem(icon: Icons.help_outline, label: 'Help center', onTap: () {}),
                    _MoreItem(icon: Icons.chat_bubble_outline, label: 'Send feedback', onTap: () {}),
                    _MoreItem(
                      icon: Icons.info_outline,
                      label: 'About Connect',
                      sub: 'Version 2.4.1',
                      onTap: () {},
                    ),
                  ]),
                  const Divider(color: kGray100, height: 24),
                  _MoreItem(
                    icon: Icons.logout,
                    label: 'Sign out',
                    danger: true,
                    onTap: () {
                      Navigator.of(context).pop();
                      onSignOut();
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 18),
      child: Row(
        children: [
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: kAccent,
              shape: BoxShape.circle,
              boxShadow: [BoxShadow(color: kAccent.withOpacity(0.31), blurRadius: 16, offset: const Offset(0, 6))],
            ),
            child: const Center(
              child: Text(
                'JD',
                style: TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.w700),
              ),
            ),
          ),
          const SizedBox(width: 12),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Jordan Dawson',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: kGray900),
                ),
                SizedBox(height: 2),
                Text(
                  "Dallas LC · Class of Spring '26",
                  style: TextStyle(fontSize: 12.5, color: kGray500, fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
              onViewProfile();
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
              decoration: BoxDecoration(
                color: kGray100,
                borderRadius: BorderRadius.circular(999),
              ),
              child: const Text(
                'View',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: kGray700),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSection(String title, List<Widget> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 4),
          child: Text(
            title.toUpperCase(),
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.8,
              color: kGray400,
            ),
          ),
        ),
        ...items,
        const SizedBox(height: 10),
      ],
    );
  }
}

class _MoreItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String? sub;
  final bool danger;
  final VoidCallback? onTap;

  const _MoreItem({
    required this.icon,
    required this.label,
    this.sub,
    this.danger = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final iconColor = danger ? kDanger : kPrimary;
    final iconBg = danger ? const Color(0xFFFFE6E6) : kGray100;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
        child: Row(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(color: iconBg, borderRadius: BorderRadius.circular(10)),
              child: Icon(icon, size: 19, color: iconColor),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: TextStyle(
                      fontSize: 14.5,
                      fontWeight: FontWeight.w600,
                      color: danger ? kDanger : kGray900,
                    ),
                  ),
                  if (sub != null) ...[
                    const SizedBox(height: 1),
                    Text(sub!, style: const TextStyle(fontSize: 12, color: kGray500, fontWeight: FontWeight.w500)),
                  ],
                ],
              ),
            ),
            if (!danger) const Icon(Icons.arrow_forward_ios, size: 14, color: kGray400),
          ],
        ),
      ),
    );
  }
}