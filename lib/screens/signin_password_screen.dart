import 'package:flutter/material.dart';
import '../widgets/auth_widgets.dart';
import '../services/api_service.dart';

class SignInPasswordScreen extends StatefulWidget {
  final String email;
  final void Function() onBack;
  final void Function() onSetupPassword;
  // Called when login succeeds — passes token and role back to main.dart
  final void Function(String token, String role) onSuccess;

  const SignInPasswordScreen({
    super.key,
    required this.email,
    required this.onBack,
    required this.onSetupPassword,
    required this.onSuccess,
  });

  @override
  State<SignInPasswordScreen> createState() => _SignInPasswordScreenState();
}

class _SignInPasswordScreenState extends State<SignInPasswordScreen> {
  final TextEditingController _ctrl = TextEditingController();
  bool _showPassword = false;
  bool _isLoading = false;
  String? _errorMessage;

  String get _initials {
    final parts = widget.email.split('@').first.split('.');
    if (parts.length >= 2) {
      return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
    }
    return widget.email.isNotEmpty ? widget.email[0].toUpperCase() : 'JD';
  }

  Future<void> _handleSignIn() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final result = await ApiService.login(widget.email, _ctrl.text);

      final token = result['token'] as String;
      final role = result['role'] as String;

      if (!mounted) return;

      // Pass token and role back to _AuthWrapper in main.dart
      widget.onSuccess(token, role);

    } catch (e) {
      setState(() {
        _errorMessage = 'Invalid email or password';
        _isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 16, 24, 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 8),
              AppBackButton(onPressed: widget.onBack),
              const SizedBox(height: 32),
              const Text(
                'Enter your password',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w800,
                  letterSpacing: -0.8,
                  color: kGray900,
                  height: 1.1,
                ),
              ),
              const SizedBox(height: 14),
              _buildEmailPill(),
              const SizedBox(height: 28),
              const AppFieldLabel('Password'),
              ValueListenableBuilder<TextEditingValue>(
                valueListenable: _ctrl,
                builder: (ctx, val, child) => AppTextField(
                  controller: _ctrl,
                  placeholder: '••••••••',
                  obscureText: !_showPassword,
                  autofocus: true,
                  onSubmit: val.text.isNotEmpty && !_isLoading ? _handleSignIn : null,
                  suffix: IconButton(
                    onPressed: () => setState(() => _showPassword = !_showPassword),
                    icon: Icon(
                      _showPassword ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                      size: 20,
                      color: kGray500,
                    ),
                  ),
                ),
              ),
              // Shows red error text if login fails
              if (_errorMessage != null)
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Text(
                    _errorMessage!,
                    style: const TextStyle(
                      color: Colors.red,
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              const SizedBox(height: 4),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(foregroundColor: kPrimary, padding: EdgeInsets.zero),
                  child: const Text('Forgot password?', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
                ),
              ),
              const SizedBox(height: 8),
              ValueListenableBuilder<TextEditingValue>(
                valueListenable: _ctrl,
                builder: (ctx2, val, child2) => AppPrimaryButton(
                  label: _isLoading ? 'Signing in...' : 'Sign in',
                  onPressed: val.text.isNotEmpty && !_isLoading ? _handleSignIn : null,
                ),
              ),
              const SizedBox(height: 24),
              _buildFirstTimeCard(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEmailPill() {
    return Container(
      padding: const EdgeInsets.fromLTRB(6, 6, 12, 6),
      decoration: BoxDecoration(
        color: kGray50,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 24,
            height: 24,
            decoration: const BoxDecoration(color: kAccent, shape: BoxShape.circle),
            child: Center(
              child: Text(
                _initials,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 9.5,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          Flexible(
            child: Text(
              widget.email,
              style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: kGray700),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(width: 8),
          GestureDetector(
            onTap: widget.onBack,
            child: const Text(
              'Switch',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: kPrimary),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFirstTimeCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF7F4FE),
        border: Border.all(color: kPrimary.withOpacity(0.13)),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
            child: const Icon(Icons.shield_outlined, size: 18, color: kPrimary),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'First time signing in?',
                  style: TextStyle(fontSize: 13.5, fontWeight: FontWeight.w700, color: kGray900),
                ),
                const SizedBox(height: 2),
                const Text(
                  'Use the temporary password from your welcome email to set a permanent one.',
                  style: TextStyle(fontSize: 12.5, color: kGray700, height: 1.45),
                ),
                const SizedBox(height: 8),
                GestureDetector(
                  onTap: widget.onSetupPassword,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Text(
                        'Set up my password',
                        style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: kPrimary),
                      ),
                      SizedBox(width: 4),
                      Icon(Icons.arrow_forward_ios, size: 12, color: kPrimary),
                    ],
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