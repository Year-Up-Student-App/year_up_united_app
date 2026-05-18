import 'package:flutter/material.dart';
import '../../widgets/auth_widgets.dart';

class SignInEmailScreen extends StatefulWidget {
  final String initialEmail;
  final void Function(String email) onContinue;

  const SignInEmailScreen({
    super.key,
    this.initialEmail = '',
    required this.onContinue,
  });

  @override
  State<SignInEmailScreen> createState() => _SignInEmailScreenState();
}

class _SignInEmailScreenState extends State<SignInEmailScreen> {
  late final TextEditingController _ctrl;
  bool _isValid = false;

  @override
  void initState() {
    super.initState();
    _ctrl = TextEditingController(text: widget.initialEmail);
    _validate(widget.initialEmail);
  }

  void _validate(String v) {
    setState(() => _isValid = RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$').hasMatch(v.trim()));
  }

  void _submit() {
    if (_isValid) widget.onContinue(_ctrl.text.trim());
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
              const SizedBox(height: 24),
              const AppLogo(),
              const SizedBox(height: 28),
              const Text(
                'Welcome back',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w800,
                  letterSpacing: -0.8,
                  color: kGray900,
                  height: 1.1,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Sign in with the email Year Up United sent your Connect account to.',
                style: TextStyle(
                  fontSize: 15,
                  color: kGray500,
                  fontWeight: FontWeight.w500,
                  height: 1.45,
                ),
              ),
              const SizedBox(height: 32),
              const AppFieldLabel('Email'),
              AppTextField(
                controller: _ctrl,
                placeholder: 'kdillon@my.yearupunited.org',
                keyboardType: TextInputType.emailAddress,
                autofocus: true,
                onChanged: _validate,
                onSubmit: _submit,
              ),
              const SizedBox(height: 16),
              AppPrimaryButton(label: 'Continue', onPressed: _isValid ? _submit : null),
              const Spacer(),
              Center(
                child: TextButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(foregroundColor: kPrimary),
                  child: const Text(
                    'Need help signing in?',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              const Center(
                child: Text(
                  'By continuing you agree to our Terms & Privacy Policy.',
                  style: TextStyle(fontSize: 11.5, color: kGray400),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}