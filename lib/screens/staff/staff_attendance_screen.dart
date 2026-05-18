import 'package:flutter/material.dart';
import '../../../widgets/mobile_widgets.dart';

/// Staff Attendance tab — coach marks each student On / Tardy / Absent for
/// today's session, sees status counts, and submits.
class StaffAttendanceScreen extends StatefulWidget {
  const StaffAttendanceScreen({super.key});

  @override
  State<StaffAttendanceScreen> createState() => _StaffAttendanceScreenState();
}

class _StaffAttendanceScreenState extends State<StaffAttendanceScreen> {
  /// null = not yet marked
  static const _initial = <_AttendanceEntry>[
    _AttendanceEntry(name: 'Aisha Kone', initials: 'AK', status: _Status.on),
    _AttendanceEntry(name: 'Camila Reyes', initials: 'CR', status: _Status.on),
    _AttendanceEntry(name: 'Devon Park', initials: 'DP', status: _Status.tardy),
    _AttendanceEntry(name: 'Jordan Dawson', initials: 'JD', status: _Status.on),
    _AttendanceEntry(name: 'Marcus Boyd', initials: 'MB', status: _Status.on),
    _AttendanceEntry(
        name: 'Maya Robinson', initials: 'MR', status: _Status.absent),
    _AttendanceEntry(name: 'Sasha Klein', initials: 'SK', status: _Status.on),
    _AttendanceEntry(name: 'Tomas Chen', initials: 'TC', status: null),
  ];

  late List<_AttendanceEntry> _students = List.of(_initial);

  void _setStatus(int i, _Status s) {
    setState(() {
      _students[i] = _students[i].copyWith(status: s);
    });
  }

  int _countOf(_Status? s) =>
      _students.where((e) => e.status == s).length;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.bg,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const PhoneHeader(
            title: 'Attendance — May 14',
            subtitle: 'Wednesday · Cohort huddle',
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.only(bottom: 24),
              child: Transform.translate(
                offset: const Offset(0, -12),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _buildDateCard(),
                      const SizedBox(height: 14),
                      _buildCountsRow(),
                      const SizedBox(height: 12),
                      _buildStudentList(),
                      const SizedBox(height: 16),
                      _buildSubmitButton(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDateCard() {
    return AppCard(
      padding: const EdgeInsets.all(12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _DateNavButton(icon: Icons.chevron_left, onTap: () {}),
          const Column(
            children: [
              Text(
                'WEDNESDAY',
                style: TextStyle(
                  fontSize: 12,
                  color: AppColors.text500,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.4,
                ),
              ),
              SizedBox(height: 2),
              Text(
                'May 14, 2026',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w800,
                  color: AppColors.text900,
                  letterSpacing: -0.2,
                ),
              ),
            ],
          ),
          _DateNavButton(icon: Icons.chevron_right, onTap: () {}),
        ],
      ),
    );
  }

  Widget _buildCountsRow() {
    return DefaultTextStyle(
      style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _CountChip(
            label: '${_countOf(_Status.on)} on time',
            color: AppColors.success,
          ),
          _CountChip(
            label: '${_countOf(_Status.tardy)} tardy',
            color: AppColors.warn,
          ),
          _CountChip(
            label: '${_countOf(_Status.absent)} absent',
            color: AppColors.danger,
          ),
          _CountChip(
            label: '${_countOf(null)} pending',
            color: AppColors.text500,
          ),
        ],
      ),
    );
  }

  Widget _buildStudentList() {
    return AppCard(
      padding: EdgeInsets.zero,
      child: Column(
        children: [
          for (var i = 0; i < _students.length; i++)
            _buildStudentRow(i, isLast: i == _students.length - 1),
        ],
      ),
    );
  }

  Widget _buildStudentRow(int i, {required bool isLast}) {
    final s = _students[i];
    return Container(
      padding: const EdgeInsets.fromLTRB(12, 10, 12, 10),
      decoration: BoxDecoration(
        border: isLast
            ? null
            : const Border(
                bottom: BorderSide(color: AppColors.borderLight),
              ),
      ),
      child: Row(
        children: [
          Avatar(initials: s.initials, color: AppColors.purpleSoft, size: 32),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              s.name,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 13.5,
                fontWeight: FontWeight.w600,
                color: AppColors.text900,
              ),
            ),
          ),
          _AttBtn(
            active: s.status == _Status.on,
            label: 'On',
            color: AppColors.success,
            bg: AppColors.successBg,
            onTap: () => _setStatus(i, _Status.on),
          ),
          const SizedBox(width: 4),
          _AttBtn(
            active: s.status == _Status.tardy,
            label: 'Tar',
            color: AppColors.warn,
            bg: AppColors.warnBg,
            onTap: () => _setStatus(i, _Status.tardy),
          ),
          const SizedBox(width: 4),
          _AttBtn(
            active: s.status == _Status.absent,
            label: 'Abs',
            color: AppColors.danger,
            bg: AppColors.dangerBg,
            onTap: () => _setStatus(i, _Status.absent),
          ),
        ],
      ),
    );
  }

  Widget _buildSubmitButton() {
    return InkWell(
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Attendance submitted')),
        );
      },
      borderRadius: BorderRadius.circular(14),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14),
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
        child: const Text(
          'Submit attendance',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: 15,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}

class _DateNavButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  const _DateNavButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(999),
      child: Container(
        width: 32,
        height: 32,
        decoration: const BoxDecoration(
          color: AppColors.surfaceAlt,
          shape: BoxShape.circle,
        ),
        alignment: Alignment.center,
        child: Icon(icon, size: 16, color: AppColors.text700),
      ),
    );
  }
}

class _CountChip extends StatelessWidget {
  final String label;
  final Color color;
  const _CountChip({required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 6,
          height: 6,
          margin: const EdgeInsets.only(right: 4),
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        Text(
          label,
          style: TextStyle(
            color: color,
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}

/// Three-state attendance button (On / Tar / Abs).
class _AttBtn extends StatelessWidget {
  final bool active;
  final String label;
  final Color color;
  final Color bg;
  final VoidCallback onTap;

  const _AttBtn({
    required this.active,
    required this.label,
    required this.color,
    required this.bg,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 100),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        constraints: const BoxConstraints(minWidth: 36),
        decoration: BoxDecoration(
          color: active ? color : bg,
          borderRadius: BorderRadius.circular(8),
        ),
        alignment: Alignment.center,
        child: Text(
          label,
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w800,
            color: active ? Colors.white : color,
          ),
        ),
      ),
    );
  }
}

enum _Status { on, tardy, absent }

class _AttendanceEntry {
  final String name;
  final String initials;
  final _Status? status;
  const _AttendanceEntry({
    required this.name,
    required this.initials,
    required this.status,
  });

  _AttendanceEntry copyWith({_Status? status}) {
    return _AttendanceEntry(
      name: name,
      initials: initials,
      status: status,
    );
  }
}
