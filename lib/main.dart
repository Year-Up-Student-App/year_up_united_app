import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'screens/signin_email_screen.dart';
import 'screens/signin_password_screen.dart';
import 'screens/account_setup_screen.dart';
import 'screens/home_screen.dart';
import 'screens/contract_screen.dart';
import 'screens/attendance_screen.dart';
import 'screens/connections_screen.dart';
import 'screens/profile_screen.dart';
import 'widgets/bottom_nav.dart';
import 'widgets/more_bottom_sheet.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.light,
  ));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Connect — Year Up United',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF3D1D8C)),
        useMaterial3: true,
      ),
      home: const _AuthWrapper(),
    );
  }
}

enum _AuthStep { email, password, accountSetup, authenticated }

class _AuthWrapper extends StatefulWidget {
  const _AuthWrapper();

  @override
  State<_AuthWrapper> createState() => _AuthWrapperState();
}

class _AuthWrapperState extends State<_AuthWrapper> {
  _AuthStep _step = _AuthStep.email;
  String _email = 'jordan.dawson@yearup.org';

  void _goTo(_AuthStep step) => setState(() => _step = step);

  @override
  Widget build(BuildContext context) {
    switch (_step) {
      case _AuthStep.email:
        return SignInEmailScreen(
          initialEmail: _email,
          onContinue: (email) {
            setState(() {
              _email = email;
              _step = _AuthStep.password;
            });
          },
        );

      case _AuthStep.password:
        return SignInPasswordScreen(
          email: _email,
          onBack: () => _goTo(_AuthStep.email),
          onSubmit: () => _goTo(_AuthStep.authenticated),
          onSetupPassword: () => _goTo(_AuthStep.accountSetup),
        );

      case _AuthStep.accountSetup:
        return AccountSetupScreen(
          onBack: () => _goTo(_AuthStep.password),
          onComplete: () => _goTo(_AuthStep.authenticated),
        );

      case _AuthStep.authenticated:
        return MainLayout(
          onSignOut: () {
            setState(() {
              _step = _AuthStep.email;
            });
          },
        );
    }
  }
}

class MainLayout extends StatefulWidget {
  final VoidCallback onSignOut;
  const MainLayout({super.key, required this.onSignOut});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const HomeScreen(),
    const ContractScreen(),
    const AttendanceScreen(),
    const ConnectionsScreen(),
  ];

  void _onTabSelected(int index) {
    if (index == 4) {
      showMoreBottomSheet(
        context,
        onSignOut: widget.onSignOut,
        onViewProfile: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => const ProfileScreen()),
          );
        },
      );
      return;
    }
    setState(() => _selectedIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNav(
        selectedIndex: _selectedIndex,
        onTabSelected: _onTabSelected,
      ),
    );
  }
}