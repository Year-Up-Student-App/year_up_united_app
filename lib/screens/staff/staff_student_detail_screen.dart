import 'package:flutter/material.dart';
import '../../widgets/mobile_widgets.dart';

/// Staff view of a single student's record. Reached from the staff Home
/// at-risk list or from the Roster screen. Lets the coach:
///   • Adjust contract points (+/- buttons)
///   • Log an infraction / award bonus points / send kudos
///   • View past kudos
///   • See attendance, EPIC plan, contact info
///
/// The kudos compose action opens a modal bottom sheet with templates.
class StaffStudentDetailScreen extends StatefulWidget {
  final String studentName;
  final String initials;
  final String pathway;
  final int startingPoints;

  const StaffStudentDetailScreen({
    super.key,
    this.studentName = 'Jordan Dawson',
    this.initials = 'JD',
    this.pathway = 'App Dev · Dallas LC · Week 18',
    this.startingPoints = 247,
  });

  @override
  State<StaffStudentDetailScreen> createState() =>
      _StaffStudentDetailScreenState();
}

class _StaffStudentDetailScreenState extends State<StaffStudentDetailScreen> {
  late int _points = widget.startingPoints;
  final List<_Kudos> _kudos = [
    const _Kudos(
      from: 'You',
      date: '2d ago',
      msg: 'Strong start to the week — showed up early Monday and helped set '
          'up the room.',
    ),
  ];

  void _adjustPoints(int delta) {
    setState(() {
      _points = (_points + delta).clamp(0, 250);
    });
  }

  void _openKudosSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => _KudosComposeSheet(
        studentName: widget.studentName,
        onSend: (text) {
          setState(() {
            _kudos.insert(
              0,
              _Kudos(from: 'You', date: 'Just now', msg: text),
            );
          });
        },
      ),
    );
  }

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
              title: widget.studentName,
              subtitle: 'Student detail · staff view',
              onBack: () => Navigator.of(context).pop(),
            ),
            Transform.translate(
              offset: const Offset(0, -8),
              child: _buildAvatarHero(),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 14, 16, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SectionLabel(
                    'Contract points',
                    trailing: const Pill(
                      label: 'STAFF EDIT',
                      bg: AppColors.purpleSoft,
                      color: AppColors.primary,
                    ),
                  ),
                  _buildPointsCard(),
                  SectionLabel(
                    'Kudos sent',
                    trailing: TextButton.icon(
                      onPressed: _openKudosSheet,
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                        minimumSize: const Size(0, 0),
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      icon: const Icon(Icons.add,
                          size: 12, color: AppColors.primary),
                      label: const Text(
                        'Give kudos',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                  ),
                  _buildKudosList(),
                  const SectionLabel('Program status'),
                  _buildStatusGrid(),
                  SectionLabel(
                    'EPIC Plan',
                    trailing: TextButton(
                      onPressed: () {},
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                        minimumSize: const Size(0, 0),
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      child: const Text(
                        '+ New plan',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                  ),
                  _buildEpicCard(),
                  const SectionLabel('Attendance notes'),
                  _buildAttendanceNotesCard(),
                  const SectionLabel('Contact'),
                  _buildContactCard(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAvatarHero() {
    return Container(
      padding: const EdgeInsets.fromLTRB(22, 0, 22, 24),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [AppColors.primary, AppColors.primaryDark],
        ),
      ),
      child: Column(
        children: [
          Avatar(
            initials: widget.initials,
            color: AppColors.accent,
            size: 72,
          ),
          const SizedBox(height: 10),
          Text(
            widget.studentName,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w800,
              letterSpacing: -0.4,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            widget.pathway,
            style: const TextStyle(
              color: Color(0xC7FFFFFF),
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPointsCard() {
    return AppCard(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      Text(
                        '$_points',
                        style: const TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w800,
                          color: AppColors.text900,
                          letterSpacing: -0.8,
                        ),
                      ),
                      const Text(
                        '/250',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: AppColors.text500,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 2),
                  const Text(
                    'This week',
                    style: TextStyle(
                      fontSize: 12,
                      color: AppColors.text500,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  _SquareIconButton(
                    icon: Icons.remove,
                    bg: AppColors.dangerBg,
                    fg: AppColors.danger,
                    onTap: () => _adjustPoints(-1),
                  ),
                  const SizedBox(width: 8),
                  _SquareIconButton(
                    icon: Icons.add,
                    bg: AppColors.successBg,
                    fg: AppColors.success,
                    onTap: () => _adjustPoints(1),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              Expanded(
                child: _ActionButton(
                  icon: Icons.warning_amber_rounded,
                  label: 'Infraction',
                  bg: AppColors.dangerBg,
                  fg: AppColors.danger,
                  onTap: () {},
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _ActionButton(
                  icon: Icons.emoji_events_outlined,
                  label: 'Award pts',
                  bg: AppColors.successBg,
                  fg: AppColors.success,
                  onTap: () {},
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _ActionButton(
                  icon: Icons.star_outline,
                  label: 'Kudos',
                  // ignore: deprecated_member_use
                  bg: AppColors.primary.withOpacity(0.08),
                  fg: AppColors.primary,
                  onTap: _openKudosSheet,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildKudosList() {
    if (_kudos.isEmpty) {
      return const AppCard(
        padding: EdgeInsets.all(20),
        child: Center(
          child: Text(
            'No kudos yet. Recognize their effort with a quick note.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 13,
              color: AppColors.text500,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      );
    }
    return AppCard(
      padding: EdgeInsets.zero,
      child: Column(
        children: [
          for (var i = 0; i < _kudos.length; i++)
            _buildKudosRow(_kudos[i], isLast: i == _kudos.length - 1),
        ],
      ),
    );
  }

  Widget _buildKudosRow(_Kudos k, {required bool isLast}) {
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [AppColors.primary, AppColors.accent],
              ),
            ),
            alignment: Alignment.center,
            child: const Text('⭐', style: TextStyle(fontSize: 14)),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        'FROM ${k.from.toUpperCase()}',
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: AppColors.primary,
                          letterSpacing: 0.3,
                        ),
                      ),
                    ),
                    Text(
                      k.date,
                      style: const TextStyle(
                        fontSize: 11,
                        color: AppColors.text400,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  k.msg,
                  style: const TextStyle(
                    fontSize: 13,
                    color: AppColors.text900,
                    fontWeight: FontWeight.w500,
                    height: 1.45,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusGrid() {
    return Column(
      children: [
        Row(
          children: const [
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
                label: 'EPIC plan',
                value: 'None active',
                tone: AppColors.text500,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          children: const [
            Expanded(
              child: StatusTile(
                label: 'WBE status',
                value: 'In progress',
                tone: AppColors.primary,
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: StatusTile(
                label: 'Tardies',
                value: '1 this week',
                tone: AppColors.warn,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildEpicCard() {
    return const AppCard(
      padding: EdgeInsets.all(14),
      child: Row(
        children: [
          Icon(Icons.adjust, size: 20, color: AppColors.text500),
          SizedBox(width: 10),
          Text(
            'No active plan',
            style: TextStyle(
              fontSize: 13.5,
              fontWeight: FontWeight.w600,
              color: AppColors.text700,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAttendanceNotesCard() {
    return AppCard(
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'May 6: Tardy excused — bus delay, photo evidence submitted.',
            style: TextStyle(
              fontSize: 13,
              color: AppColors.text700,
              fontWeight: FontWeight.w500,
              height: 1.55,
            ),
          ),
          const SizedBox(height: 10),
          InkWell(
            onTap: () {},
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Icon(Icons.add, size: 14, color: AppColors.primary),
                SizedBox(width: 4),
                Text(
                  'Add note',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: AppColors.primary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactCard() {
    return const AppCard(
      padding: EdgeInsets.zero,
      child: Column(
        children: [
          InfoRow(
            icon: Icons.mail_outline,
            label: 'Email',
            value: 'jordan.dawson@yearup.org',
          ),
          InfoRow(
            icon: Icons.phone_outlined,
            label: 'Phone',
            value: '(214) 555-2841',
            isLast: true,
          ),
        ],
      ),
    );
  }
}

class _SquareIconButton extends StatelessWidget {
  final IconData icon;
  final Color bg;
  final Color fg;
  final VoidCallback onTap;

  const _SquareIconButton({
    required this.icon,
    required this.bg,
    required this.fg,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(12),
        ),
        alignment: Alignment.center,
        child: Icon(icon, size: 18, color: fg),
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color bg;
  final Color fg;
  final VoidCallback onTap;

  const _ActionButton({
    required this.icon,
    required this.label,
    required this.bg,
    required this.fg,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 14, color: fg),
            const SizedBox(width: 4),
            Flexible(
              child: Text(
                label,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 12.5,
                  fontWeight: FontWeight.w700,
                  color: fg,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Modal bottom sheet for composing a kudos. Shows quick-template chips,
/// a 280-char textarea, and a Send button. Calls [onSend] with the text.
class _KudosComposeSheet extends StatefulWidget {
  final String studentName;
  final ValueChanged<String> onSend;

  const _KudosComposeSheet({
    required this.studentName,
    required this.onSend,
  });

  @override
  State<_KudosComposeSheet> createState() => _KudosComposeSheetState();
}

class _KudosComposeSheetState extends State<_KudosComposeSheet> {
  static const _templates = [
    'Showed up early today — appreciate it.',
    'Loved your energy in the huddle.',
    'Real growth this week. Keep it up.',
    'Great teamwork on the pair exercise.',
  ];
  late final TextEditingController _ctrl = TextEditingController();
  String _text = '';

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  void _setTemplate(String t) {
    setState(() {
      _ctrl.text = t;
      _ctrl.selection = TextSelection.fromPosition(
        TextPosition(offset: _ctrl.text.length),
      );
      _text = t;
    });
  }

  void _send() {
    final v = _text.trim();
    if (v.isEmpty) return;
    widget.onSend(v);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final canSend = _text.trim().isNotEmpty;
    // Pad the sheet for the keyboard.
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;
    return Padding(
      padding: EdgeInsets.only(bottom: bottomInset),
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Container(
                width: 36,
                height: 4,
                decoration: BoxDecoration(
                  color: const Color(0xFFD2D2DC),
                  borderRadius: BorderRadius.circular(999),
                ),
              ),
            ),
            const SizedBox(height: 14),
            Row(
              children: [
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [AppColors.primary, AppColors.accent],
                    ),
                  ),
                  alignment: Alignment.center,
                  child: const Text('⭐', style: TextStyle(fontSize: 18)),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Send kudos',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w800,
                          color: AppColors.text900,
                          letterSpacing: -0.3,
                        ),
                      ),
                      Text(
                        "To ${widget.studentName} · won't affect points",
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: AppColors.text500,
                        ),
                      ),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () => Navigator.of(context).pop(),
                  borderRadius: BorderRadius.circular(999),
                  child: Container(
                    width: 32,
                    height: 32,
                    decoration: const BoxDecoration(
                      color: AppColors.surfaceAlt,
                      shape: BoxShape.circle,
                    ),
                    alignment: Alignment.center,
                    child: const Icon(
                      Icons.close,
                      size: 16,
                      color: AppColors.text700,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),
            TextField(
              controller: _ctrl,
              maxLength: 280,
              maxLines: 5,
              minLines: 4,
              onChanged: (v) => setState(() => _text = v),
              decoration: InputDecoration(
                hintText: 'What did ${widget.studentName.split(' ').first} '
                    'do well? Be specific — call out the moment.',
                hintStyle: const TextStyle(
                  color: AppColors.text400,
                  fontWeight: FontWeight.w500,
                ),
                filled: true,
                fillColor: Colors.white,
                counterText: '',
                contentPadding: const EdgeInsets.all(14),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(
                    color: AppColors.border,
                    width: 1.5,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(
                    color: AppColors.border,
                    width: 1.5,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(
                    color: AppColors.primary,
                    width: 1.5,
                  ),
                ),
              ),
              style: const TextStyle(
                fontSize: 14,
                color: AppColors.text900,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Visible on ${widget.studentName.split(' ').first}'s "
                  'contract',
                  style: const TextStyle(
                    fontSize: 11,
                    color: AppColors.text500,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  '${_text.length}/280',
                  style: const TextStyle(
                    fontSize: 11,
                    color: AppColors.text400,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 18),
            const Text(
              'QUICK TEMPLATES',
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w700,
                color: AppColors.text500,
                letterSpacing: 0.4,
              ),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                for (final t in _templates)
                  InkWell(
                    onTap: () => _setTemplate(t),
                    borderRadius: BorderRadius.circular(999),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 7),
                      decoration: BoxDecoration(
                        color: AppColors.bg,
                        borderRadius: BorderRadius.circular(999),
                        border: Border.all(color: AppColors.border),
                      ),
                      child: Text(
                        t,
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: AppColors.text700,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 20),
            InkWell(
              onTap: canSend ? _send : null,
              borderRadius: BorderRadius.circular(14),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 14),
                decoration: BoxDecoration(
                  color: canSend ? AppColors.primary : const Color(0xFFD2D2DC),
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: canSend
                      ? [
                          BoxShadow(
                            // ignore: deprecated_member_use
                            color: AppColors.primary.withOpacity(0.25),
                            blurRadius: 16,
                            offset: const Offset(0, 6),
                          ),
                        ]
                      : null,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.star_outline, size: 16, color: Colors.white),
                    SizedBox(width: 6),
                    Text(
                      'Send kudos',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                      ),
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
}

class _Kudos {
  final String from;
  final String date;
  final String msg;
  const _Kudos({required this.from, required this.date, required this.msg});
}
