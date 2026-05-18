import 'package:flutter/material.dart';
import '../../../widgets/mobile_widgets.dart';
import '../staff/staff_student_detail_screen.dart';

/// Staff Roster tab — list of all students in the coach's LC, with filter
/// chips (All / At Risk / EPIC Plan), search bar, and tappable rows that
/// drill into the student detail.
class StaffRosterScreen extends StatefulWidget {
  const StaffRosterScreen({super.key});

  @override
  State<StaffRosterScreen> createState() => _StaffRosterScreenState();
}

class _StaffRosterScreenState extends State<StaffRosterScreen> {
  String _filter = 'All';

  static const _students = [
    _Student(
      name: 'Aisha Kone',
      initials: 'AK',
      pathway: 'App Development',
      points: 248,
      atRisk: false,
      epic: false,
    ),
    _Student(
      name: 'Jordan Dawson',
      initials: 'JD',
      pathway: 'App Development',
      points: 247,
      atRisk: false,
      epic: false,
    ),
    _Student(
      name: 'Maya Robinson',
      initials: 'MR',
      pathway: 'App Development',
      points: 162,
      atRisk: true,
      epic: true,
    ),
    _Student(
      name: 'Tomas Chen',
      initials: 'TC',
      pathway: 'Cybersecurity',
      points: 94,
      atRisk: true,
      epic: true,
    ),
    _Student(
      name: 'Sasha Klein',
      initials: 'SK',
      pathway: 'IT',
      points: 218,
      atRisk: false,
      epic: false,
    ),
    _Student(
      name: 'Devon Park',
      initials: 'DP',
      pathway: 'IT',
      points: 201,
      atRisk: false,
      epic: false,
    ),
    _Student(
      name: 'Camila Reyes',
      initials: 'CR',
      pathway: 'Cybersecurity',
      points: 188,
      atRisk: false,
      epic: false,
    ),
    _Student(
      name: 'Marcus Boyd',
      initials: 'MB',
      pathway: 'App Development',
      points: 131,
      atRisk: false,
      epic: true,
    ),
  ];

  List<_Student> get _visible {
    switch (_filter) {
      case 'At Risk':
        return _students.where((s) => s.atRisk).toList();
      case 'EPIC Plan':
        return _students.where((s) => s.epic).toList();
      default:
        return _students;
    }
  }

  /// Points → foreground/background pair. 200+ green, 100+ amber, else red.
  ({Color color, Color bg}) _pointsColors(int p) {
    if (p >= 200) return (color: AppColors.success, bg: AppColors.successBg);
    if (p >= 100) return (color: AppColors.warn, bg: AppColors.warnBg);
    return (color: AppColors.danger, bg: AppColors.dangerBg);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.bg,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildHeader(),
          _buildFilters(),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
              child: AppCard(
                padding: EdgeInsets.zero,
                child: Column(
                  children: [
                    for (var i = 0; i < _visible.length; i++)
                      _buildRow(
                        _visible[i],
                        isLast: i == _visible.length - 1,
                      ),
                  ],
                ),
              ),
            ),
          ),
        ],
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
            'Students — Dallas LC',
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
            ),
            child: const Row(
              children: [
                Icon(Icons.search, size: 18, color: AppColors.text400),
                SizedBox(width: 10),
                Text(
                  'Search students',
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

  Widget _buildFilters() {
    final filters = ['All', 'At Risk', 'EPIC Plan'];
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            for (final f in filters) ...[
              _FilterChip(
                label: f,
                active: _filter == f,
                onTap: () => setState(() => _filter = f),
              ),
              if (f != filters.last) const SizedBox(width: 8),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildRow(_Student s, {required bool isLast}) {
    final colors = _pointsColors(s.points);
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => StaffStudentDetailScreen(
              studentName: s.name,
              initials: s.initials,
              pathway: s.pathway,
              startingPoints: s.points,
            ),
          ),
        );
      },
      child: Container(
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
            Avatar(initials: s.initials, color: AppColors.purpleSoft, size: 40),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Flexible(
                        child: Text(
                          s.name,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: AppColors.text900,
                          ),
                        ),
                      ),
                      if (s.epic) ...[
                        const SizedBox(width: 6),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: AppColors.warnBg,
                            borderRadius: BorderRadius.circular(999),
                          ),
                          child: const Text(
                            'EPIC',
                            style: TextStyle(
                              fontSize: 9,
                              fontWeight: FontWeight.w700,
                              color: AppColors.warn,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                  const SizedBox(height: 1),
                  Text(
                    s.pathway,
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppColors.text500,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            Pill(
              label: '${s.points} pts',
              bg: colors.bg,
              color: colors.color,
            ),
          ],
        ),
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  final String label;
  final bool active;
  final VoidCallback onTap;

  const _FilterChip({
    required this.label,
    required this.active,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(999),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
        decoration: BoxDecoration(
          color: active ? AppColors.primary : Colors.white,
          borderRadius: BorderRadius.circular(999),
          border: active ? null : Border.all(color: AppColors.border),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 12.5,
            fontWeight: FontWeight.w700,
            color: active ? Colors.white : AppColors.text700,
          ),
        ),
      ),
    );
  }
}

class _Student {
  final String name;
  final String initials;
  final String pathway;
  final int points;
  final bool atRisk;
  final bool epic;

  const _Student({
    required this.name,
    required this.initials,
    required this.pathway,
    required this.points,
    required this.atRisk,
    required this.epic,
  });
}
