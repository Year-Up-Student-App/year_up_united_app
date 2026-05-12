import 'package:flutter/material.dart';

const kPrimary = Color(0xFF3D1D8C);
const kPrimaryDark = Color(0xFF2B1167);
const kAccent = Color(0xFFF25C3E);
const kOrange = Color(0xFFF8941F);
const kGray50 = Color(0xFFF7F7F9);
const kGray100 = Color(0xFFF0F0F4);
const kGray200 = Color(0xFFE5E5EC);
const kGray300 = Color(0xFFD2D2DC);
const kGray400 = Color(0xFFA8A8B3);
const kGray500 = Color(0xFF7A7A86);
const kGray700 = Color(0xFF41414A);
const kGray900 = Color(0xFF18181F);
const kDanger = Color(0xFFE04545);
const kSuccess = Color(0xFF2D9D6F);

class AppLogo extends StatelessWidget {
  final double size;
  const AppLogo({super.key, this.size = 56});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment(1.1, 1.1),
          colors: [kPrimary, kAccent],
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: kPrimary.withOpacity(0.25),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Center(
        child: Text(
          'C',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w800,
            fontSize: size * 0.43,
            letterSpacing: -0.5,
          ),
        ),
      ),
    );
  }
}

class AppTextField extends StatefulWidget {
  final TextEditingController controller;
  final String? placeholder;
  final TextInputType keyboardType;
  final bool obscureText;
  final bool autofocus;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onSubmit;
  final Widget? suffix;
  final bool hasError;

  const AppTextField({
    super.key,
    required this.controller,
    this.placeholder,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.autofocus = false,
    this.onChanged,
    this.onSubmit,
    this.suffix,
    this.hasError = false,
  });

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  final FocusNode _focus = FocusNode();
  bool _focused = false;

  @override
  void initState() {
    super.initState();
    _focus.addListener(() => setState(() => _focused = _focus.hasFocus));
  }

  @override
  void dispose() {
    _focus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final borderColor = widget.hasError
        ? kDanger
        : _focused
        ? kPrimary
        : kGray200;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: borderColor, width: 1.5),
        borderRadius: BorderRadius.circular(12),
        boxShadow: _focused && !widget.hasError
            ? [BoxShadow(color: kPrimary.withOpacity(0.1), blurRadius: 0, spreadRadius: 4)]
            : [],
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: widget.controller,
              focusNode: _focus,
              keyboardType: widget.keyboardType,
              obscureText: widget.obscureText,
              autofocus: widget.autofocus,
              onChanged: widget.onChanged,
              onSubmitted: widget.onSubmit != null ? (_) => widget.onSubmit!() : null,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: kGray900,
              ),
              decoration: InputDecoration(
                hintText: widget.placeholder,
                hintStyle: const TextStyle(color: kGray400),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
              ),
            ),
          ),
          if (widget.suffix != null) widget.suffix!,
        ],
      ),
    );
  }
}

class AppPrimaryButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;

  const AppPrimaryButton({super.key, required this.label, this.onPressed});

  @override
  Widget build(BuildContext context) {
    final enabled = onPressed != null;
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: enabled ? kPrimary : kGray300,
          foregroundColor: Colors.white,
          disabledBackgroundColor: kGray300,
          disabledForegroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 15),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
          elevation: 0,
        ),
        child: Text(
          label,
          style: const TextStyle(fontSize: 15.5, fontWeight: FontWeight.w700, letterSpacing: -0.1),
        ),
      ),
    );
  }
}

class AppFieldLabel extends StatelessWidget {
  final String text;
  const AppFieldLabel(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Text(
        text,
        style: const TextStyle(fontSize: 12.5, fontWeight: FontWeight.w600, color: kGray700),
      ),
    );
  }
}

class AppBackButton extends StatelessWidget {
  final VoidCallback onPressed;
  const AppBackButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 40,
        height: 40,
        decoration: const BoxDecoration(color: kGray100, shape: BoxShape.circle),
        child: const Icon(Icons.arrow_back_ios_new, size: 18, color: kGray900),
      ),
    );
  }
}