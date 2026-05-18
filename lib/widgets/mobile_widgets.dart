import 'package:flutter/material.dart';

/// Color tokens shared across all mobile screens (student + staff).
/// Mirrors the CSS :root variables and inline hex values from the prototype.
class AppColors {
  // Brand
  static const primary = Color(0xFF3D1D8C);
  static const primaryDark = Color(0xFF2B1167);
  static const accent = Color(0xFFF25C3E);
  static const orange = Color(0xFFF8941F);

  // Surfaces
  static const bg = Color(0xFFF7F7F9);
  static const surface = Colors.white;
  static const surfaceAlt = Color(0xFFF0F0F4);

  // Borders
  static const border = Color(0xFFE5E5EC);
  static const borderLight = Color(0xFFF0F0F4);

  // Text
  static const text900 = Color(0xFF18181F);
  static const text700 = Color(0xFF41414A);
  static const text500 = Color(0xFF7A7A86);
  static const text400 = Color(0xFFA8A8B3);

  // Status — pairs of (foreground, soft background)
  static const success = Color(0xFF1E7F5A);
  static const successBg = Color(0xFFE9F7F0);
  static const warn = Color(0xFFC97A12);
  static const warnBg = Color(0xFFFFE9CE);
  static const danger = Color(0xFFC73838);
  static const dangerBg = Color(0xFFFFE6E6);
  static const info = Color(0xFF1E4FA6);
  static const infoBg = Color(0xFFE5EEFC);

  // Soft purple (used for student initials, EPIC pills, etc.)
  static const purpleSoft = Color(0xFFEEE9FB);
}

/// White rounded card with the prototype's signature double-shadow.
class AppCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry? margin;
  final VoidCallback? onTap;

  const AppCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(16),
    this.margin,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final card = Container(
      margin: margin,
      padding: padding,
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            // ignore: deprecated_member_use
            color: AppColors.text900.withOpacity(0.05),
            blurRadius: 3,
            offset: const Offset(0, 1),
          ),
          BoxShadow(
            // ignore: deprecated_member_use
            color: AppColors.text900.withOpacity(0.03),
            blurRadius: 24,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: child,
    );
    if (onTap == null) return card;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: card,
    );
  }
}

/// Small uppercase section label, optionally with a trailing widget on the right.
/// Matches the SectionLabel component from the prototype.
class SectionLabel extends StatelessWidget {
  final String text;
  final Widget? trailing;

  const SectionLabel(this.text, {super.key, this.trailing});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(4, 20, 4, 10),
      child: Row(
        children: [
          Expanded(
            child: Text(
              text.toUpperCase(),
              style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w700,
                color: AppColors.text500,
                letterSpacing: 0.8,
              ),
            ),
          ),
          if (trailing != null) trailing!,
        ],
      ),
    );
  }
}

/// Rounded tag pill — used for status, EPIC, role badges, etc.
class Pill extends StatelessWidget {
  final String label;
  final Color bg;
  final Color color;
  final EdgeInsetsGeometry? margin;

  const Pill({
    super.key,
    required this.label,
    this.bg = AppColors.surfaceAlt,
    this.color = AppColors.text700,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: color,
          fontSize: 11,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.2,
        ),
      ),
    );
  }
}

/// Circular initial avatar. Picks a contrasting text color automatically when
/// given one of the light pastel backgrounds the prototype uses.
class Avatar extends StatelessWidget {
  final String initials;
  final Color color;
  final double size;
  final Color? textColor;

  const Avatar({
    super.key,
    required this.initials,
    this.color = AppColors.accent,
    this.size = 40,
    this.textColor,
  });

  /// Resolves text color: explicit override > light-bg lookup > white.
  Color get _resolvedTextColor {
    if (textColor != null) return textColor!;
    // Light-bg → matching foreground (same mapping as the prototype's
    // Avatar override in staff-screens.jsx)
    if (color == AppColors.purpleSoft) return AppColors.primary;
    if (color == AppColors.successBg) return AppColors.success;
    if (color == AppColors.infoBg) return AppColors.info;
    if (color == AppColors.warnBg) return AppColors.warn;
    if (color == AppColors.dangerBg) return AppColors.danger;
    if (color == AppColors.surfaceAlt) return AppColors.text700;
    return Colors.white;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(shape: BoxShape.circle, color: color),
      alignment: Alignment.center,
      child: Text(
        initials,
        style: TextStyle(
          color: _resolvedTextColor,
          fontWeight: FontWeight.w700,
          fontSize: size * 0.36,
        ),
      ),
    );
  }
}

/// Purple gradient header that sits above the scroll content on most screens.
/// Includes an optional back button (left) and trailing action (right).
class PhoneHeader extends StatelessWidget {
  final String title;
  final String? subtitle;
  final VoidCallback? onBack;
  final Widget? trailing;
  final Widget? bottom;

  const PhoneHeader({
    super.key,
    required this.title,
    this.subtitle,
    this.onBack,
    this.trailing,
    this.bottom,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 54, 20, 18),
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
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (onBack != null) ...[
                _HeaderCircleButton(
                  icon: Icons.arrow_back_ios_new,
                  onTap: onBack!,
                ),
                const SizedBox(width: 12),
              ],
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                        letterSpacing: -0.4,
                        height: 1.1,
                      ),
                    ),
                    if (subtitle != null) ...[
                      const SizedBox(height: 2),
                      Text(
                        subtitle!,
                        style: const TextStyle(
                          color: Color(0xC7FFFFFF), // 78% white
                          fontSize: 12.5,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              if (trailing != null) trailing!,
            ],
          ),
          if (bottom != null) ...[const SizedBox(height: 14), bottom!],
        ],
      ),
    );
  }
}

/// Small translucent-white circle button used in the purple header.
class _HeaderCircleButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  const _HeaderCircleButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(999),
      child: Container(
        width: 36,
        height: 36,
        decoration: const BoxDecoration(
          // ignore: deprecated_member_use
          color: Color(0x2EFFFFFF),
          shape: BoxShape.circle,
        ),
        alignment: Alignment.center,
        child: Icon(icon, size: 18, color: Colors.white),
      ),
    );
  }
}

/// Two-up status tile (e.g. profile screen's "Contract points / EPIC plan" grid).
class StatusTile extends StatelessWidget {
  final String label;
  final String value;
  final Color tone;

  const StatusTile({
    super.key,
    required this.label,
    required this.value,
    required this.tone,
  });

  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label.toUpperCase(),
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              color: AppColors.text500,
              letterSpacing: 0.4,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            value,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w800,
              color: tone,
              letterSpacing: -0.2,
            ),
          ),
        ],
      ),
    );
  }
}

/// Stat card with a small "STAT" badge — used on the student attendance screen.
class StatCard extends StatelessWidget {
  final String value;
  final String label;
  final Color tone;
  final Color toneBg;

  const StatCard({
    super.key,
    required this.value,
    required this.label,
    required this.tone,
    required this.toneBg,
  });

  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            decoration: BoxDecoration(
              color: toneBg,
              borderRadius: BorderRadius.circular(999),
            ),
            child: Text(
              'STAT',
              style: TextStyle(
                color: tone,
                fontSize: 10,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.3,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.w800,
              color: AppColors.text900,
              letterSpacing: -0.7,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              color: AppColors.text500,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

/// Single row inside a card list — leading icon, label, value.
/// Used on profile, staff student detail, etc.
class InfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final bool isLast;

  const InfoRow({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
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
          Icon(icon, size: 18, color: AppColors.text500),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 11.5,
                    color: AppColors.text500,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.2,
                  ),
                ),
                const SizedBox(height: 1),
                Text(
                  value,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.text900,
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
