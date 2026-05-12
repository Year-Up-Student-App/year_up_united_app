import 'package:flutter/material.dart';
import '../widgets/auth_widgets.dart';

class AccountSetupScreen extends StatefulWidget {
  final void Function() onBack;
  final void Function() onComplete;

  const AccountSetupScreen({
    super.key,
    required this.onBack,
    required this.onComplete,
  });

  @override
  State<AccountSetupScreen> createState() => _AccountSetupScreenState();
}

class _AccountSetupScreenState extends State<AccountSetupScreen> {
  final TextEditingController _pwCtrl = TextEditingController();
  final TextEditingController _confirmCtrl = TextEditingController();
  bool _showPassword = false;

  List<({String label, bool ok})> get _rules => [
    (label: 'At least 8 characters', ok: _pwCtrl.text.length >= 8),
    (label: 'One uppercase letter', ok: RegExp(r'[A-Z]').hasMatch(_pwCtrl.text)),
    (label: 'One number', ok: RegExp(r'[0-9]').hasMatch(_pwCtrl.text)),
    (label: 'One special character', ok: RegExp(r'[^A-Za-z0-9]').hasMatch(_pwCtrl.text)),
  ];

  int get _strength => _rules.where((r) => r.ok).length;

  bool get _matches => _pwCtrl.text.isNotEmpty && _pwCtrl.text == _confirmCtrl.text;
  bool get _canSubmit => _strength == 4 && _matches;

  Color get _strengthColor {
    switch (_strength) {
      case 1:
        return kDanger;
      case 2:
      case 3:
        return kOrange;
      case 4:
        return kSuccess;
      default:
        return kGray200;
    }
  }

  String get _strengthLabel {
    switch (_strength) {
      case 1:
        return 'Weak';
      case 2:
        return 'Fair';
      case 3:
        return 'Good';
      case 4:
        return 'Strong';
      default:
        return '';
    }
  }

  @override
  void dispose() {
    _pwCtrl.dispose();
    _confirmCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(24, 16, 24, 32),
          child: AnimatedBuilder(
            animation: Listenable.merge([_pwCtrl, _confirmCtrl]),
            builder: (context2, child2) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 8),
                AppBackButton(onPressed: widget.onBack),
                const SizedBox(height: 28),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: const Color(0xFFEEE9FB),
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: const Text(
                    'WELCOME TO CONNECT',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.5,
                      color: kPrimary,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  'Set a new password',
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.w800,
                    letterSpacing: -0.8,
                    color: kGray900,
                    height: 1.15,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Replace your temporary password so you can sign in next time without checking your email.',
                  style: TextStyle(
                    fontSize: 14.5,
                    color: kGray500,
                    fontWeight: FontWeight.w500,
                    height: 1.45,
                  ),
                ),
                const SizedBox(height: 28),
                const AppFieldLabel('New password'),
                AppTextField(
                  controller: _pwCtrl,
                  placeholder: 'Create a password',
                  obscureText: !_showPassword,
                  autofocus: true,
                  suffix: IconButton(
                    onPressed: () => setState(() => _showPassword = !_showPassword),
                    icon: Icon(
                      _showPassword ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                      size: 20,
                      color: kGray500,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                _buildStrengthBar(),
                if (_pwCtrl.text.isNotEmpty) ...[
                  const SizedBox(height: 4),
                  Text(
                    _strengthLabel,
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: _strengthColor),
                  ),
                ],
                const SizedBox(height: 12),
                _buildRequirements(),
                const SizedBox(height: 16),
                const AppFieldLabel('Confirm new password'),
                AppTextField(
                  controller: _confirmCtrl,
                  placeholder: 'Re-enter password',
                  obscureText: !_showPassword,
                  hasError: _confirmCtrl.text.isNotEmpty && !_matches,
                ),
                if (_confirmCtrl.text.isNotEmpty && !_matches) ...[
                  const SizedBox(height: 6),
                  const Text(
                    "Passwords don't match",
                    style: TextStyle(fontSize: 12, color: kDanger, fontWeight: FontWeight.w500),
                  ),
                ],
                const SizedBox(height: 24),
                AppPrimaryButton(
                  label: 'Save and continue',
                  onPressed: _canSubmit ? widget.onComplete : null,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStrengthBar() {
    return Row(
      children: List.generate(4, (i) {
        return Expanded(
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            height: 4,
            margin: EdgeInsets.only(right: i < 3 ? 4 : 0),
            decoration: BoxDecoration(
              color: i < _strength ? _strengthColor : kGray100,
              borderRadius: BorderRadius.circular(999),
            ),
          ),
        );
      }),
    );
  }

  Widget _buildRequirements() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: kGray50,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: _rules.map((rule) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Row(
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  width: 18,
                  height: 18,
                  decoration: BoxDecoration(
                    color: rule.ok ? kSuccess : kGray200,
                    shape: BoxShape.circle,
                  ),
                  child: rule.ok
                      ? const Icon(Icons.check, size: 12, color: Colors.white)
                      : null,
                ),
                const SizedBox(width: 8),
                Text(
                  rule.label,
                  style: TextStyle(
                    fontSize: 13,
                    color: rule.ok ? kGray900 : kGray500,
                    fontWeight: rule.ok ? FontWeight.w600 : FontWeight.w500,
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}